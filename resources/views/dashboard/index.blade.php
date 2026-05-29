@extends('layouts.base')
@section('title', 'Dashboard - Task Management')

@section('content')
<div class="page-container">
    <div class="row">
        <div class="col-12">
            <div class="d-flex align-items-center justify-content-between mb-4">
                <h4 class="mb-0">Dashboard</h4>
                <div class="d-flex gap-2">
                    <a href="{{ route('task.index') }}" class="btn btn-primary">
                        <i class="ti ti-list me-1"></i>View All Tasks
                    </a>
                    @if($userRole === 'admin')
                        <a href="{{ route('dashboard.users') }}" class="btn btn-info">
                            <i class="ti ti-users me-1"></i>Manage Users
                        </a>
                        <a href="{{ route('task.create') }}" class="btn btn-success">
                            <i class="ti ti-plus me-1"></i>Create Task
                        </a>
                    @endif
                </div>
            </div>
        </div>
    </div>

    <div class="row g-3 mb-4">
        <div class="col-12">
            <h5 class="mb-3 fw-bold">Departmental Task Overview</h5>
        </div>

        @foreach($deptStats as $deptName => $data)
            <div class="col-md-3 col-sm-6">
                <div class="card border-0 shadow-sm h-100">
                    <div class="card-body text-center">
                        <h6 class="text-muted small text-uppercase fw-bold mb-3">
                            <a href="{{ route('dashboard.department', ['dept' => $deptName]) }}"
                               style="text-decoration:none; color:inherit;">
                                {{ $deptName }}
                            </a>
                        </h6>

                        <div id="chart-{{ str_replace([' ','&'], ['-','and'], $deptName) }}" class="mx-auto" style="min-height: 160px;"></div>

                        <div class="mt-2 pt-2 border-top">
                            <span class="badge bg-warning-transparent me-2" style="color:#2ea4dc;">{{ $data['pending'] }} Pending</span>
                            <span class="badge bg-success-transparent" style="color:#026e1f;">{{ $data['completed'] }} Done</span>
                        </div>
                    </div>
                </div>
            </div>
        @endforeach
    </div>

    <div class="row g-3 mb-4">
        <div class="col-md-3 col-sm-6">
            <div class="card border-0 shadow-sm">
                <div class="card-body">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <p class="text-muted mb-1">Total Tasks</p>
                            <h4 class="mb-0">{{ $stats['total_tasks'] }}</h4>
                        </div>
                        <span class="avatar bg-primary-transparent rounded-circle"><i class="ti ti-clipboard-list fs-20 text-primary"></i></span>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-sm-6">
            <div class="card border-0 shadow-sm">
                <div class="card-body">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <p class="text-muted mb-1">Pending Tasks</p>
                            <h4 class="mb-0" style="color:#2ea4dc">{{ $stats['pending_tasks'] }}</h4>
                        </div>
                        <span class="avatar bg-warning-transparent rounded-circle"><i class="ti ti-hourglass-low fs-20" style="color:#2ea4dc"></i></span>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-sm-6">
            <div class="card border-0 shadow-sm">
                <div class="card-body">
                    <div class="d-flex align-items-center justify-content-between">
                        <div>
                            <p class="text-muted mb-1">Completed</p>
                            <h4 class="mb-0 text-success">{{ $stats['completed_tasks'] }}</h4>
                        </div>
                        <span class="avatar bg-success-transparent rounded-circle"><i class="ti ti-check-circle fs-20 text-success"></i></span>
                    </div>
                </div>
            </div>
        </div>
        @if($userRole === 'admin')
            <div class="col-md-3 col-sm-6">
                <div class="card border-0 shadow-sm">
                    <div class="card-body">
                        <div class="d-flex align-items-center justify-content-between">
                            <div>
                                <p class="text-muted mb-1">Total Users</p>
                                <h4 class="mb-0">{{ $stats['total_users'] }}</h4>
                            </div>
                            <span class="avatar bg-secondary-transparent rounded-circle"><i class="ti ti-users fs-20 text-secondary"></i></span>
                        </div>
                    </div>
                </div>
            </div>
        @endif
    </div>
</div>
@endsection

@section('scripts')
<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
<script>
const deptStats = @json($deptStats);

document.addEventListener("DOMContentLoaded", function () {
    Object.entries(deptStats).forEach(([name, data]) => {
        const cleanId = `chart-${name.replace(/\s+/g, '-').replace(/&/g, 'and')}`;
        const element = document.getElementById(cleanId);
        if (!element) return;

        new ApexCharts(element, {
            chart: { type: 'donut', height: 200 },
            series: [
                Number(data.pending),
                Number(data.completed),
                Number(data.in_progress),
                Number(data.cancelled)
            ],
            labels: ['Pending', 'Completed', 'In Progress', 'Cancelled'],
            colors: ['#2ea4dc', '#026e1f', '#00cfe8', '#ea5455'],
            legend: { show: false },
            plotOptions: {
                pie: {
                    donut: {
                        size: '55%',
                        labels: {
                            show: true,
                            total: {
                                show: true,
                                label: 'Total',
                                formatter: () => data.total
                            }
                        }
                    }
                }
            }
        }).render();
    });
});
</script>
@endsection
