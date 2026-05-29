<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>@yield('title', 'Admin Dashboard | RMS')</title>
    <meta name="description" content="">
    <meta name="author" content="BWR Developer Sumit Pal">
    <meta name="csrf-token" content="{{ csrf_token() }}">

    <link rel="shortcut icon" href="{{ asset('assets/img/favicon.ico') }}">
    <link rel="apple-touch-icon" href="{{ asset('assets/img/apple-icon.ico') }}">
    <link rel="stylesheet" href="{{ asset('assets/css/bootstrap.min.css') }}">
    <link rel="stylesheet" href="{{ asset('assets/plugins/simplebar/simplebar.min.css') }}">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons@latest/iconfont/tabler-icons.min.css">
    <link rel="stylesheet" href="{{ asset('assets/plugins/flatpickr/flatpickr.min.css') }}">
    <link rel="stylesheet" href="{{ asset('assets/plugins/daterangepicker/daterangepicker.css') }}">
    <link rel="stylesheet" href="{{ asset('assets/plugins/select2/css/select2.min.css') }}">
    <link rel="stylesheet" href="{{ asset('assets/css/style.css') }}" id="app-style">
</head>
<body>
<div class="main-wrapper">

    @if($session_user_id)
    <header class="navbar-header">
        <div class="page-container topbar-menu">
            <div class="d-flex align-items-center gap-2">
                <a id="mobile_btn" class="mobile-btn" href="#sidebar"><i class="ti ti-menu-deep fs-24"></i></a>

                <a href="{{ route('dashboard.index') }}" class="logo">
                    <span class="logo-light"><span class="logo-lg"><img src="{{ asset('assets/img/logo.svg') }}" alt="logo"></span></span>
                    <span class="logo-dark"><span class="logo-lg"><img src="{{ asset('assets/img/logo-dark.svg') }}" alt="dark logo"></span></span>
                    <span class="logo-small"><span class="logo-lg"><img src="{{ asset('assets/img/logo-small.svg') }}" alt="small logo"></span></span>
                </a>

                <button class="sidenav-toggle-btn btn border-0 p-0 active" id="toggle_btn2">
                    <i class="ti ti-arrow-bar-to-right"></i>
                </button>

                <div class="me-auto d-flex align-items-center header-search d-lg-flex d-none">
                    <div class="input-icon position-relative me-2">
                        <input type="text" class="form-control" placeholder="Search Keyword">
                        <span class="input-icon-addon d-inline-flex p-0 header-search-icon"><i class="ti ti-command"></i></span>
                    </div>
                </div>
            </div>

            <div class="d-flex align-items-center">
                <div class="header-item dropdown profile-dropdown d-flex align-items-center justify-content-center">
                    <a href="javascript:void(0);" class="topbar-link dropdown-toggle drop-arrow-none position-relative" data-bs-toggle="dropdown" data-bs-offset="0,22">
                        <img src="{{ asset('assets/img/avatars/avatar-31.jpg') }}" width="32" class="rounded-2 d-flex" alt="user">
                    </a>
                    <div class="dropdown-menu dropdown-menu-end dropdown-menu-md p-2">
                        <div class="d-flex align-items-center bg-light rounded p-2 mb-2">
                            <img src="{{ asset('assets/img/avatars/avatar-31.jpg') }}" class="rounded-circle" width="42" height="42" alt="user">
                            <div class="ms-2">
                                <p class="fw-medium text-dark mb-0">{{ $session_user_name }}</p>
                                <span class="d-block fs-13">{{ $session_department }}</span>
                            </div>
                        </div>
                        <li class="{{ Route::currentRouteName() === 'account.password' ? 'active' : '' }}">
                            <a href="{{ route('account.password') }}">
                                <i class="ti ti-key"></i><span>Change Password</span>
                            </a>
                        </li>
                        <li>
                            <a href="{{ route('auth.logout') }}" class="text-danger">
                                <i class="ti ti-logout"></i><span>Logout</span>
                            </a>
                        </li>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <div class="sidebar" id="sidebar">
        <div class="sidebar-logo">
            <div>
                <a href="{{ route('dashboard.index') }}" class="logo logo-normal"><img src="{{ asset('assets/img/logo.svg') }}" alt="Logo"></a>
                <a href="{{ route('dashboard.index') }}" class="logo-small"><img src="{{ asset('assets/img/logo-small.svg') }}" alt="Logo"></a>
                <a href="{{ route('dashboard.index') }}" class="dark-logo"><img src="{{ asset('assets/img/logo-dark.svg') }}" alt="Logo"></a>
            </div>
            <button class="sidenav-toggle-btn btn border-0 p-0 active" id="toggle_btn"><i class="ti ti-arrow-bar-to-left"></i></button>
            <button class="sidebar-close"><i class="ti ti-x align-middle"></i></button>
        </div>
        <div class="sidebar-inner" data-simplebar>
            <div id="sidebar-menu" class="sidebar-menu">
                <ul role="menu" aria-label="Main navigation menu">
                    <li class="menu-title"><span>MAIN</span></li>

                    <li class="{{ Route::currentRouteName() === 'dashboard.index' ? 'active' : '' }}">
                        <a href="{{ route('dashboard.index') }}">
                            <i class="ti ti-dashboard"></i><span>Dashboard</span>
                        </a>
                    </li>

                    <li class="{{ Route::currentRouteName() === 'task.index' ? 'active' : '' }}">
                        <a href="{{ route('task.index') }}">
                            <i class="ti ti-layout-board"></i><span>My Tasks</span>
                        </a>
                    </li>

                    <li class="menu-title"><span>ACCOUNT</span></li>

                    @if($session_role === 'admin')
                        <li class="menu-title"><span>ADMIN</span></li>

                        <li class="{{ Route::currentRouteName() === 'dashboard.users' ? 'active' : '' }}">
                            <a href="{{ route('dashboard.users') }}">
                                <i class="ti ti-users"></i><span>User Management</span>
                            </a>
                        </li>

                        <li class="{{ Route::currentRouteName() === 'auth.register' ? 'active' : '' }}">
                            <a href="{{ route('auth.register') }}">
                                <i class="ti ti-user-plus"></i><span>Register User</span>
                            </a>
                        </li>
                    @endif

                    <li>
                        <a href="javascript:void(0);" style="cursor: default;">
                            <i class="ti ti-user"></i><span>{{ $session_user_name }}</span>
                        </a>
                    </li>

                    <li>
                        <a href="{{ route('auth.logout') }}" class="text-danger">
                            <i class="ti ti-logout"></i><span>Logout</span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    @endif

    <div class="page-wrapper">
        <div class="content">
            {{-- Flash messages — equivalent to Python get_flashed_messages() --}}
            @foreach(['success','danger','warning','info'] as $cat)
                @if(session('flash_' . $cat))
                    <div class="alert alert-{{ $cat }} alert-dismissible fade show" role="alert">
                        {{ session('flash_' . $cat) }}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                @endif
            @endforeach

            @yield('content')
        </div>

        <footer class="footer text-center">
            <div class="page-container">
                <p class="mb-0 text-dark">
                    <script>document.write(new Date().getFullYear())</script>
                    &copy; <a href="javascript:void(0);" class="link-primary">Dreams EMR</a> - All Rights Reserved.
                </p>
            </div>
        </footer>
    </div>
</div>

<script src="{{ asset('assets/js/theme-script.js') }}"></script>
<script src="{{ asset('assets/js/jquery-3.7.1.min.js') }}"></script>
<script src="{{ asset('assets/js/bootstrap.bundle.min.js') }}"></script>
<script src="{{ asset('assets/plugins/simplebar/simplebar.min.js') }}"></script>
<script src="{{ asset('assets/plugins/apexchart/apexcharts.min.js') }}"></script>
<script src="{{ asset('assets/plugins/apexchart/chart-data.js') }}"></script>
<script src="{{ asset('assets/js/script.js') }}"></script>

@yield('scripts')
</body>
</html>
