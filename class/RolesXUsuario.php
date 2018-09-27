<?php 
require_once("Conexion.php");

class RolesXUsuario{
    public $idRol;
    public $idUsuario;

    public static function Create($obj){
        try {
            $created = true;
            foreach ($obj as $rolusr) {
                $sql="INSERT INTO rolesXUsuario   (idRol, idUsuario)
                VALUES (:idRol, :idUsuario)";
                //
                $param= array(':idRol'=>$rolusr->idRol, ':idUsuario'=>$rolusr->idUsuario);
                $data = DATA::Ejecutar($sql,$param,false);
                if(!$data)
                    $created= false;
            }
            return $created;
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            return false;
        }
    }

    public static function Update($obj){
        try {
            $updated = true;
            // elimina todos los objetos relacionados
            $updated= self::Delete($obj[0]->idUsuario);
            // crea los nuevos objetos
            $updated= self::Create($obj);
            return $updated;
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            return false;
        }
    }

    public static function Delete($_idusuario){
        try {                 
            $sql='DELETE FROM rolesXUsuario  
                WHERE idUsuario= :idUsuario';
            $param= array(':idUsuario'=> $_idusuario);
            $data= DATA::Ejecutar($sql, $param, false);
            if($data)
                return true;
            else false;
        }
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            return false;
        }
    }
}
?>