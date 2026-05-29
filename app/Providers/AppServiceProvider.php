<?php

namespace App\Providers;

use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\View;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    public function register(): void
    {
        //
    }

    public function boot(): void
    {
        Schema::defaultStringLength(191);

        // Share session "user" data with every Blade view (so templates can use
        // $session_user_id, $session_user_name, etc. the same way Python's
        // session.user_id / session.role worked).
        View::composer('*', function ($view) {
            $session = session()->all();
            $view->with('session_user_id',    session('user_id'));
            $view->with('session_user_name',  session('user_name'));
            $view->with('session_username',   session('username'));
            $view->with('session_email',      session('email'));
            $view->with('session_role',       session('role'));
            $view->with('session_department', session('department'));
        });
    }
}
