<?php

namespace App\Models;

use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class User extends Authenticatable
{
    use HasFactory, Notifiable;

    protected $table = 'users';

    protected $fillable = [
        'name',
        'username',
        'email',
        'password',
        'role',
        'department',
        'status',
    ];

    protected $hidden = [
        'password',
        'remember_token',
    ];

    protected $casts = [
        'status' => 'integer',
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
    ];

    /**
     * Check if the user is the head of a given department.
     * Mirrors is_user_dept_head() from the Python project.
     */
    public function isDepartmentHead(?string $department = null): bool
    {
        $department = $department ?? $this->department;

        if (! $this->username || ! $department) {
            return false;
        }

        $heads = config('departments.heads', []);
        return ($heads[$department] ?? null) === $this->username;
    }

    public function isAdmin(): bool
    {
        return strtolower(trim($this->role ?? '')) === 'admin';
    }

    /**
     * Find a user by username or email (used at login).
     */
    public static function findByUsernameOrEmail(string $identifier): ?self
    {
        return static::where('username', $identifier)
            ->orWhere('email', $identifier)
            ->first();
    }
}
