<?php 
require_once("Conexion.php");

class CategoriasXProducto{
    public $idCategoria;
    public $idProducto;

    public static function Create($obj){
        try {
            $created = true;
            foreach ($obj as $catprod) {
                $sql="INSERT INTO categoriasXProducto   (idCategoria, idProducto)
                VALUES (:idCategoria, :idProducto)";
                //
                $param= array(':idCategoria'=>$catprod->idCategoria, ':idProducto'=>$catprod->idProducto);
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
            $updated= self::Delete($obj[0]->idProducto);
            // crea los nuevos objetos
            $updated= self::Create($obj);
            return $updated;
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            return false;
        }
    }

    public static function Delete($_idproducto){
        try {                 
            $sql='DELETE FROM categoriasXProducto  
                WHERE idProducto= :idProducto';
            $param= array(':idProducto'=> $_idproducto);
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