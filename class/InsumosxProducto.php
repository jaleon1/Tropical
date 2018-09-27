<?php 
require_once("Conexion.php");

class InsumosxProducto{
    public $idInsumo;
    public $idProductoTemporal;
    public $cantidad;
    public $costo;

    public static function Create($obj){
        try {
            $created = true;
            foreach ($obj as $insprod) {
                
                //Selecciona la cantidad de Insumos
                $sql_insumo="SELECT bueno FROM insumo WHERE id=:idInsumo";
                $param_insumo= array(':idInsumo'=>$insprod->idInsumo);
                $data_cantidad = DATA::Ejecutar($sql_insumo,$param_insumo);
                $cantidad_insumo = $data_cantidad[0][0] - $insprod->cantidad;

                //Actualiza la cantidad de Insumos
                $sql_insumo="UPDATE insumo SET bueno=:bueno WHERE id=:idInsumo";
                $param_insumo= array(':bueno'=>$cantidad_insumo, ':idInsumo'=>$insprod->idInsumo);
                $data_insumo = DATA::Ejecutar($sql_insumo,$param_insumo,false);
                
                //Inserta en tabla intermedia insumos y productos
                $sql="INSERT INTO insumosxproducto   (id, idInsumo, idProductoTemporal, cantidad, costo)
                VALUES (uuid(), :idInsumo, :idProductoTemporal, :cantidad, :costo)";
                $param= array(':idInsumo'=>$insprod->idInsumo, ':idProductoTemporal'=>$insprod->idProductoTemporal, 
                ':cantidad'=>$insprod->cantidad, ':costo'=>$insprod->costo);
                $data = DATA::Ejecutar($sql,$param,false);
                
                if(!$data and !$data_insumo)
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
            $updated= self::Delete($obj[0]->idProductoTemporal);
            // crea los nuevos objetos
            $updated= self::Create($obj);
            return $updated;
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            return false;
        }
    }

    public static function Delete($_idproductotemporal){
        try {                 
            $sql='DELETE FROM insumosxproducto  
                WHERE idProductoTemporal= :idProductoTemporal';
            $param= array(':idProductoTemporal'=> $_idproductotemporal);
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