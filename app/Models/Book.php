<?php


namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory; //add
use Illuminate\Database\Eloquent\Model;

class Book extends Model
{
    //add
    use HasFactory;

    protected $fillable = [
        'title',
        'author',
        'description'
    ];
}
