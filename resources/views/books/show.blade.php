@extends('layouts.app')

@section('content')
<div class="container">
    <div class="row">
        <div class="col-md-8 offset-md-2">
            <h1>Book Details</h1>
            <div class="card">
                <div class="card-header">
                    <h2>{{ $book->title }}</h2>
                </div>
                <div class="card-body">
                    <p><strong>Author:</strong> {{ $book->author }}</p>
                    <p><strong>Description:</strong> {{ $book->description }}</p>
                    <a href="{{ route('books.index') }}" class="btn btn-secondary">Back</a>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection