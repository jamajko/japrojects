<?php
use Illuminate\Support\Facades\DB;

function check_stock($project_id)
{
    $output = 'Missing: ';
    $material_missing = 0;
    $result_l = DB::table('project_lists')->where('project_id', $project_id)->get();

    for($i = 0; $i < sizeof($result_l); $i++){

        $length_l = $result_l[$i]->length;
        $width_l = $result_l[$i]->width;
        $material_id_l = $result_l[$i]->material_id;
        
        $length_m = DB::table('materials')->where('material_id', $material_id_l)->value('length');
        $width_m = DB::table('materials')->where('material_id', $material_id_l)->value('width');
        $name_m = DB::table('materials')->where('material_id', $material_id_l)->value('name');

        if($length_l >= $width_l){
            $a_l = $length_l;
            $b_l = $width_l;
        } else {
            $a_l = $width_l;
            $b_l = $length_l;
        }

        if($length_m >= $width_m){
            $a_m = $length_m;
            $b_m = $width_m;
        } else {
            $a_m = $width_m;
            $b_m = $length_m;
        }

        if($a_l>$a_m){ 
            $output .= $name_m;
            $output .= ', ';
            $material_missing = 1; 
        } else
        if($b_l>$b_m){ 
            $output .= $name_m;
            $output .= ', ';
            $material_missing = 1;  
        }
      }

    if($material_missing == 1) { return  $output; }
    else if($material_missing == 0) { return 'OK'; }
}