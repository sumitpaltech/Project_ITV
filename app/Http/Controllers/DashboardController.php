<?php

namespace App\Http\Controllers;

use App\Models\Task;
use App\Models\User;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Session;

class DashboardController extends Controller
{
    /**
     * Mirrors Python is_user_dept_head(username, department).
     */
    private function isDepartmentHead(?string $username, ?string $department): bool
    {
        if (! $username || ! $department) {
            return false;
        }
        $heads = config('departments.heads', []);
        return ($heads[$department] ?? null) === $username;
    }

    /**
     * GET /dashboard
     * Builds role-based stats, recent tasks, and department stats.
     */
    public function index()
    {
        $userId    = Session::get('user_id');
        $userRole  = strtolower(trim(Session::get('role', 'user')));
        $userDept  = Session::get('department');
        $userName  = Session::get('username');

        // =========================
        // 1. ROLE-BASED STATS
        // =========================
        if ($userRole === 'admin') {
            $stats = [
                'total_tasks'       => Task::count(),
                'pending_tasks'     => Task::where('status', 'pending')->count(),
                'completed_tasks'   => Task::where('status', 'completed')->count(),
                'in_progress_tasks' => Task::where('status', 'in_progress')->count(),
                'total_users'       => User::count(),
            ];

            $chartData = [
                'pending'     => $stats['pending_tasks'],
                'completed'   => $stats['completed_tasks'],
                'in_progress' => $stats['in_progress_tasks'],
                'cancelled'   => Task::where('status', 'cancelled')->count(),
            ];

        } elseif ($this->isDepartmentHead($userName, $userDept)) {
            $statusMap = $this->statusMapForDepartment($userDept);

            $stats = [
                'total_tasks'       => Task::where('department', $userDept)->count(),
                'pending_tasks'     => $statusMap['pending']     ?? 0,
                'completed_tasks'   => $statusMap['completed']   ?? 0,
                'in_progress_tasks' => $statusMap['in_progress'] ?? 0,
                'total_users'       => null,
            ];
            $chartData = $statusMap;

        } else {
            $statusMap = $this->statusMapForUser($userName);

            $stats = [
                'total_tasks'       => Task::where('assigned_to', $userName)->count(),
                'pending_tasks'     => $statusMap['pending']     ?? 0,
                'completed_tasks'   => $statusMap['completed']   ?? 0,
                'in_progress_tasks' => $statusMap['in_progress'] ?? 0,
                'total_users'       => null,
            ];
            $chartData = $statusMap;
        }

        // =========================
        // 2. RECENT TASKS
        // =========================
        if ($userRole === 'admin') {
            $recentTasks = Task::withAssignedUser()
                ->orderByDesc('task_tracker.created_at')
                ->limit(10)
                ->get();
        } elseif ($this->isDepartmentHead($userName, $userDept)) {
            $recentTasks = Task::withAssignedUser()
                ->where('task_tracker.department', $userDept)
                ->orderByDesc('task_tracker.created_at')
                ->limit(10)
                ->get();
        } else {
            $recentTasks = Task::where('assigned_to', $userName)
                ->orderByDesc('created_at')
                ->limit(10)
                ->get();
        }

        // =========================
        // 3. DEPARTMENT STATS (for charts)
        // =========================
        $deptStats = [];

        if ($userRole === 'admin') {
            $deptsToProcess = array_keys(config('departments.heads', []));
        } elseif ($this->isDepartmentHead($userName, $userDept)) {
            $deptsToProcess = [$userDept];
        } else {
            $deptsToProcess = [];
        }

        foreach ($deptsToProcess as $dept) {
            $map = $this->statusMapForDepartment($dept);
            $deptStats[$dept] = [
                'pending'     => $map['pending']     ?? 0,
                'completed'   => $map['completed']   ?? 0,
                'in_progress' => $map['in_progress'] ?? 0,
                'cancelled'   => $map['cancelled']   ?? 0,
                'total'       => array_sum($map),
            ];
        }

        return view('dashboard.index', compact(
            'stats',
            'chartData',
            'deptStats',
            'recentTasks',
            'userRole',
            'userDept'
        ));
    }

    /**
     * GET /dashboard/department/{dept}
     */
    public function department(string $dept)
    {
        // Users from task table (group by assigned_to, max user_mail)
        $users = DB::table('task_tracker')
            ->where('department', $dept)
            ->whereNotNull('assigned_to')
            ->where('assigned_to', '!=', '')
            ->select('assigned_to as username', DB::raw('MAX(user_mail) as email'))
            ->groupBy('assigned_to')
            ->get();

        $tasks = Task::where('department', $dept)->get();

        $map = $this->statusMapForDepartment($dept);
        $deptStats = [
            $dept => [
                'pending'     => $map['pending']     ?? 0,
                'completed'   => $map['completed']   ?? 0,
                'in_progress' => $map['in_progress'] ?? 0,
                'cancelled'   => $map['cancelled']   ?? 0,
                'total'       => array_sum($map),
            ]
        ];

        // Per-user stats inside this department
        $rows = DB::table('task_tracker')
            ->select(
                'assigned_to',
                DB::raw('COUNT(*) as total'),
                DB::raw("SUM(CASE WHEN status='completed' THEN 1 ELSE 0 END) as completed"),
                DB::raw("SUM(CASE WHEN status='pending' THEN 1 ELSE 0 END) as pending"),
                DB::raw("SUM(CASE WHEN status='in_progress' THEN 1 ELSE 0 END) as in_progress"),
                DB::raw("SUM(CASE WHEN status='cancelled' THEN 1 ELSE 0 END) as cancelled")
            )
            ->where('department', $dept)
            ->groupBy('assigned_to')
            ->get();

        $userStats = [];
        foreach ($rows as $r) {
            $userStats[$r->assigned_to] = [
                'total'       => (int) $r->total,
                'completed'   => (int) $r->completed,
                'pending'     => (int) $r->pending,
                'in_progress' => (int) $r->in_progress,
                'cancelled'   => (int) $r->cancelled,
            ];
        }

        return view('dashboard.department', compact('dept', 'users', 'tasks', 'deptStats', 'userStats'));
    }

    /**
     * GET /dashboard/user/{username}
     */
    public function userTasks(string $username)
    {
        $tasks = Task::where('assigned_to', $username)
            ->orderByDesc('created_at')
            ->get();
        return view('dashboard.user_tasks', compact('username', 'tasks'));
    }

    /**
     * GET /dashboard/users  (admin only)
     */
    public function users()
    {
        $users = User::orderByDesc('created_at')->get();
        return view('dashboard.users', compact('users'));
    }

    // ------- helpers -------

    private function statusMapForDepartment(string $dept): array
    {
        return DB::table('task_tracker')
            ->select('status', DB::raw('COUNT(*) as total'))
            ->where('department', $dept)
            ->groupBy('status')
            ->pluck('total', 'status')
            ->map(fn($v) => (int) $v)
            ->toArray();
    }

    private function statusMapForUser(string $username): array
    {
        return DB::table('task_tracker')
            ->select('status', DB::raw('COUNT(*) as total'))
            ->where('assigned_to', $username)
            ->groupBy('status')
            ->pluck('total', 'status')
            ->map(fn($v) => (int) $v)
            ->toArray();
    }
}
