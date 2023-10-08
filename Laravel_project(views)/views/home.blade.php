<link href="{{ asset('css/app.css') }}" rel="stylesheet" type="text/css" >
@extends('layouts.app') <!-- app.blade.php vrchna lista -->

@section('content')

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">
                    <div class="w-50 bg-blie-300">
                    {{ __('Dashboard') }}
                    </div>
                </div>

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
<br>
<br>


@foreach($project_v as $value)
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header p-3 mb-2 bg-primary text-white">{{ $value->project_name }}</div>

                <div class="card-body">
                    <div class="col"> Termín dokončenia: {{ $value->deadline }} </div>
                    <div class="col"> <button type="button" class="btn btn-primary">Detail</button></div>

                </div>
            </div>
        </div>
    </div>
</div>
<br>
@endforeach












TESTOVACÍ DOKUMENT

<br><br>
<strong>Database Connected: </strong>
<?php
    try {
        \DB::connection()->getPDO();
        echo \DB::connection()->getDatabaseName();
        } catch (\Exception $e) {
        echo 'None';
    }
?>

<br><br>
skrina: {{ check_stock(1) }} <br>
stol: {{ check_stock(2) }} <br>
skrina_2: {{ check_stock(3) }} <br>




@endsection
