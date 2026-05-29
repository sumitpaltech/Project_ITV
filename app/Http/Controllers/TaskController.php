<?php

namespace App\Http\Controllers;

use App\Models\Task;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Str;
use PhpOffice\PhpSpreadsheet\IOFactory;

class TaskController extends Controller
{
    private const ALLOWED_EXTENSIONS = ['pdf','doc','docx','xlsx','xls','jpg','jpeg','png','txt','zip'];
    private const MAX_FILE_SIZE      = 10 * 1024 * 1024; // 10 MB
    private const PER_PAGE           = 20;

    // ---------------------------------------------------------------
    // Authorization helpers (mirror Python is_authorized / is_user_dept_head)
    // ---------------------------------------------------------------
    private function isDepartmentHead(?string $username, ?string $department): bool
    {
        if (! $username || ! $department) return false;
        $heads = config('departments.heads', []);
        return ($heads[$department] ?? null) === $username;
    }

    private function isAuthorized($task): bool
    {
        if (! $task) return false;

        $userRole = strtolower(trim(Session::get('role', '')));
        $userName = Session::get('username') ?? Session::get('user_name');

        if ($userRole === 'admin') return true;

        $taskDept = is_array($task) ? ($task['department'] ?? null) : $task->department;
        if ($this->isDepartmentHead($userName, $taskDept)) return true;

        $assignedTo = is_array($task) ? ($task['assigned_to'] ?? null) : $task->assigned_to;
        return $assignedTo === $userName;
    }

    private function uploadFolder(): string
    {
        $path = public_path('uploads');
        if (! is_dir($path)) {
            mkdir($path, 0755, true);
        }
        return $path;
    }

    private function isAllowedFile(string $filename): bool
    {
        if (! str_contains($filename, '.')) return false;
        $ext = strtolower(pathinfo($filename, PATHINFO_EXTENSION));
        return in_array($ext, self::ALLOWED_EXTENSIONS, true);
    }

    /**
     * Make a safe filename — Laravel equivalent of Python's secure_filename().
     */
    private function safeFilename(string $name): string
    {
        $ext  = strtolower(pathinfo($name, PATHINFO_EXTENSION));
        $base = pathinfo($name, PATHINFO_FILENAME);
        $base = Str::slug($base, '_');
        return $base . ($ext ? ('.' . $ext) : '');
    }

    // ---------------------------------------------------------------
    // GET /tasks — list with filters + pagination
    // ---------------------------------------------------------------
    public function index(Request $request)
    {
        $userName = Session::get('username') ?? Session::get('user_name');
        $userRole = strtolower(trim(Session::get('role', '')));
        $userDept = Session::get('department');

        $filters = [
            'title'       => trim($request->input('title', '')),
            'assigned_to' => trim($request->input('assigned_to', '')),
            'department'  => trim($request->input('department', '')),
            'status'      => trim($request->input('status', '')),
            'priority'    => trim($request->input('priority', '')),
            'start_date'  => trim($request->input('start_date', '')),
            'end_date'    => trim($request->input('end_date', '')),
        ];

        $page    = max(1, (int) $request->input('page', 1));
        $perPage = self::PER_PAGE;
        $offset  = ($page - 1) * $perPage;

        // Force department / assigned_to restriction by role
        if ($userRole !== 'admin') {
            if ($this->isDepartmentHead($userName, $userDept)) {
                $filters['department'] = $userDept;
            } else {
                $filters['assigned_to'] = $userName;
            }
        }

        $tasksQuery = Task::withAssignedUser()->applyFilters($filters);

        $totalTasks = (clone $tasksQuery)->count('task_tracker.id');

        $tasks = $tasksQuery
            ->orderByDesc('task_tracker.created_at')
            ->skip($offset)
            ->take($perPage)
            ->get();

        // Status summary
        $statsRaw = DB::table('task_tracker')
            ->select('status', DB::raw('COUNT(*) as total'))
            ->when($filters['title'],       fn($q) => $q->where('title', 'like', "%{$filters['title']}%"))
            ->when($filters['assigned_to'], fn($q) => $q->where('assigned_to', $filters['assigned_to']))
            ->when($filters['department'],  fn($q) => $q->where('department', $filters['department']))
            ->when($filters['status'],      fn($q) => $q->where('status', $filters['status']))
            ->when($filters['priority'],    fn($q) => $q->where('priority', $filters['priority']))
            ->when($filters['start_date'],  fn($q) => $q->where('due_date', '>=', $filters['start_date']))
            ->when($filters['end_date'],    fn($q) => $q->where('due_date', '<=', $filters['end_date']))
            ->groupBy('status')
            ->get()
            ->map(fn($r) => ['status' => $r->status, 'total' => (int)$r->total]);

        $statusMap   = $statsRaw->pluck('total', 'status')->toArray();
        $completed   = $statusMap['completed']   ?? 0;
        $pending     = $statusMap['pending']     ?? 0;
        $inProgress  = $statusMap['in_progress'] ?? 0;
        $total       = $totalTasks;

        $summary = [
            'total'           => $total,
            'completed'       => $completed,
            'pending'         => $pending,
            'in_progress'     => $inProgress,
            'completed_pct'   => $total ? round(($completed   / $total) * 100, 2) : 0,
            'pending_pct'     => $total ? round(($pending     / $total) * 100, 2) : 0,
            'in_progress_pct' => $total ? round(($inProgress  / $total) * 100, 2) : 0,
        ];

        $totalPages = (int) ceil($totalTasks / $perPage);
        $pagination = [
            'page'        => $page,
            'per_page'    => $perPage,
            'total_tasks' => $totalTasks,
            'total_pages' => $totalPages,
            'has_next'    => $page < $totalPages,
            'has_prev'    => $page > 1,
            'next_page'   => $page < $totalPages ? $page + 1 : null,
            'prev_page'   => $page > 1 ? $page - 1 : null,
        ];

        // Distinct filter options
        $departments = Task::whereNotNull('department')->distinct()->pluck('department')->filter()->values();
        $users       = Task::whereNotNull('assigned_to')->distinct()->pluck('assigned_to')->filter()->values();
        $statuses    = Task::distinct()->pluck('status')->filter()->values();
        $priorities  = Task::distinct()->pluck('priority')->filter()->values();

        return view('tasks.index', [
            'tasks'       => $tasks,
            'stats'       => $statsRaw,
            'pagination'  => $pagination,
            'summary'     => $summary,
            'departments' => $departments,
            'users'       => $users,
            'statuses'    => $statuses,
            'priorities'  => $priorities,
        ]);
    }

