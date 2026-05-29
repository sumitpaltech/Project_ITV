@extends('layouts.base')
@section('title', 'Tasks — TaskApp')

@section('content')
@php
    $statMap = [];
    foreach ($stats as $s) {
        $status = is_array($s) ? ($s['status'] ?? '') : ($s->status ?? '');
        $total  = is_array($s) ? ($s['total']  ?? 0)  : ($s->total  ?? 0);
        $statMap[strtolower($status)] = $total;
    }
@endphp

<div class="row g-3 mb-4">
    <div class="col-md-4 col-sm-6 d-flex">
        <div class="card flex-fill border-0 shadow-sm">
            <div class="card-body">
                <div class="d-flex align-items-center">
                    <span class="avatar bg-warning rounded-circle"><i class="ti ti-user-exclamation fs-20"></i></span>
                    <div class="ms-2 overflow-hidden">
                        <p class="mb-1 text-truncate">Pending Tasks</p>
                        <h5 class="mb-0">{{ $statMap['pending'] ?? 0 }}</h5>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-4 col-sm-6 d-flex">
        <div class="card flex-fill border-0 shadow-sm">
            <div class="card-body">
                <div class="d-flex align-items-center">
                    <span class="avatar bg-primary rounded-circle"><i class="ti ti-loader fs-20"></i></span>
                    <div class="ms-2 overflow-hidden">
                        <p class="mb-1 text-truncate">In Progress</p>
                        <h5 class="mb-0">{{ $statMap['in_progress'] ?? 0 }}</h5>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-4 col-sm-6 d-flex">
        <div class="card flex-fill border-0 shadow-sm">
            <div class="card-body">
                <div class="d-flex align-items-center justify-content-between">
                    <div class="d-flex align-items-center">
                        <span class="avatar bg-success rounded-circle"><i class="ti ti-circle-check fs-20"></i></span>
                        <div class="ms-2 overflow-hidden">
                            <p class="mb-1 text-truncate">Completed</p>
                            <h5 class="mb-0">{{ $statMap['completed'] ?? 0 }}</h5>
                        </div>
                    </div>
                    <span class="badge badge-soft-success">Done</span>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="row mb-3">
    <div class="col-md-3"><div class="card p-3 text-center"><h6>Total</h6><h4>{{ $summary['total'] }}</h4></div></div>
    <div class="col-md-3"><div class="card p-3 text-center"><h6>Completed</h6><h4>{{ $summary['completed'] }} ({{ $summary['completed_pct'] }}%)</h4></div></div>
    <div class="col-md-3"><div class="card p-3 text-center"><h6>Pending</h6><h4>{{ $summary['pending'] }} ({{ $summary['pending_pct'] }}%)</h4></div></div>
    <div class="col-md-3"><div class="card p-3 text-center"><h6>In Progress</h6><h4>{{ $summary['in_progress'] }} ({{ $summary['in_progress_pct'] }}%)</h4></div></div>
</div>

