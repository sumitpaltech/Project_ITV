@extends('layouts.base')
@section('title', 'Sign In — 3Idea Technology')

@section('content')
<style>
    :root {
        --bwr-navy:   #0f1c2e;
        --bwr-steel:  #2d4a6a;
        --bwr-silver: #8fa3b8;
        --bwr-mist:   #dce6ef;
        --bwr-white:  #f8fafc;
        --bwr-gold:   #c4a35a;
        --bwr-danger: #c0392b;
    }

    /* Hide the standard Laravel chrome on the login screen */
    body { background: var(--bwr-white) !important; }
    .navbar-header, .sidebar, .footer, .page-wrapper > .content > .alert { display: none !important; }
    .page-wrapper { margin: 0 !important; padding: 0 !important; }
    .content      { padding: 0 !important; }

    .bwr-fonts {
        font-family: 'DM Sans', system-ui, -apple-system, "Segoe UI", Roboto, sans-serif;
    }

    .bwr-page {
        display: grid;
        grid-template-columns: 1fr 1fr;
        min-height: 100vh;
        color: var(--bwr-navy);
    }

    /* ── LEFT PANEL ── */
    .bwr-panel-left {
        background-color: var(--bwr-navy);
        position: relative;
        overflow: hidden;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        padding: 3rem;
    }
    .bwr-panel-left::before {
        content: '';
        position: absolute; inset: 0;
        background-image:
            linear-gradient(rgba(196,163,90,.07) 1px, transparent 1px),
            linear-gradient(90deg, rgba(196,163,90,.07) 1px, transparent 1px);
        background-size: 48px 48px;
    }
    .bwr-panel-left::after {
        content: '';
        position: absolute;
        bottom: -140px; right: -140px;
        width: 480px; height: 480px;
        border-radius: 50%;
        background: radial-gradient(circle, rgba(196,163,90,.15) 0%, transparent 65%);
    }
    .bwr-panel-inner {
        position: relative; z-index: 1;
        display: flex; flex-direction: column;
        align-items: center; gap: 2rem;
        animation: bwrFadeUp .7s ease both;
    }
    .bwr-logo-ring {
        width: 160px; height: 160px;
        border-radius: 50%;
        border: 2px solid rgba(196,163,90,.5);
        display: flex; align-items: center; justify-content: center;
        box-shadow: 0 0 0 8px rgba(196,163,90,.08), 0 0 40px rgba(196,163,90,.12);
    }
    .bwr-logo-ring img {
        width: 120px; height: 120px;
        object-fit: contain;
        border-radius: 50%;
    }
    .bwr-company-name {
        font-family: "Poppins", sans-serif;
        font-size: 1.6rem; font-weight: 600;
        color: var(--bwr-white);
        letter-spacing: .1em;
        text-transform: uppercase;
        text-align: center;
        margin: 0;
    }
    .bwr-company-tagline {
        font-size: .75rem;
        color: var(--bwr-gold);
        letter-spacing: .2em;
        text-transform: uppercase;
        text-align: center;
        margin: 0;
    }
    .bwr-gold-rule {
        width: 60px; height: 1.5px;
        background: linear-gradient(90deg, transparent, var(--bwr-gold), transparent);
    }
    .bwr-panel-footer {
        position: absolute; bottom: 2rem; z-index: 1;
        font-size: .7rem; color: var(--bwr-silver);
        letter-spacing: .04em; text-align: center;
    }

    /* ── RIGHT PANEL ── */
    .bwr-panel-right {
        display: flex; align-items: center; justify-content: center;
        padding: 3rem 2rem; background: var(--bwr-white);
    }
    .bwr-form-card { width: 100%; max-width: 400px; animation: bwrFadeUp .6s .15s ease both; }
    .bwr-form-header { margin-bottom: 2.5rem; }
    .bwr-form-eyebrow {
        font-size: .7rem; font-weight: 500;
        letter-spacing: .15em; text-transform: uppercase;
        color: var(--bwr-gold); margin-bottom: .6rem;
    }
    .bwr-form-title {
        font-family: "Poppins", sans-serif;
        font-size: 2.2rem; font-weight: 600;
        color: var(--bwr-navy); line-height: 1.15; margin: 0;
    }
    .bwr-form-subtitle {
        margin-top: .5rem; font-size: .85rem;
        color: var(--bwr-silver); font-weight: 300;
    }

    .bwr-field { margin-bottom: 1.4rem; }
    .bwr-field label {
        display: block;
        font-size: .72rem; font-weight: 500;
        letter-spacing: .08em; text-transform: uppercase;
        color: var(--bwr-steel); margin-bottom: .45rem;
    }
    .bwr-input-wrap { position: relative; }
    .bwr-input-wrap .bwr-field-icon {
        position: absolute; left: 14px; top: 50%; transform: translateY(-50%);
        width: 16px; height: 16px; stroke: var(--bwr-silver);
        transition: stroke .2s; pointer-events: none;
    }
    .bwr-input-wrap input[type="text"],
    .bwr-input-wrap input[type="password"] {
        width: 100%;
        padding: .85rem 1rem .85rem 2.6rem;
        border: 1.5px solid var(--bwr-mist);
        background: #fff; color: var(--bwr-navy);
        font-family: inherit; font-size: .9rem;
        outline: none;
        transition: border-color .2s, box-shadow .2s;
        border-radius: 0;
    }
    .bwr-input-wrap input:focus {
        border-color: var(--bwr-gold);
        box-shadow: 0 0 0 3px rgba(196,163,90,.12);
    }
    .bwr-input-wrap:focus-within .bwr-field-icon { stroke: var(--bwr-gold); }
    .bwr-toggle-pw {
        position: absolute; right: 12px; top: 50%; transform: translateY(-50%);
        background: none; border: none; cursor: pointer; padding: 4px;
        color: var(--bwr-silver); transition: color .2s;
        display: flex; align-items: center;
    }
    .bwr-toggle-pw:hover { color: var(--bwr-navy); }
    .bwr-toggle-pw svg {
        width: 17px; height: 17px;
        stroke: currentColor; fill: none;
        stroke-width: 1.8; stroke-linecap: round; stroke-linejoin: round;
    }

    .bwr-btn-login {
        width: 100%; padding: 1rem;
        background: var(--bwr-navy); color: var(--bwr-white);
        font-family: inherit; font-size: .85rem; font-weight: 500;
        letter-spacing: .1em; text-transform: uppercase;
        border: none; cursor: pointer; position: relative; overflow: hidden;
        margin-top: .5rem;
    }
    .bwr-btn-login::after {
        content: ''; position: absolute; inset: 0;
        background: var(--bwr-gold);
        transform: scaleX(0); transform-origin: left;
        transition: transform .35s cubic-bezier(.4,0,.2,1);
        z-index: 0;
    }
    .bwr-btn-login:hover::after { transform: scaleX(1); }
    .bwr-btn-login:hover        { color: var(--bwr-navy); }
    .bwr-btn-login span         { position: relative; z-index: 1; }

    /* Server-side alert (login failed etc.) */
    .bwr-server-alert {
        background: rgba(192,57,43,.08);
        border-left: 3px solid var(--bwr-danger);
        color: var(--bwr-danger);
        padding: .65rem .9rem; margin-bottom: 1.25rem;
        font-size: .82rem;
    }
    .bwr-server-alert.is-success {
        background: rgba(46,125,50,.08);
        border-left-color: #2e7d32;
        color: #2e7d32;
    }
    .bwr-server-alert ul { margin: 0; padding-left: 1.1rem; }

    @keyframes bwrFadeUp {
        from { opacity: 0; transform: translateY(18px); }
        to   { opacity: 1; transform: translateY(0); }
    }

    @media (max-width: 768px) {
        .bwr-page         { grid-template-columns: 1fr; }
        .bwr-panel-left   { display: none; }
        .bwr-panel-right  { padding: 2.5rem 1.5rem; align-items: flex-start; padding-top: 4rem; }
    }
