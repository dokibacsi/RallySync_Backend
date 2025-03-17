<?php

use App\Models\Place;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('places', function (Blueprint $table) {
            $table->id('plac_id');
            $table->string('place');
            $table->timestamps();
        });

        Place::create(['place' => 'Bugyboréktő']);
        Place::create(['place' => 'Ködpallag']);
        Place::create(['place' => 'Zsindelyvár']);
        Place::create(['place' => 'Lappantyószeg']);
        Place::create(['place' => 'Löszlak']);
        Place::create(['place' => 'Brekkerét']);
        Place::create(['place' => 'Boglyaszentmárton']);
        Place::create(['place' => 'Zsupposberek']);
        Place::create(['place' => 'Kenderzug']);
        Place::create(['place' => 'Morgósrév']);
        Place::create(['place' => 'Lankásfölde']);
        Place::create(['place' => 'Csipkéspatak']);
        Place::create(['place' => 'Sárszokoly']);
        Place::create(['place' => 'Zúgóbérc']);
        Place::create(['place' => 'Fenyérlapos']);
        Place::create(['place' => 'Pörcsmalom']);
        Place::create(['place' => 'Ványadomb']);
        Place::create(['place' => 'Nyűvösfalu']);
        Place::create(['place' => 'Kátyaspuszta']);
        Place::create(['place' => 'Bőgőstanya']);
        Place::create(['place' => 'Dörgőháza']);
        Place::create(['place' => 'Görbedék']);
        Place::create(['place' => 'Vakvölgypatak']);
        Place::create(['place' => 'Rögzug']);
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('places');
    }
};
