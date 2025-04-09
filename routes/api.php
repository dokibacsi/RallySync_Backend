<?php

use App\Http\Controllers\Auth\AuthenticatedSessionController;
use App\Http\Controllers\Auth\RegisteredUserController;
use App\Http\Controllers\CarController;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\CompcategController;
use App\Http\Controllers\CompeetController;
use App\Http\Controllers\CompetitionController;
use App\Http\Controllers\PlaceController;
use App\Http\Controllers\UserController;
use App\Http\Middleware\Admin;
use App\Http\Middleware\Competitor;
use App\Http\Middleware\Organiser;
use App\Models\Compeet;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::middleware(['auth:sanctum'])->get('/user', function (Request $request) {
    return $request->user();
});

Route::middleware(['auth:sanctum', Admin::class])->group(function () {
    route::get("/competitions", [CompetitionController::class, "index"]);
    route::get("/competition/{id}", [CompetitionController::class, "show"]);
    route::get("/compcategs", [CompcategController::class, "index"]);
    route::get("/compcateg/{id}", [CompcategController::class, "show"]);

    Route::post('/carUpload', [CarController::class, 'store']);
    Route::post('/placeUpload', [PlaceController::class, 'store']);
    Route::post('/categoryUpload', [CategoryController::class, 'store']);


    Route::delete('/placeDel/{id}', [PlaceController::class, 'destroy']);
    Route::delete('/carDel/{id}', [CarController::class, 'destroy']);
    Route::delete('/categoryDel/{id}', [CategoryController::class, 'destroy']);

    Route::patch('/carUpdate/{id}', [CarController::class, 'update']);
    Route::patch('/competitionUpdate/{id}', [CompetitionController::class, 'update']);
    Route::patch('/compcategUpdate/{id}', [CompcategController::class, 'update']);
    route::delete("/compCategDestroy/{id}", [CompcategController::class, 'destroy']);
});

Route::middleware(['auth:sanctum', Organiser::class])->group(function () {
    route::get("/places", [PlaceController::class, "index"]);
    route::get("/categories", [CategoryController::class, "index"]);
    route::post("/competition", [CompetitionController::class, "store"]);
    route::get("/myCompetitions/{id}", [CompetitionController::class, "myCompetitions"]);
    route::get("/entry-list/{id}", [CompeetController::class, "entryList"]);
    route::get("/my-selected-competition/{id}", [CompetitionController::class, "mySelectedCompetition"]);
    route::put("/update-competition/{id}", [CompetitionController::class, "update"]);
    route::delete("/delete-competition/{id}", [CompetitionController::class, "destroy"]);
    route::put("/update-user/{id}", [UserController::class, "update"]);
    route::get("/my-completed-competition/{id}", [CompetitionController::class, "myCompletedCompetitions"]);
    route::get("/my-currently-competition/{id}", [CompetitionController::class, "myCurrentlyCompetitions"]);
    route::get("/my-upcoming-competition/{id}", [CompetitionController::class, "myUpcomingCompetitions"]);
    route::get("/my-competition-on-selected-date/{id}/{start}/{end}", [CompetitionController::class, "myCompetitionsOnSelectedDates"]);
    route::get("/my-competition-on-selected-place/{id}/{place}", [CompetitionController::class, "myCompetitionsOnSelectedPlace"]);
});

Route::middleware(['auth:sanctum', Competitor::class])->group(function () {});

Route::get('/users', [UserController::class, 'index']);
Route::post('/users', [UserController::class, 'store']);
Route::get('/users/{id}', [UserController::class, 'show']);
Route::put('/users/{id}', [UserController::class, 'update']);
Route::delete('/users/{id}', [UserController::class, 'destroy']);
Route::patch('/users/{id}/update-password', [UserController::class, 'updatePassword']);

Route::get("/cars", [CarController::class, 'index']);
route::get("/car/{id}", [CarController::class, "show"]);
route::get("/compets-cars/{id}", [CarController::class, "CompetCars"]);
route::get("/szabadAutok", [CarController::class, "osszesSzabadAuto"]);

route::get("/place/{id}", [PlaceController::class, "show"]);


Route::post('/compeet', [CompeetController::class, 'store']);

Route::get('/mostUsedBrand', [CompeetController::class, "legtobbetHasznaltMarka"]);
Route::get('/mostUsedCateg', [CompeetController::class, "legtobbetHasznaltKategoria"]);
Route::get('/mostParticPlace', [CompeetController::class, "legtobbetVersenyzettTerulet"]);
Route::get('/fastestTime', [CompeetController::class, "leggyorsabbPajaido"]);
Route::get('/mostHostedOrg', [CompetitionController::class, "legtobbetSzervezo"]);

Route::post('/register', [RegisteredUserController::class, 'store']);
Route::post('/login', [AuthenticatedSessionController::class, 'store']);