</style>

<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;500;600&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet"/>

<div class="bwr-page bwr-fonts">

    <!-- LEFT BRAND PANEL -->
    <aside class="bwr-panel-left">
        <div class="bwr-panel-inner">
            <div class="bwr-logo-ring">
                <img src="{{ asset('assets/img/logo.svg') }}"
                     onerror="this.onerror=null;this.src='{{ asset('assets/img/logo-small.svg') }}';"
                     alt="3Idea Technology Logo">
            </div>
            <div class="bwr-gold-rule"></div>
            <div>
                <p class="bwr-company-name">3Idea Technology</p>
            </div>
        </div>
        <p class="bwr-panel-footer">© {{ date('Y') }} 3Idea Technology. All rights reserved.</p>
    </aside>

    <!-- RIGHT FORM PANEL -->
    <main class="bwr-panel-right">
        <div class="bwr-form-card">

            <div class="bwr-form-header">
                <p class="bwr-form-eyebrow">Welcome back</p>
                <h2 class="bwr-form-title">Sign in to<br>your account</h2>
                <p class="bwr-form-subtitle">Enter your credentials to continue.</p>
            </div>

            {{-- Flash + validation messages --}}
            @if(session('flash_success'))
                <div class="bwr-server-alert is-success">{{ session('flash_success') }}</div>
            @endif
            @if(session('flash_danger'))
                <div class="bwr-server-alert">{{ session('flash_danger') }}</div>
            @endif
            @if(session('flash_info'))
                <div class="bwr-server-alert is-success">{{ session('flash_info') }}</div>
            @endif
            @if($errors->any())
                <div class="bwr-server-alert">
                    <ul>
                        @foreach ($errors->all() as $error)
                            <li>{{ $error }}</li>
                        @endforeach
                    </ul>
                </div>
            @endif

            <form action="{{ route('auth.login') }}" method="POST" id="bwrLoginForm" novalidate>
                @csrf

                <div class="bwr-field">
                    <label for="bwr-username">Username or Email</label>
                    <div class="bwr-input-wrap">
                        <input type="text"
                               id="bwr-username"
                               name="username_or_email"
                               value="{{ old('username_or_email') }}"
                               placeholder="Enter your username or email"
                               autocomplete="username"
                               required>
                        <svg class="bwr-field-icon" viewBox="0 0 24 24" fill="none"
                             stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                            <circle cx="12" cy="8" r="4"/>
                            <path d="M4 20c0-4 3.6-7 8-7s8 3 8 7"/>
                        </svg>
                    </div>
                </div>

                <div class="bwr-field">
                    <label for="bwr-password">Password</label>
                    <div class="bwr-input-wrap">
                        <input type="password"
                               id="bwr-password"
                               name="password"
                               placeholder="Enter your password"
                               autocomplete="current-password"
                               required>
                        <svg class="bwr-field-icon" viewBox="0 0 24 24" fill="none"
                             stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                            <rect x="3" y="11" width="18" height="11" rx="2"/>
                            <path d="M7 11V7a5 5 0 0 1 10 0v4"/>
                        </svg>
                        <button type="button" class="bwr-toggle-pw" id="bwrTogglePw" aria-label="Show password">
                            <svg id="bwrEyeIcon" viewBox="0 0 24 24">
                                <path d="M1 12s4-7 11-7 11 7 11 7-4 7-11 7S1 12 1 12z"/>
                                <circle cx="12" cy="12" r="3"/>
                            </svg>
                        </button>
                    </div>
                </div>

                <button type="submit" class="bwr-btn-login">
                    <span>Sign In</span>
                </button>
            </form>

        </div>
    </main>
</div>

<script>
    (function () {
        var pwInput = document.getElementById('bwr-password');
        var toggle  = document.getElementById('bwrTogglePw');
        var icon    = document.getElementById('bwrEyeIcon');

        var open   = '<path d="M1 12s4-7 11-7 11 7 11 7-4 7-11 7S1 12 1 12z"/><circle cx="12" cy="12" r="3"/>';
        var closed = '<path d="M17.94 17.94A10.07 10.07 0 0 1 12 20C5 20 1 12 1 12a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07A3 3 0 1 1 9.88 9.88"/><line x1="1" y1="1" x2="23" y2="23"/>';

        toggle.addEventListener('click', function () {
            var show = pwInput.type === 'password';
            pwInput.type = show ? 'text' : 'password';
            icon.innerHTML = show ? closed : open;
        });
    })();
</script>
@endsection