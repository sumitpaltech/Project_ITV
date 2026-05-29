@extends('layouts.base')
@section('title', 'Change Password — TaskApp')

@section('content')
<div class="page-container">
    <div class="d-flex align-items-center mb-4 gap-3">
        <a href="{{ route('dashboard.index') }}" class="btn btn-light btn-sm"><i class="ti ti-arrow-left"></i></a>
        <h4 class="mb-0 fw-bold">Change Password</h4>
    </div>

    <div class="card border-0 shadow-sm" style="max-width: 520px;">
        <div class="card-body p-4">
            <p class="text-muted small mb-4">
                Set a new password for your account. Choose something at least 6 characters long that's easy for you to remember but hard for others to guess.
            </p>

            <form method="POST" action="{{ route('account.password') }}" autocomplete="off">
                @csrf

                <div class="mb-3">
                    <label class="form-label fw-semibold">Current Password <span class="text-danger">*</span></label>
                    <input type="password" name="current_password" class="form-control" placeholder="Enter your current password" required>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">New Password <span class="text-danger">*</span></label>
                    <input type="password" name="new_password" class="form-control" placeholder="At least 6 characters" required minlength="6">
                </div>

                <div class="mb-4">
                    <label class="form-label fw-semibold">Confirm New Password <span class="text-danger">*</span></label>
                    <input type="password" name="new_password_confirmation" class="form-control" placeholder="Re-enter the new password" required minlength="6">
                </div>

                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-primary px-4 fw-semibold">
                        <i class="ti ti-check me-1"></i>Update Password
                    </button>
                    <a href="{{ route('dashboard.index') }}" class="btn btn-light px-4">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</div>
@endsection
