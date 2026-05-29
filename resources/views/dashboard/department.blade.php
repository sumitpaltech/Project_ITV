@extends('layouts.base')
@section('title', $dept . ' Department')

@section('content')
<div class="container">
    <h3 class="mb-4">{{ $dept }} Department</h3>

    @php($data = $deptStats[$dept])

    <div class="row mb-4">
        <div class="col-md-4">
            <div class="card shadow-sm text-center"><div class="card-body">
                <h6>Total Tasks</h6><h4>{{ $data['total'] }}</h4>
            </div></div>
        </div>
        <div class="col-md-4">
            <div class="card shadow-sm text-center"><div class="card-body">
                <h6>Completed</h6><h4 class="text-success">{{ $data['completed'] }}</h4>
            </div></div>
        </div>
        <div class="col-md-4">
            <div class="card shadow-sm text-center"><div class="card-body">
                <h6>Pending</h6><h4 style="color:#2ea4dc;">{{ $data['pending'] }}</h4>
            </div></div>
        </div>
    </div>

    <hr>
    <h5 class="mb-3">Users Performance</h5>

    @if(count($users) === 0)
        <div class="alert alert-info text-center">No user data present in this department.</div>
    @else
        <div class="row">
            @foreach($users as $user)
                @if($user->username)
                    @php($stats = $userStats[$user->username] ?? [])
                    <div class="col-md-4 mb-4">
                        <div class="card shadow-sm">
                            <div class="card-body text-center">
                                <h6>
                                    <a href="{{ route('dashboard.user_tasks', ['username' => $user->username]) }}"
                                       style="text-decoration:none;">
                                        {{ $user->username }}
                                    </a>
                                </h6>
                                <small class="text-muted d-block mb-2">{{ $user->email ?? 'No Email' }}</small>
                                <div id="chart-{{ $user->username }}" style="height:200px;"></div>
                                <div class="mt-2 fw-bold">
                                    <span style="color:#2ea4dc;">{{ $stats['pending'] ?? 0 }} Pending</span> |
                                    <span style="color:#026e1f;">{{ $stats['completed'] ?? 0 }} Done</span>
                                </div>
                            </div>
                        </div>
                    </div>
                @endif
            @endforeach
        </div>
    @endif
</div>
@endsection

@section('scripts')
<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
<script>
const userStats = @json($userStats);
document.addEventListener("DOMContentLoaded", function () {
    Object.entries(userStats).forEach(([username, data]) => {
        const el = document.getElementById(`chart-${username}`);
        if (!el) return;
        new ApexCharts(el, {
            chart: { type: 'donut', height: 200 },
            series: [data.pending || 0, data.completed || 0, data.in_progress || 0, data.cancelled || 0],
            labels: ['Pending', 'Completed', 'In Progress', 'Cancelled'],
            colors: ['#2ea4dc', '#026e1f', '#00cfe8', '#ea5455'],
            legend: { show: false },
            plotOptions: {
                pie: {
                    donut: {
                        size: '55%',
                        labels: {
                            show: true,
                            total: { show: true, label: 'Total', formatter: () => data.total || 0 }
                        }
                    }
                }
            }
        }).render();
    });
});
</script>
@endsection