    // ---------------------------------------------------------------
    // GET /tasks/create
    // ---------------------------------------------------------------
    public function create()
    {
        return view('tasks.create', [
            'departments' => config('departments.list'),
        ]);
    }

    // ---------------------------------------------------------------
    // POST /tasks/store
    // ---------------------------------------------------------------
    public function store(Request $request)
    {
        $userRole = strtolower(trim(Session::get('role', '')));

        $data = [
            'title'           => trim($request->input('title', '')),
            'description'     => trim($request->input('description', '')),
            'category'        => $request->input('category', 'General'),
            'department'      => trim($request->input('department', '')),
            'assigned_to'     => $userRole === 'admin'
                                    ? trim($request->input('assigned_to', ''))
                                    : Session::get('username'),
            'user_mail'       => $userRole === 'admin'
                                    ? trim($request->input('user_mail', ''))
                                    : Session::get('email'),
            'team_member'     => trim($request->input('team_member', '')),
            'priority'        => $request->input('priority', 'medium'),
            'start_date'      => $request->input('start_date') ?: null,
            'due_date'        => $request->input('due_date') ?: null,
            'completion_date' => $request->input('completion_date') ?: null,
            'status'          => $request->input('status', 'pending'),
            'remarks'         => trim($request->input('remarks', '')),
        ];

        if (! $data['title']) {
            return redirect()->route('task.create')->with('flash_danger', 'Title is required.');
        }

        Task::create($data);
        return redirect()->route('task.index')->with('flash_success', 'Task created successfully!');
    }

    // ---------------------------------------------------------------
    // GET /tasks/{id}
    // ---------------------------------------------------------------
    public function show(int $id)
    {
        $task = Task::leftJoin('users', 'task_tracker.assigned_to', '=', 'users.username')
            ->select('task_tracker.*', 'users.name as user_name', 'users.email as assigned_email')
            ->where('task_tracker.id', $id)
            ->first();

        if (! $this->isAuthorized($task)) {
            return redirect()->route('task.index')->with('flash_danger', 'Task not found.');
        }
        return view('tasks.show', compact('task'));
    }

    // ---------------------------------------------------------------
    // GET /tasks/{id}/edit
    // ---------------------------------------------------------------
    public function edit(int $id)
    {
        $task = Task::find($id);
        if (! $this->isAuthorized($task)) {
            return redirect()->route('task.index')->with('flash_danger', 'Task not found.');
        }
        return view('tasks.edit', [
            'task' => $task,
            'departments' => config('departments.list'),
        ]);
    }

