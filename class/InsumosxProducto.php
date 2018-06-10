<?php 
require_once("Conexion.php");

class InsumosxProducto{
    public $idinsumo;
    public $idproductotemporal;
    public $cantidad;
    public $costo;

    public static function Create($obj){
        try {
            $created = true;
            foreach ($obj as $insprod) {
                
                //Selecciona la cantidad de Insumos
                $sql_insumo="SELECT bueno FROM insumo WHERE id=:idinsumo";
                $param_insumo= array(':idinsumo'=>$insprod->idinsumo);
                $data_cantidad = DATA::Ejecutar($sql_insumo,$param_insumo);
                $cantidad_insumo = $data_cantidad[0][0] - $insprod->cantidad;

                //Actualiza la cantidad de Insumos
                $sql_insumo="UPDATE insumo SET bueno=:bueno WHERE id=:idinsumo";
                $param_insumo= array(':bueno'=>$cantidad_insumo, ':idinsumo'=>$insprod->idinsumo);
                $data_insumo = DATA::Ejecutar($sql_insumo,$param_insumo,false);
                
                //Inserta en tabla intermedia insumos y productos
                $sql="INSERT INTO insumosxproducto   (id, idinsumo, idproductotemporal, cantidad, costo)
                VALUES (uuid(), :idinsumo, :idproductotemporal, :cantidad, :costo)";
                $param= array(':idinsumo'=>$insprod->idinsumo, ':idproductotemporal'=>$insprod->idproductotemporal, 
                ':cantidad'=>$insprod->cantidad, ':costo'=>$insprod->costo);
                $data = DATA::Ejecutar($sql,$param,false);
                
                if(!$data and !$data_insumo)
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