<div class="card mb-0 border-0 shadow-sm">
    <div class="card-header d-flex align-items-center flex-wrap gap-2 justify-content-between border-bottom-0">
        <h5 class="d-inline-flex align-items-center mb-0 fw-bold">
            @if($session_role === 'admin')
                <i class="ti ti-shield-lock me-2 fs-20"></i>All System Tasks
            @elseif($session_department)
                <i class="ti ti-building me-2 fs-20"></i>{{ $session_department }} Department
            @else
                <i class="ti ti-user me-2 fs-20"></i>My Private Tasks
            @endif
            <span class="badge bg-danger-transparent ms-2">{{ count($tasks) }}</span>
        </h5>

        <div class="d-flex align-items-center gap-2">
            <button type="button" class="btn btn-md btn-outline-light d-inline-flex align-items-center" data-bs-toggle="modal" data-bs-target="#importModal">
                <i class="ti ti-file-spreadsheet me-1"></i>Import
            </button>
            <a href="{{ route('task.create') }}" class="btn btn-md btn-primary d-inline-flex align-items-center">
                <i class="ti ti-circle-plus me-1"></i>New Task
            </a>
        </div>
    </div>

    <div class="p-3 border-bottom">
        <form method="GET" action="{{ route('task.index') }}">
            <div class="row g-2">
                <div class="col-md-2">
                    <input type="text" name="title" value="{{ request('title','') }}" class="form-control form-control-sm" placeholder="Search Title">
                </div>
                <div class="col-md-1">
                    <select name="status" class="form-control form-control-sm">
                        <option value="">All Status</option>
                        @foreach($statuses as $s)
                            <option value="{{ $s }}" {{ request('status') === $s ? 'selected' : '' }}>
                                {{ ucwords(str_replace('_',' ', $s)) }}
                            </option>
                        @endforeach
                    </select>
                </div>
                <div class="col-md-1">
                    <select name="priority" class="form-control form-control-sm">
                        <option value="">All Priority</option>
                        @foreach($priorities as $p)
                            <option value="{{ $p }}" {{ request('priority') === $p ? 'selected' : '' }}>
                                {{ ucfirst($p) }}
                            </option>
                        @endforeach
                    </select>
                </div>
                <div class="col-md-2">
                    <div class="d-flex gap-2">
                        <div class="w-50"><input type="date" name="start_date" value="{{ request('start_date','') }}" class="form-control form-control-sm" title="Start Date"></div>
                        <div class="w-50"><input type="date" name="end_date"   value="{{ request('end_date','') }}"   class="form-control form-control-sm" title="End Date"></div>
                    </div>
                </div>

                @if($session_role === 'admin')
                    <div class="col-md-2">
                        <select name="assigned_to" class="form-control form-control-sm">
                            <option value="">All Users</option>
                            @foreach($users as $u)
                                <option value="{{ $u }}" {{ request('assigned_to') === $u ? 'selected' : '' }}>{{ $u }}</option>
                            @endforeach
                        </select>
                    </div>
                    <div class="col-md-2">
                        <select name="department" class="form-control form-control-sm">
                            <option value="">All Departments</option>
                            @foreach($departments as $d)
                                <option value="{{ $d }}" {{ request('department') === $d ? 'selected' : '' }}>{{ $d }}</option>
                            @endforeach
                        </select>
                    </div>
                @endif

                <div class="col-md-2 d-flex gap-1">
                    <button class="btn btn-sm btn-primary w-100">Filter</button>
                    <a href="{{ route('task.index') }}" class="btn btn-sm btn-light w-100">Reset</a>
                </div>
            </div>
        </form>
    </div>

    <div class="card-body p-0">
        @if(count($tasks))
            <div class="table-responsive table-nowrap">
                <table class="table mb-0 border-top">
                    <thead class="table-light">
                        <tr>
                            <th>Sr. No</th>
                            <th>Title</th>
                            @if($session_role === 'admin' || $session_department)
                                <th>Assigned To</th>
                            @endif
                            @if($session_role === 'admin')
                                <th>Dept.</th>
                            @endif
                            <th>Status</th>
                            <th>Due Date</th>
                            <th>Priority</th>
                            <th>Files</th>
                            <th class="text-end">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach($tasks as $idx => $task)
                            <tr>
                                <td class="text-muted">{{ $idx + 1 }}</td>
                                <td><h6 class="fs-14 mb-0 fw-medium">{{ $task->title }}</h6></td>

                                @if($session_role === 'admin' || $session_department)
                                    <td class="small">{{ $task->assigned_to_name ?? $task->assigned_to ?? 'Unassigned' }}</td>
                                @endif

                                @if($session_role === 'admin')
                                    <td><span class="badge badge-soft-info">{{ $task->department }}</span></td>
                                @endif

                                <td>
                                    @if($task->status === 'pending')
                                        <span class="badge badge-soft-warning">Pending</span>
                                    @elseif($task->status === 'in_progress')
                                        <span class="badge badge-soft-primary">In Progress</span>
                                    @elseif($task->status === 'completed')
                                        <span class="badge badge-soft-success">Completed</span>
                                    @else
                                        <span class="badge badge-soft-danger">{{ ucfirst($task->status) }}</span>
                                    @endif
                                </td>

                                <td>{{ $task->due_date }}</td>

                                <td><span class="priority-{{ $task->priority }}">{{ ucfirst($task->priority) }}</span></td>

                                <td>
                                    @if($task->file_attachment)
                                        @php
                                            $parts = explode(';', $task->file_attachment);
                                            $firstFile = $parts[0] ?? null;
                                        @endphp
                                        <a href="{{ route('task.download', ['filename' => $firstFile]) }}" class="btn btn-icon btn-sm btn-outline-primary" target="_blank">
                                            <i class="ti ti-eye"></i>
                                        </a>
                                    @else
                                        <form action="{{ route('task.upload_file_index', ['id' => $task->id]) }}" method="POST" enctype="multipart/form-data" class="d-flex gap-1">
                                            @csrf
                                            <input type="file" name="file_upload" class="form-control form-control-sm" style="width:120px;" required>
                                            <button type="submit" class="btn btn-icon btn-sm btn-outline-light"><i class="ti ti-upload"></i></button>
                                        </form>
                                    @endif
                                </td>

                                <td class="text-end">
                                    <div class="dropdown">
                                        <a href="javascript:void(0);" class="btn btn-icon btn-sm btn-outline-light" data-bs-toggle="dropdown">
                                            <i class="ti ti-dots-vertical"></i>
                                        </a>
                                        <ul class="dropdown-menu dropdown-menu-end p-2">
                                            <li><a href="{{ route('task.show', ['id' => $task->id]) }}" class="dropdown-item"><i class="ti ti-eye me-1"></i>View Details</a></li>
                                            <li><a href="{{ route('task.edit', ['id' => $task->id]) }}" class="dropdown-item"><i class="ti ti-edit me-1"></i>Edit Task</a></li>
                                            <li>
                                                <form action="{{ route('task.delete', ['id' => $task->id]) }}" method="POST" onsubmit="return confirm('Delete this task?')">
                                                    @csrf
                                                    <button class="dropdown-item text-danger"><i class="ti ti-trash me-1"></i>Delete</button>
                                                </form>
                                            </li>
                                        </ul>
                                    </div>
                                </td>
                            </tr>
                        @endforeach
                    </tbody>
                </table>
            </div>
        @else
            <div class="text-center py-5 text-muted">
                <i class="ti ti-package-off fs-1 d-block mb-3"></i>
                No tasks found for your profile.
            </div>
        @endif
    </div>

    @if($pagination['total_pages'] > 1)
        <nav aria-label="Task pagination" class="mt-4">
            <ul class="pagination justify-content-center">
                @if($pagination['has_prev'])
                    <li class="page-item"><a class="page-link" href="{{ route('task.index', array_merge(request()->query(), ['page' => $pagination['prev_page']])) }}">« Previous</a></li>
                @else
                    <li class="page-item disabled"><span class="page-link">« Previous</span></li>
                @endif

                @php
                    $start = max(1, $pagination['page'] - 2);
                    $end   = min($pagination['total_pages'], $pagination['page'] + 2);
                @endphp

                @if($start > 1)
                    <li class="page-item"><a class="page-link" href="{{ route('task.index', array_merge(request()->query(), ['page' => 1])) }}">1</a></li>
                    @if($start > 2)
                        <li class="page-item disabled"><span class="page-link">...</span></li>
                    @endif
                @endif

                @for($pageNum = $start; $pageNum <= $end; $pageNum++)
                    <li class="page-item {{ $pageNum == $pagination['page'] ? 'active' : '' }}">
                        <a class="page-link" href="{{ route('task.index', array_merge(request()->query(), ['page' => $pageNum])) }}">{{ $pageNum }}</a>
                    </li>
                @endfor

                @if($end < $pagination['total_pages'])
                    @if($end < $pagination['total_pages'] - 1)
                        <li class="page-item disabled"><span class="page-link">...</span></li>
                    @endif
                    <li class="page-item"><a class="page-link" href="{{ route('task.index', array_merge(request()->query(), ['page' => $pagination['total_pages']])) }}">{{ $pagination['total_pages'] }}</a></li>
                @endif

                @if($pagination['has_next'])
                    <li class="page-item"><a class="page-link" href="{{ route('task.index', array_merge(request()->query(), ['page' => $pagination['next_page']])) }}">Next »</a></li>
                @else
                    <li class="page-item disabled"><span class="page-link">Next »</span></li>
                @endif
            </ul>
            <p class="text-center text-muted small mt-2">
                Showing {{ ($pagination['page'] - 1) * $pagination['per_page'] + 1 }}
                to {{ min($pagination['page'] * $pagination['per_page'], $pagination['total_tasks']) }}
                of {{ $pagination['total_tasks'] }} tasks
            </p>
        </nav>
    @endif
</div>

{{-- Import Modal --}}
<div class="modal fade" id="importModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <form action="{{ route('task.import') }}" method="POST" enctype="multipart/form-data" class="modal-content">
            @csrf
            <div class="modal-header">
                <h5 class="modal-title">Import Tasks from Excel</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <input type="file" name="file" class="form-control" accept=".xlsx,.xls,.csv" required>
                <p class="small text-muted mt-2">
                    Columns expected in this order: title, description, category, department, assigned_to, team_member, user_mail, priority, start_date, due_date, completion_date, status, remarks
                </p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="submit" class="btn btn-primary">Start Import</button>
            </div>
        </form>
    </div>
</div>
@endsection
