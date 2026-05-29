<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class Task extends Model
{
    use HasFactory;

    protected $table = 'task_tracker';

    protected $fillable = [
        'title',
        'description',
        'category',
        'department',
        'assigned_to',
        'user_mail',
        'team_member',
        'priority',
        'start_date',
        'due_date',
        'completion_date',
        'status',
        'remarks',
        'file_attachment',
    ];

    protected $casts = [
        'start_date'      => 'date',
        'due_date'        => 'date',
        'completion_date' => 'date',
        'created_at'      => 'datetime',
        'updated_at'      => 'datetime',
    ];

    /**
     * Join with users to get the assigned user's name.
     * Mirrors the Python LEFT JOIN ON assigned_to = users.username.
     */
    public function scopeWithAssignedUser($query)
    {
        return $query
            ->leftJoin('users', 'task_tracker.assigned_to', '=', 'users.username')
            ->select(
                'task_tracker.*',
                DB::raw('COALESCE(users.name, task_tracker.assigned_to) as assigned_to_name'),
                'users.email as assigned_email'
            );
    }

    /**
     * Apply the filter array used by the index page.
     */
    public function scopeApplyFilters($query, array $filters)
    {
        if (! empty($filters['title'])) {
            $query->where('task_tracker.title', 'like', '%' . $filters['title'] . '%');
        }
        if (! empty($filters['assigned_to'])) {
            $query->where('task_tracker.assigned_to', $filters['assigned_to']);
        }
        if (! empty($filters['department'])) {
            $query->where('task_tracker.department', $filters['department']);
        }
        if (! empty($filters['status'])) {
            $query->where('task_tracker.status', $filters['status']);
        }
        if (! empty($filters['priority'])) {
            $query->where('task_tracker.priority', $filters['priority']);
        }
        if (! empty($filters['start_date'])) {
            $query->where('task_tracker.due_date', '>=', $filters['start_date']);
        }
        if (! empty($filters['end_date'])) {
            $query->where('task_tracker.due_date', '<=', $filters['end_date']);
        }
        return $query;
    }
}
