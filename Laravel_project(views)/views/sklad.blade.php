@extends('layouts.app') <!-- app.blade.php vrchna lista -->


@section('content')
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">{{ __('Dashboard') }}</div>

                <div class="card-body">
                    @if (session('status'))
                        <div class="alert alert-success" role="alert">
                            {{ session('status') }}
                        </div>
                    @endif

                    {{ __('You are logged in!') }}
                </div>
            </div>
        </div>
    </div>
</div>

<h1>Materiál</h1> <div class="col">
    <a href="{{route('export_material')}}"><button type="button" class="btn btn-success">Exportovať do .xlsx</button></div></a>
<div class="table-responsive-md">
@include('layouts.tabulka_material')
</div>

<h1>Zásoby vlastenj výroby</h1>
    <a href="{{route('export_material')}}"><button type="button" class="btn btn-success">Exportovať do .xlsx</button></div></a>
<div class="table-responsive-md">
@include('layouts.tabulka_vyroba')
</div>

<h1>Tovar</h1>
    <a href="{{route('export_material')}}"><button type="button" class="btn btn-success">Exportovať do .xlsx</button></div></a>
<div class="table-responsive-md">
@include('layouts.tabulka_tovar')
</div>

@endsection
