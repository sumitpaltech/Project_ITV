<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Session;
use Symfony\Component\HttpFoundation\Response;

/**
 * Mirrors Python's guest_only decorator.
 * Redirects logged-in users away from login/register pages.
 */
class RedirectIfAuthenticated
{
    public function handle(Request $request, Closure $next): Response
    {
        if (Session::has('user_id')) {
            return redirect()->route('dashboard.index');
        }
        return $next($request);
    }
}