    // ---------------------------------------------------------------
    // POST /tasks/{id}/update
    // ---------------------------------------------------------------
    public function update(Request $request, int $id)
    {
        $task = Task::find($id);
        if (! $this->isAuthorized($task)) {
            return redirect()->route('task.index')->with('flash_danger', 'Task not found.');
        }

        $userRole = strtolower(trim(Session::get('role', '')));

        $title = trim($request->input('title', ''));
        if (! $title) {
            return redirect()->route('task.edit', $id)->with('flash_danger', 'Title is required.');
        }

        $data = [
            'title'           => $title,
            'description'     => trim($request->input('description', '')),
            'category'        => $request->input('category', 'General'),
            'department'      => trim($request->input('department', '')),
            'assigned_to'     => $userRole === 'admin' ? trim($request->input('assigned_to', '')) : $task->assigned_to,
            'user_mail'       => $userRole === 'admin' ? trim($request->input('user_mail', ''))   : $task->user_mail,
            'team_member'     => trim($request->input('team_member', '')),
            'priority'        => $request->input('priority', 'medium'),
            'status'          => $request->input('status', 'pending'),
            'start_date'      => $userRole === 'admin' ? ($request->input('start_date') ?: null)      : $task->start_date,
            'due_date'        => $userRole === 'admin' ? ($request->input('due_date') ?: null)        : $task->due_date,
            'completion_date' => $userRole === 'admin' ? ($request->input('completion_date') ?: null) : $task->completion_date,
            'remarks'         => trim($request->input('remarks', '')),
        ];

        $task->update($data);

        // Handle file attachment if present
        if ($request->hasFile('file_upload')) {
            $file = $request->file('file_upload');
            if ($file->isValid() && $this->isAllowedFile($file->getClientOriginalName())) {
                if ($file->getSize() > self::MAX_FILE_SIZE) {
                    return redirect()->route('task.edit', $id)->with('flash_danger', 'File size exceeds 10 MB limit.');
                }
                $filename = $this->safeFilename('task_' . $id . '_' . $file->getClientOriginalName());
                $file->move($this->uploadFolder(), $filename);

                // Replaces file_attachment (single file) — matches Python update_file_attachment
                $task->update(['file_attachment' => $filename]);

                return redirect()->route('task.index')->with('flash_success', 'Task and file updated successfully!');
            }
        }

        return redirect()->route('task.index')->with('flash_success', 'Task updated successfully!');
    }

    // ---------------------------------------------------------------
    // POST /tasks/{id}/delete
    // ---------------------------------------------------------------
    public function destroy(int $id)
    {
        $task = Task::find($id);
        if (! $this->isAuthorized($task)) {
            return redirect()->route('task.index')->with('flash_danger', 'Task not found or unauthorized.');
        }
        $task->delete();
        return redirect()->route('task.index')->with('flash_success', 'Task deleted successfully!');
    }

    // ---------------------------------------------------------------
    // POST /tasks/{id}/upload_file_index — append a file (from index page)
    // POST /tasks/{id}/upload_file       — append a file (from show page)
    // Both APPEND semicolon-separated (matches Python add_file_attachment)
    // ---------------------------------------------------------------
    public function uploadFileFromIndex(Request $request, int $id)
    {
        return $this->appendFileAttachment($request, $id, 'task.index');
    }

    public function uploadFileFromShow(Request $request, int $id)
    {
        return $this->appendFileAttachment($request, $id, 'task.show', ['id' => $id]);
    }

    private function appendFileAttachment(Request $request, int $id, string $redirectRoute, array $redirectParams = [])
    {
        $task = Task::find($id);
        if (! $this->isAuthorized($task)) {
            return redirect()->route($redirectRoute, $redirectParams)
                ->with('flash_danger', 'Task not found or unauthorized.');
        }

        if (! $request->hasFile('file_upload')) {
            return redirect()->route($redirectRoute, $redirectParams)
                ->with('flash_danger', 'No file selected.');
        }

        $file = $request->file('file_upload');
        if (! $file || ! $file->isValid() || ! $file->getClientOriginalName()) {
            return redirect()->route($redirectRoute, $redirectParams)
                ->with('flash_danger', 'No file selected.');
        }

        if (! $this->isAllowedFile($file->getClientOriginalName())) {
            return redirect()->route($redirectRoute, $redirectParams)
                ->with('flash_danger', 'File type not allowed. Allowed: PDF, Word, Excel, Images, TXT, ZIP');
        }

        if ($file->getSize() > self::MAX_FILE_SIZE) {
            return redirect()->route($redirectRoute, $redirectParams)
                ->with('flash_danger', 'File size exceeds 10 MB limit.');
        }

        $filename = $this->safeFilename('task_' . $id . '_' . $file->getClientOriginalName());
        $file->move($this->uploadFolder(), $filename);

        $current = trim((string) $task->file_attachment);
        $task->update([
            'file_attachment' => $current === '' ? $filename : ($current . ';' . $filename),
        ]);

        return redirect()->route($redirectRoute, $redirectParams)
            ->with('flash_success', 'File uploaded successfully!');
    }

