<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Session;
use Symfony\Component\HttpFoundation\Response;

/**
 * Mirrors Python's login_required decorator.
 * Checks for user_id in session and redirects to login if missing.
 */
class EnsureAuthenticated
{
    public function handle(Request $request, Closure $next): Response
    {
        if (! Session::has('user_id')) {
            Session::flash('flash_warning', 'Please log in to continue.');
            return redirect()->route('auth.login');
        }
        return $next($request);
    }
}
