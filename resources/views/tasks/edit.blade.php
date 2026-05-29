@extends('layouts.base')
@section('title', 'Edit Task — TaskApp')

@section('content')
<div class="d-flex align-items-center mb-4 gap-3">
    <a href="{{ route('task.index') }}" class="btn btn-light btn-sm"><i class="bi bi-arrow-left"></i></a>
    <h4 class="mb-0 fw-bold">Edit Task</h4>
</div>

<div class="card border-0 shadow-sm" style="max-width:680px;">
    <div class="card-body p-4">
        <form action="{{ route('task.update', ['id' => $task->id]) }}" method="POST" enctype="multipart/form-data">
            @csrf
            <div class="mb-3">
                <label class="form-label fw-semibold">Title <span class="text-danger">*</span></label>
                <input type="text" name="title" class="form-control" value="{{ $task->title }}" required>
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold">Description</label>
                <textarea name="description" class="form-control" rows="4">{{ $task->description }}</textarea>
            </div>

            <div class="row g-3 mb-3">
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Category</label>
                    <input type="text" name="category" class="form-control" value="{{ $task->category ?: 'General' }}">
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Department</label>
                    <select name="department" class="form-select">
                        <option value="">Select Department</option>
                        @foreach($departments as $d)
                            <option value="{{ $d }}" {{ $task->department === $d ? 'selected' : '' }}>{{ $d }}</option>
                        @endforeach
                    </select>
                </div>
            </div>

            @if($session_role === 'admin')
                <div class="row g-3 mb-3">
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Assigned To (username)</label>
                        <input type="text" name="assigned_to" class="form-control" value="{{ $task->assigned_to }}">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Assigned Email</label>
                        <input type="email" name="user_mail" class="form-control" value="{{ $task->user_mail }}">
                    </div>
                </div>
            @else
                <div class="row g-3 mb-3">
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Assigned To</label>
                        <input type="text" class="form-control" value="{{ $task->assigned_to }}" readonly>
                        <input type="hidden" name="assigned_to" value="{{ $task->assigned_to }}">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Assigned Email</label>
                        <input type="email" class="form-control" value="{{ $task->user_mail }}" readonly>
                        <input type="hidden" name="user_mail" value="{{ $task->user_mail }}">
                    </div>
                </div>
            @endif

            <div class="mb-3">
                <label class="form-label fw-semibold">Team Member</label>
                <input type="text" name="team_member" class="form-control" value="{{ $task->team_member }}">
            </div>

            <div class="row g-3 mb-3">
                <div class="col-md-4">
                    <label class="form-label fw-semibold">Status</label>
                    <select name="status" class="form-select">
                        <option value="pending"     {{ $task->status === 'pending'     ? 'selected' : '' }}>Pending</option>
                        <option value="in_progress" {{ $task->status === 'in_progress' ? 'selected' : '' }}>In Progress</option>
                        <option value="completed"   {{ $task->status === 'completed'   ? 'selected' : '' }}>Completed</option>
                    </select>
                </div>
                <div class="col-md-4">
                    <label class="form-label fw-semibold">Priority</label>
                    <select name="priority" class="form-select">
                        <option value="low"    {{ $task->priority === 'low'    ? 'selected' : '' }}>Low</option>
                        <option value="medium" {{ $task->priority === 'medium' ? 'selected' : '' }}>Medium</option>
                        <option value="high"   {{ $task->priority === 'high'   ? 'selected' : '' }}>High</option>
                    </select>
                </div>
                <div class="col-md-4">
                    <label class="form-label fw-semibold">Due Date</label>
                    <input type="date" name="due_date" class="form-control" {{ $session_role !== 'admin' ? 'readonly' : '' }}
                        value="{{ $task->due_date ? $task->due_date->format('Y-m-d') : '' }}">
                </div>
            </div>

            <div class="row g-3 mb-3">
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Start Date</label>
                    <input type="date" name="start_date" class="form-control" {{ $session_role !== 'admin' ? 'readonly' : '' }}
                        value="{{ $task->start_date ? $task->start_date->format('Y-m-d') : '' }}">
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Completion Date</label>
                    <input type="date" name="completion_date" class="form-control" {{ $session_role !== 'admin' ? 'readonly' : '' }}
                        value="{{ $task->completion_date ? $task->completion_date->format('Y-m-d') : '' }}">
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold">Remarks</label>
                <textarea name="remarks" class="form-control" rows="3">{{ $task->remarks }}</textarea>
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold">Attach File (replaces current)</label>
                <input type="file" name="file_upload" class="form-control" accept=".pdf,.doc,.docx,.xlsx,.xls,.jpg,.jpeg,.png,.txt,.zip">
                <small class="text-muted">Allowed: PDF, Word, Excel, Images, TXT, ZIP (Max 10 MB)</small>
            </div>

            <div class="d-flex gap-2 pt-2">
                <button type="submit" class="btn btn-primary px-4 fw-semibold"><i class="bi bi-check-lg me-1"></i>Update Task</button>
                <a href="{{ route('task.index') }}" class="btn btn-light px-4">Cancel</a>
            </div>
        </form>
    </div>
</div>
@endsection
