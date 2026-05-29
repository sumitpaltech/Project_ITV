<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\TaskController;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
| Equivalent to Python's blueprint registrations in app/__init__.py
| All route NAMES mirror the Python url_for() names (auth.login, task.index, …)
*/

// Root → dashboard (same as Flask /  )
Route::get('/', function () {
    return redirect()->route('dashboard.index');
});

// =====================================
// AUTH (Python: /auth/...)
// =====================================
Route::prefix('auth')->group(function () {
    Route::middleware('guest')->group(function () {
        Route::get('/login',  [AuthController::class, 'showLogin'])->name('auth.login');
        Route::post('/login', [AuthController::class, 'login']);
    });

    // Register is admin-only (admin middleware also enforced inside controller)
    Route::middleware(['auth'])->group(function () {
        Route::get('/register',  [AuthController::class, 'showRegister'])->name('auth.register');
        Route::post('/register', [AuthController::class, 'register']);
        Route::get('/logout',    [AuthController::class, 'logout'])->name('auth.logout');
    });
});

// =====================================
// DASHBOARD (Python: /dashboard/...)
// =====================================
Route::prefix('dashboard')->middleware('auth')->group(function () {
    Route::get('/',                          [DashboardController::class, 'index'])->name('dashboard.index');
    Route::get('/users',                     [DashboardController::class, 'users'])->middleware('admin')->name('dashboard.users');
    Route::get('/department/{dept}',         [DashboardController::class, 'department'])->name('dashboard.department');
    Route::get('/user/{username}',           [DashboardController::class, 'userTasks'])->name('dashboard.user_tasks');
});

// =====================================
// ACCOUNT — self-service password change
// =====================================
Route::prefix('account')->middleware('auth')->group(function () {
    Route::get('/password',  [\App\Http\Controllers\AccountController::class, 'showChangePassword'])->name('account.password');
    Route::post('/password', [\App\Http\Controllers\AccountController::class, 'changePassword']);
});

// =====================================
// TASKS (Python: /tasks/...)
// =====================================
Route::prefix('tasks')->middleware('auth')->group(function () {
    Route::get('/',                       [TaskController::class, 'index'])->name('task.index');
    Route::get('/create',                 [TaskController::class, 'create'])->name('task.create');
    Route::post('/store',                 [TaskController::class, 'store'])->name('task.store');
    Route::post('/import',                [TaskController::class, 'import'])->name('task.import');

    // Download — declared BEFORE the {id} route to avoid being captured by it.
    Route::get('/download/{filename}',    [TaskController::class, 'downloadFile'])
         ->where('filename', '.*')
         ->name('task.download');

    Route::get('/{id}',                   [TaskController::class, 'show'])->whereNumber('id')->name('task.show');
    Route::get('/{id}/edit',              [TaskController::class, 'edit'])->whereNumber('id')->name('task.edit');
    Route::post('/{id}/update',           [TaskController::class, 'update'])->whereNumber('id')->name('task.update');
    Route::post('/{id}/delete',           [TaskController::class, 'destroy'])->whereNumber('id')->name('task.delete');
    Route::post('/{id}/upload_file',      [TaskController::class, 'uploadFileFromShow'])->whereNumber('id')->name('task.upload_file');
    Route::post('/{id}/upload_file_index',[TaskController::class, 'uploadFileFromIndex'])->whereNumber('id')->name('task.upload_file_index');
});

// =====================================
// HEALTH CHECK (Kubernetes probes)
// =====================================
// Liveness: is the process alive?
Route::get('/health', function () {
    return response()->json(['status' => 'ok', 'timestamp' => now()->toIso8601String()]);
});

// Readiness: can we serve traffic? (verifies DB connection)
Route::get('/ready', function () {
    try {
        DB::connection()->getPdo();
        return response()->json(['status' => 'ready', 'database' => 'connected']);
    } catch (\Exception $e) {
        return response()->json(['status' => 'not_ready', 'database' => 'disconnected'], 503);
    }
});
