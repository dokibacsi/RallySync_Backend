<?php

namespace App\Http\Controllers;

use App\Models\Category;
use App\Models\Compcateg;
use App\Models\Competition;
use App\Models\User;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Validator;

class CompetitionController extends Controller
{
    public function index(){return Competition::all();}
    public function store(Request $request){
        // Ellenőrizzük, hogy van-e validációs hiba
        $request->validate([
            'headerimage' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048', // max 2MB
        ]);

        // Létrehozzuk a versenyt
        $competition = new Competition();
        $competition->fill($request->except('headerimage')); // Az image mezőt kivesszük


        // Ha van feltöltött kép, akkor elmentjük
        if ($request->hasFile('headerimage')) {
            $file = $request->file('headerimage');
            $filename = time() . '_' . $file->getClientOriginalName();
            $file->move(public_path('uploads'), $filename);

            // Az elérési út mentése az adatbázisba
            $competition->headerimage = 'uploads/' . $filename;
        }

        $competition->save();

        // Létrehozzuk a verseny kategóriákat
        foreach ($request["category"] as $category) {
            $cc = new Compcateg();
            $cc->fill($request->all());
            $cc->competition = $competition->comp_id;
            $cc->category = $category;
            $cc->save();
        }

        return response()->json([
            'message' => 'Competition successfully created!',
            'competition' => $competition
        ], 201);}
    public function show(string $id){
        return DB::select('
        SELECT o.name, c.event_name, p.place, c.description, c.start_date, c.end_date
            FROM competitions c
            INNER JOIN places p ON c.place = p.plac_id
            INNER JOIN users o ON c.organiser = o.id
        WHERE c.organiser = ?
    ', [$id]);}
    public function update(Request $request, string $id){
        // Verseny keresése
        $competition = Competition::findOrFail($id);

        // Versenyadatok módosítása
        $competition->update($request->only([
            'event_name',
            'place',
            'organiser',
            'description',
            'start_date',
            'end_date',
            'header_img'
        ]));


        return response()->json(['message' => 'Verseny sikeresen frissítve!'], 200);}

    public function destroy(string $id){
        Compcateg::where('competition', $id)->delete(); 
        Competition::find($id)->delete(); 
        return response()->json(['message' => 'Verseny és kapcsolódó kategóriák sikeresen törölve!'], 200);}

    public function isOrganiser(string $id){
        $user = User::find($id);
        return $user->permission == 2;}
    public function myCompetitions(string $id){
        return DB::select(
            "select cs.comp_id as id, cs.event_name as compname, pl.place as place, cs.start_date as start, cs.end_date as end, GROUP_CONCAT(IFNULL(cy.category, 'N/A') ORDER BY cy.category SEPARATOR ', ') as category, cs.headerimage as headerimage
            from competitions cs
            inner join compcategs cc on cc.competition = cs.comp_id
            inner join places pl on cs.place = pl.plac_id
            inner join categories cy on cc.category = cy.categ_id  
            where organiser = ?
            GROUP BY cs.comp_id, cs.event_name, pl.place, cs.start_date, cs.end_date, cs.headerimage",
            [$id]
        );}

    public function mySelectedCompetition(string $cid){
        return DB::select(
            "SELECT 
            cs.event_name AS event_name, 
            cs.place AS place, 
            cs.start_date AS start_date, 
            cs.end_date AS end_date, 
            GROUP_CONCAT(DISTINCT cc.category ORDER BY cc.category SEPARATOR ', ') AS category, 
            cs.description AS description, 
            MIN(cc.min_entry) AS min_entry, 
            MAX(cc.max_entry) AS max_entry, 
            cs.organiser AS organiser,
            cs.headerimage as headerimage
        FROM competitions cs
        LEFT JOIN compcategs cc ON cc.competition = cs.comp_id
        LEFT JOIN categories cy ON cc.category = cy.categ_id  
        WHERE cs.comp_id = ?
        GROUP BY cs.comp_id, cs.event_name, cs.place, cs.start_date, cs.end_date, cs.description, cs.organiser, cs.headerimage",
            [$cid]
        );}

    public function myCompletedCompetitions(string $id){
        return DB::select(
            "
            select cs.comp_id as id, cs.event_name as compname, pl.place as place, cs.start_date as start, cs.end_date as end, 
        GROUP_CONCAT(IFNULL(cy.category, 'N/A') ORDER BY cy.category SEPARATOR ', ') as category, cs.headerimage as headerimage
        from competitions cs
        inner join compcategs cc on cc.competition = cs.comp_id
        inner join places pl on cs.place = pl.plac_id
        inner join categories cy on cc.category = cy.categ_id  
        where organiser = ? and cs.end_date < NOW()
        GROUP BY cs.comp_id, cs.event_name, pl.place, cs.start_date, cs.end_date, cs.headerimage
        ",
            [$id]
        );}

    public function myCurrentlyCompetitions(string $id){
        return DB::select(
            "select cs.comp_id as id, cs.event_name as compname, pl.place as place, cs.start_date as start, cs.end_date as end, 
        GROUP_CONCAT(IFNULL(cy.category, 'N/A') ORDER BY cy.category SEPARATOR ', ') as category, cs.headerimage as headerimage
        from competitions cs
        inner join compcategs cc on cc.competition = cs.comp_id
        inner join places pl on cs.place = pl.plac_id
        inner join categories cy on cc.category = cy.categ_id  
        where organiser = ? and (cs.start_date <= NOW() and cs.end_date >= NOW()) 
        GROUP BY cs.comp_id, cs.event_name, pl.place, cs.start_date, cs.end_date, cs.headerimage",
            [$id]
        );}

    public function myUpcomingCompetitions(string $id){
        return DB::select(
            "select cs.comp_id as id, cs.event_name as compname, pl.place as place, cs.start_date as start, cs.end_date as end, 
        GROUP_CONCAT(IFNULL(cy.category, 'N/A') ORDER BY cy.category SEPARATOR ', ') as category, cs.headerimage as headerimage
        from competitions cs
        inner join compcategs cc on cc.competition = cs.comp_id
        inner join places pl on cs.place = pl.plac_id
        inner join categories cy on cc.category = cy.categ_id  
        where organiser = ? and cs.start_date > NOW()
        GROUP BY cs.comp_id, cs.event_name, pl.place, cs.start_date, cs.end_date, cs.headerimage",
            [$id]
        );}

    public function myCompetitionsOnSelectedDates(string $id, string $start, string $end){
        return DB::select(
            "select cs.comp_id as id, cs.event_name as compname, pl.place as place, cs.start_date as start, cs.end_date as end, 
        GROUP_CONCAT(IFNULL(cy.category, 'N/A') ORDER BY cy.category SEPARATOR ', ') as category, cs.headerimage as headerimage
        from competitions cs
        inner join compcategs cc on cc.competition = cs.comp_id
        inner join places pl on cs.place = pl.plac_id
        inner join categories cy on cc.category = cy.categ_id  
        where organiser = ? and (cs.start_date <= ? and cs.end_date >= ?)
        GROUP BY cs.comp_id, cs.event_name, pl.place, cs.start_date, cs.end_date, cs.headerimage",
            [$id, $start, $end]
        );}

    public function myCompetitionsOnSelectedPlace(string $id, string $place){
        return DB::select(
            "
            select cs.comp_id as id, cs.event_name as compname, pl.place as place, cs.start_date as start, cs.end_date as end, 
        GROUP_CONCAT(IFNULL(cy.category, 'N/A') ORDER BY cy.category SEPARATOR ', ') as category, cs.headerimage as headerimage
        from competitions cs
        inner join compcategs cc on cc.competition = cs.comp_id
        inner join places pl on cs.place = pl.plac_id
        inner join categories cy on cc.category = cy.categ_id  
        where organiser = ? and cs.place = ?
        GROUP BY cs.comp_id, cs.event_name, pl.place, cs.start_date, cs.end_date, cs.headerimage
        ",
            [$id, $place]
        );}

    public function legtobbetSzervezo(){
        return DB::select('
        SELECT c.organiser, u.name, COUNT(*) AS competition_number
        FROM competitions c
        JOIN users u ON c.organiser = u.id
        GROUP BY c.organiser, u.name
        HAVING COUNT(*) = (
            SELECT MAX(sub.competition_number)
            FROM (
                SELECT organiser, COUNT(*) AS competition_number
                FROM competitions
                GROUP BY organiser
            ) AS sub
        );
    ');}
}
