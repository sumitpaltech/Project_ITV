@extends('layouts.base')
@section('title', 'User Management - Task Management')

@section('content')
<div class="page-container">
    <div class="row">
        <div class="col-12">
            <div class="d-flex align-items-center justify-content-between mb-4">
                <h4 class="mb-0">User Management</h4>
                <div class="d-flex gap-2">
                    <a href="{{ route('auth.register') }}" class="btn btn-success">
                        <i class="ti ti-user-plus me-1"></i>Add New User
                    </a>
                    <a href="{{ route('dashboard.index') }}" class="btn btn-secondary">
                        <i class="ti ti-arrow-left me-1"></i>Back to Dashboard
                    </a>
                </div>
            </div>

            <div class="alert alert-info border-info">
                <div class="d-flex align-items-start">
                    <i class="ti ti-shield-check fs-24 text-info me-3 mt-1"></i>
                    <div>
                        <h6 class="alert-heading mb-2">🔐 Admin-Only User Management</h6>
                        <p class="mb-0">You have administrative access to manage users. Passwords are securely hashed and cannot be viewed.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-12">
            <div class="card border-0 shadow-sm">
                <div class="card-header"><h5 class="card-title mb-0">All Users ({{ count($users) }})</h5></div>
                <div class="card-body">
                    @if(count($users))
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead class="table-light">
                                    <tr>
                                        <th>ID</th>
                                        <th>Name</th>
                                        <th>Username</th>
                                        <th>Email</th>
                                        <th>Department</th>
                                        <th>Role</th>
                                        <th>Status</th>
                                        <th>Created</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @foreach($users as $user)
                                        <tr>
                                            <td>{{ $user->id }}</td>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <div class="avatar avatar-sm bg-primary-transparent rounded-circle me-2">
                                                        <span class="avatar-title text-primary">{{ $user->name ? strtoupper(substr($user->name,0,1)) : '?' }}</span>
                                                    </div>
                                                    <span>{{ $user->name }}</span>
                                                </div>
                                            </td>
                                            <td>{{ $user->username }}</td>
                                            <td>{{ $user->email }}</td>
                                            <td><span class="badge bg-info">{{ $user->department ?: 'N/A' }}</span></td>
                                            <td>
                                                <span class="badge bg-{{ $user->role === 'admin' ? 'danger' : 'secondary' }}">
                                                    {{ ucfirst($user->role) }}
                                                </span>
                                            </td>
                                            <td>
                                                <span class="badge bg-{{ $user->status == 1 ? 'success' : 'warning' }}">
                                                    {{ $user->status == 1 ? 'Active' : 'Inactive' }}
                                                </span>
                                            </td>
                                            <td>{{ $user->created_at ? $user->created_at->format('Y-m-d') : 'N/A' }}</td>
                                        </tr>
                                    @endforeach
                                </tbody>
                            </table>
                        </div>
                    @else
                        <div class="text-center py-5 text-muted">No users found.</div>
                    @endif
                </div>
            </div>
        </div>
    </div>
</div>
@endsection
