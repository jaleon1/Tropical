<?php 
require_once("Conexion.php");

class EventosXRol{
    public $idEvento;
    public $idRol;

    public static function Create($obj){
        try {
            $created = true;
            foreach ($obj as $everol) {
                $sql="INSERT INTO eventosXRol   (idEvento, idRol)
                    VALUES (:idEvento, :idRol)";
                //
                $param= array(':idEvento'=>$everol->idEvento, ':idRol'=>$everol->idRol);
                $data = DATA::Ejecutar($sql,$param,false);
                if(!$data)
                    $created= false;
            }
            return $created;
        }     
        catch(Exception $e) {
            return false;
        }
    }

    public static function Update($obj){
        try {
            $updated = true;
            // elimina todos los objetos relacionados
            $updated= self::Delete($obj[0]->idRol);
            // crea los nuevos objetos
            $updated= self::Create($obj);
            return $updated;
        }     
        catch(Exception $e) {
            return false;
        }
    }

    public static function Delete($_idrol){
        try {                 
            $sql='DELETE FROM eventosXRol  
                WHERE idRol= :idRol';
            $param= array(':idRol'=> $_idrol);
            $data= DATA::Ejecutar($sql, $param, false);
            if($data)
                return true;
            else false;
        }
        catch(Exception $e) {
            return false;
        }
    }
}
?>