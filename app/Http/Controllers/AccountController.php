<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Session;

class AccountController extends Controller
{
    /**
     * GET /account/password — show the change-password form
     */
    public function showChangePassword()
    {
        return view('account.password');
    }

    /**
     * POST /account/password — process change
     */
    public function changePassword(Request $request)
    {
        $current  = (string) $request->input('current_password', '');
        $new      = (string) $request->input('new_password', '');
        $confirm  = (string) $request->input('new_password_confirmation', '');

        // Basic validation
        if ($current === '' || $new === '' || $confirm === '') {
            return back()->with('flash_danger', 'All fields are required.');
        }
        if (strlen($new) < 6) {
            return back()->with('flash_danger', 'New password must be at least 6 characters.');
        }
        if ($new !== $confirm) {
            return back()->with('flash_danger', 'New password and confirmation do not match.');
        }
        if ($new === $current) {
            return back()->with('flash_danger', 'New password must be different from the current one.');
        }

        $user = User::find(Session::get('user_id'));
        if (! $user) {
            return redirect()->route('auth.login')->with('flash_danger', 'Session expired. Please log in again.');
        }

        if (! Hash::check($current, $user->password)) {
            return back()->with('flash_danger', 'Current password is incorrect.');
        }

        $user->password = Hash::make($new);
        $user->save();

        return redirect()->route('dashboard.index')
            ->with('flash_success', 'Password changed successfully.');
    }
}