    // ---------------------------------------------------------------
    // GET /tasks/download/{filename}
    // ---------------------------------------------------------------
    public function downloadFile(string $filename)
    {
        $filepath = $this->uploadFolder() . DIRECTORY_SEPARATOR . $filename;

        if (! file_exists($filepath)) {
            return redirect()->route('task.index')->with('flash_danger', 'File not found.');
        }

        // Safety: keep file inside the uploads folder.
        $real        = realpath($filepath);
        $uploadsReal = realpath($this->uploadFolder());
        if (! $real || ! $uploadsReal || ! str_starts_with($real, $uploadsReal)) {
            return redirect()->route('task.index')->with('flash_danger', 'Invalid file.');
        }

        $ext         = strtolower(pathinfo($filename, PATHINFO_EXTENSION));
        $inlineTypes = ['pdf','jpg','jpeg','png','gif','txt'];

        if (in_array($ext, $inlineTypes, true)) {
            return response()->file($real);
        }
        return response()->download($real, $filename);
    }

    // ---------------------------------------------------------------
    // POST /tasks/import — bulk Excel import
    // ---------------------------------------------------------------
    public function import(Request $request)
    {
        if (! $request->hasFile('file') || ! $request->file('file')->isValid()) {
            return redirect()->route('task.index')->with('flash_danger', 'Please select a file.');
        }

        try {
            $file        = $request->file('file');
            $spreadsheet = IOFactory::load($file->getRealPath());
            $rows        = $spreadsheet->getActiveSheet()->toArray(null, true, true, false);

            // Drop header row (first row), same as the Python skiprows=0 default (pandas read_excel)
            // The Python code does NOT skip headers — but the column order in your sheet starts at index 0,
            // which is "title". If your sheet has a header row, this still works because the title cell
            // will just contain "title" which will become a row. Keeping behavior identical:
            $count = 0;
            foreach ($rows as $i => $cols) {
                if ($i === 0) {
                    // Heuristic: if first cell looks like a header (literal "title"), skip it.
                    if (isset($cols[0]) && is_string($cols[0]) && strtolower(trim($cols[0])) === 'title') {
                        continue;
                    }
                }

                $taskData = [
                    'title'           => isset($cols[0])  ? trim((string) $cols[0])  : null,
                    'description'     => isset($cols[1])  ? trim((string) $cols[1])  : null,
                    'category'        => isset($cols[2])  ? trim((string) $cols[2])  : null,
                    'department'      => isset($cols[3])  ? trim((string) $cols[3])  : null,
                    'assigned_to'     => isset($cols[4])  ? trim((string) $cols[4])  : null,
                    'team_member'     => isset($cols[5])  ? trim((string) $cols[5])  : null,
                    'user_mail'       => isset($cols[6])  ? trim((string) $cols[6])  : null,
                    'priority'        => strtolower(trim((string)($cols[7]  ?? 'medium'))),
                    'start_date'      => $this->parseExcelDate($cols[8]  ?? null),
                    'due_date'        => $this->parseExcelDate($cols[9]  ?? null),
                    'completion_date' => $this->parseExcelDate($cols[10] ?? null),
                    'status'          => str_replace(' ', '_', strtolower(trim((string)($cols[11] ?? 'pending')))),
                    'remarks'         => isset($cols[12]) ? trim((string) $cols[12]) : null,
                ];

                if (! $taskData['title']) continue;

                Task::create($taskData);
                $count++;
            }

            return redirect()->route('task.index')->with('flash_success', "Successfully imported {$count} tasks!");

        } catch (\Throwable $e) {
            return redirect()->route('task.index')->with('flash_danger', 'Import failed: ' . $e->getMessage());
        }
    }

    private function parseExcelDate($val): ?string
    {
        if ($val === null || $val === '') return null;

        if (is_numeric($val)) {
            try {
                $dt = \PhpOffice\PhpSpreadsheet\Shared\Date::excelToDateTimeObject((float) $val);
                return $dt->format('Y-m-d');
            } catch (\Throwable $e) {
                return null;
            }
        }

        try {
            return (new \DateTime((string) $val))->format('Y-m-d');
        } catch (\Throwable $e) {
            return null;
        }
    }
}
