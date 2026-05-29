<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Session;
use Symfony\Component\HttpFoundation\Response;

class EnsureAdmin
{
    public function handle(Request $request, Closure $next): Response
    {
        $role = strtolower(trim(Session::get('role', '')));
        if ($role !== 'admin') {
            Session::flash('flash_danger', 'Access denied. Only administrators can do this.');
            return redirect()->route('dashboard.index');
        }
        return $next($request);
    }
}
