@extends('layouts.base')
@section('title', 'Tasks of ' . $username)

@section('content')
<div class="container">
    <h3 class="mb-4">Tasks of {{ $username }}</h3>

    @php
        $total     = count($tasks);
        $completed = $tasks->where('status', 'completed')->count();
        $pending   = $tasks->where('status', 'pending')->count();
    @endphp

    <div class="row mb-4">
        <div class="col-md-4"><div class="card shadow-sm text-center"><div class="card-body">
            <h6>Total Tasks</h6><h4>{{ $total }}</h4>
        </div></div></div>
        <div class="col-md-4"><div class="card shadow-sm text-center"><div class="card-body">
            <h6>Completed</h6><h4 class="text-success">{{ $completed }}</h4>
        </div></div></div>
        <div class="col-md-4"><div class="card shadow-sm text-center"><div class="card-body">
            <h6>Pending</h6><h4 class="text-warning">{{ $pending }}</h4>
        </div></div></div>
    </div>

    <table class="table table-bordered table-striped">
        <thead class="table-dark">
            <tr>
                <th>Title</th>
                <th>Email</th>
                <th>Status</th>
                <th>Priority</th>
                <th>Start Date</th>
                <th>Due Date</th>
                <th>Completion Date</th>
            </tr>
        </thead>
        <tbody>
            @foreach($tasks as $task)
                <tr>
                    <td>{{ $task->title }}</td>
                    <td>{{ $task->user_mail }}</td>
                    <td>
                        @if($task->status === 'completed')
                            <span class="badge bg-success">Completed</span>
                        @elseif($task->status === 'pending')
                            <span class="badge bg-warning">Pending</span>
                        @else
                            <span class="badge bg-info">{{ $task->status }}</span>
                        @endif
                    </td>
                    <td>{{ $task->priority }}</td>
                    <td>{{ $task->start_date ? $task->start_date->format('Y-m-d') : '' }}</td>
                    <td>{{ $task->due_date ? $task->due_date->format('Y-m-d') : '' }}</td>
                    <td>{{ $task->completion_date ? $task->completion_date->format('Y-m-d') : '-' }}</td>
                </tr>
            @endforeach
        </tbody>
    </table>
</div>
@endsection
