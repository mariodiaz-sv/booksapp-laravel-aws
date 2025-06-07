<?php

use Illuminate\Support\Facades\Route;

/*Route::get('/', function () {
    return view('welcome');
});*/

//add
use App\Http\Controllers\BookController;

Route::get('/', [BookController::class, 'index']);
Route::resource('books', BookController::class);