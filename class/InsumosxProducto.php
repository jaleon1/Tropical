<?php 
require_once("Conexion.php");

class InsumosxProducto{
    public $idinsumo;
    public $idproductotemporal;
    public $cantidad;

    public static function Create($obj){
        try {
            $created = true;
            foreach ($obj as $insprod) {
                $sql="INSERT INTO insumosxproducto   (id, idinsumo, idproductotemporal, cantidad)
                VALUES (uuid(), :idinsumo, :idproductotemporal, :cantidad)";
                //
                $param= array(':idinsumo'=>$insprod->idinsumo, ':idproductotemporal'=>$insprod->idproductotemporal, 
                ':cantidad'=>$insprod->cantidad);
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
            $updated= self::Delete($obj[0]->idproductotemporal);
            // crea los nuevos objetos
            $updated= self::Create($obj);
            return $updated;
        }     
        catch(Exception $e) {
            return false;
        }
    }

    public static function Delete($_idproductotemporal){
        try {                 
            $sql='DELETE FROM insumosxproducto  
                WHERE idproductotemporal= :idproductotemporal';
            $param= array(':idproductotemporal'=> $_idproductotemporal);
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