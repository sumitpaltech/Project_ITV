@extends('layouts.base')
@section('title', $task->title . ' — TaskApp')

@section('content')
<div class="d-flex align-items-center mb-4 gap-3">
    <a href="{{ route('task.index') }}" class="btn btn-light btn-sm"><i class="bi bi-arrow-left"></i></a>
    <h4 class="mb-0 fw-bold">Task Detail</h4>
</div>

<div class="card border-0 shadow-sm" style="max-width:680px;">
    <div class="card-body p-4">
        <div class="d-flex justify-content-between align-items-start mb-3">
            <h5 class="fw-bold mb-0">{{ $task->title }}</h5>
            <a href="{{ route('task.edit', ['id' => $task->id]) }}" class="btn btn-sm btn-outline-primary">
                <i class="bi bi-pencil me-1"></i>Edit
            </a>
        </div>

        <p class="text-muted">{{ $task->description ?: 'No description provided.' }}</p>

        <hr>

        <div class="row g-3">
            <div class="col-sm-4">
                <div class="small text-muted mb-1">Status</div>
                @if($task->status === 'pending')
                    <span class="badge badge-pending rounded-pill px-3 py-1">Pending</span>
                @elseif($task->status === 'in_progress')
                    <span class="badge badge-progress rounded-pill px-3 py-1">In Progress</span>
                @else
                    <span class="badge badge-done rounded-pill px-3 py-1">{{ ucfirst($task->status) }}</span>
                @endif
            </div>
            <div class="col-sm-4">
                <div class="small text-muted mb-1">Priority</div>
                <span class="priority-{{ $task->priority }} fw-semibold">{{ ucfirst($task->priority) }}</span>
            </div>
            <div class="col-sm-4">
                <div class="small text-muted mb-1">Due Date</div>
                <span>{{ $task->due_date ? \Carbon\Carbon::parse($task->due_date)->format('M d, Y') : '—' }}</span>
            </div>
            <div class="col-sm-4">
                <div class="small text-muted mb-1">Assigned To</div>
                <span>{{ $task->user_name ?? $task->assigned_to ?? 'Unassigned' }}</span>
            </div>
            <div class="col-sm-4">
                <div class="small text-muted mb-1">Assigned Email</div>
                <span>{{ $task->user_mail ?? $task->assigned_email ?? '—' }}</span>
            </div>
            <div class="col-sm-4">
                <div class="small text-muted mb-1">Created</div>
                <span>{{ $task->created_at ? \Carbon\Carbon::parse($task->created_at)->format('M d, Y') : '—' }}</span>
            </div>
            <div class="col-sm-4">
                <div class="small text-muted mb-1">Last Updated</div>
                <span>{{ $task->updated_at ? \Carbon\Carbon::parse($task->updated_at)->format('M d, Y') : '—' }}</span>
            </div>
        </div>

        <hr>

        <div class="mb-3">
            <h6 class="fw-semibold mb-3"><i class="bi bi-file-earmark me-2"></i>Attached Files</h6>
            @if($task->file_attachment)
                @php($files = array_filter(array_map('trim', explode(';', $task->file_attachment))))
                @if(count($files))
                    <div class="list-group">
                        @foreach($files as $file)
                            <a href="{{ route('task.download', ['filename' => $file]) }}" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                                <span class="small"><i class="bi bi-download me-2"></i>{{ $file }}</span>
                                <i class="bi bi-arrow-down-circle text-primary"></i>
                            </a>
                        @endforeach
                    </div>
                @endif
            @else
                <div class="alert alert-light text-muted small">
                    <i class="bi bi-info-circle me-2"></i>No files attached to this task.
                </div>
            @endif
        </div>

        <div class="mb-3">
            <h6 class="fw-semibold mb-3"><i class="bi bi-plus-circle me-2"></i>Upload New File</h6>
            <form action="{{ route('task.upload_file', ['id' => $task->id]) }}" method="POST" enctype="multipart/form-data">
                @csrf
                <div class="input-group">
                    <input type="file" name="file_upload" class="form-control" accept=".pdf,.doc,.docx,.xlsx,.xls,.jpg,.jpeg,.png,.txt,.zip" required>
                    <button class="btn btn-outline-primary" type="submit"><i class="bi bi-cloud-upload me-1"></i>Upload</button>
                </div>
                <small class="text-muted d-block mt-2">Allowed: PDF, Word, Excel, Images, TXT, ZIP (Max 10 MB)</small>
            </form>
        </div>

        <hr>

        <form action="{{ route('task.delete', ['id' => $task->id]) }}" method="POST" onsubmit="return confirm('Are you sure you want to delete this task?')">
            @csrf
            <button class="btn btn-sm btn-outline-danger"><i class="bi bi-trash me-1"></i>Delete Task</button>
        </form>
    </div>
</div>
@endsection
