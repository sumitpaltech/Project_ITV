<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Session;
use App\Support\PythonPasswordHasher;

class AuthController extends Controller
{
    /**
     * GET /auth/login — show the login form
     */
    public function showLogin()
    {
        return view('auth.login');
    }

    /**
     * POST /auth/login — process login
     * Mirrors Python auth_controller.login()
     */
    public function login(Request $request)
    {
        $loginValue = trim($request->input('username_or_email', ''));
        $password   = $request->input('password', '');

        $user = User::findByUsernameOrEmail($loginValue);

       $passwordOk = false;
        if ($user) {
            $stored = (string) $user->password;
            if (str_starts_with($stored, '$2y$') || str_starts_with($stored, '$argon')) {
                $passwordOk = Hash::check($password, $stored);
            } elseif (str_starts_with($stored, 'scrypt:') || str_starts_with($stored, 'pbkdf2:')) {
                $passwordOk = PythonPasswordHasher::check($password, $stored);
                if ($passwordOk) {
                    $user->password = Hash::make($password);
                    $user->save();
                }
            }
        }

        if ($passwordOk) {
            Session::put('user_id',    $user->id);
            Session::put('user_name',  $user->name);
            Session::put('username',   $user->username);
            Session::put('email',      $user->email);

            $roleValue = trim(strtolower($user->role ?? 'user'));
            Session::put('role',       $roleValue ?: 'user');
            Session::put('department', $user->department);

            Session::flash('flash_success', 'Welcome back, ' . $user->name . '!');
            return redirect()->route('dashboard.index');
        }

        return back()->with('flash_danger', 'Invalid username/email or password.');
    }

    /**
     * GET /auth/register — show the register form (admin only)
     * POST /auth/register — create new user (admin only)
     * Mirrors Python auth_controller.register()
     */
    public function showRegister()
    {
        if (! Session::has('user_id')) {
            return redirect()->route('auth.login');
        }
        if (strtolower(trim(Session::get('role', ''))) !== 'admin') {
            return redirect()->route('dashboard.index')
                ->with('flash_danger', 'Access denied. Only administrators can register new users.');
        }
        return view('auth.register');
    }

    public function register(Request $request)
    {
        if (strtolower(trim(Session::get('role', ''))) !== 'admin') {
            return redirect()->route('dashboard.index')
                ->with('flash_danger', 'Access denied. Only administrators can register new users.');
        }

        $name       = trim($request->input('name', ''));
        $username   = trim($request->input('username', ''));
        $email      = trim($request->input('email', ''));
        $password   = $request->input('password', '');
        $department = $request->input('department');

        if (! $name || ! $username || ! $email || ! $password || ! $department) {
            return back()->with('flash_danger',
                'All fields including Username and Department are required.');
        }

        if (User::where('username', $username)->exists()) {
            return back()->with('flash_danger', 'Username already taken.');
        }

        User::create([
            'name'       => $name,
            'username'   => $username,
            'email'      => $email,
            'password'   => Hash::make($password),
            'role'       => 'user',
            'department' => $department,
            'status'     => 1,
        ]);

        return redirect()->route('dashboard.users')
            ->with('flash_success', 'Account created successfully!');
    }

    /**
     * GET /auth/logout — clear session
     */
    public function logout()
    {
        Session::flush();
        return redirect()->route('auth.login')
            ->with('flash_info', 'Logged out successfully.');
    }
}
