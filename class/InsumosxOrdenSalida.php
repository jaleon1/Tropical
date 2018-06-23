<?php 
require_once("Conexion.php");

class InsumosxOrdenSalida{
    public $idinsumo;
    public $idproductotemporal;
    public $cantidad;
    public $costopromedio;

    public static function Create($obj){
        try {
            $created = true;
            foreach ($obj as $ins_orden) {
                
                //Selecciona la cantidad de Insumos
                $sql_insumo="SELECT saldocantidad FROM insumo WHERE id=:idinsumo";
                $param_insumo= array(':idinsumo'=>$ins_orden->idinsumo);
                $data_cantidad = DATA::Ejecutar($sql_insumo,$param_insumo);
                $cantidad_insumo = $data_cantidad[0][0] - $ins_orden->cantidad;

                //Actualiza la cantidad de Insumos
                $sql_insumo="UPDATE insumo SET saldocantidad=:saldocantidad WHERE id=:idinsumo";
                $param_insumo= array(':saldocantidad'=>$cantidad_insumo, ':idinsumo'=>$ins_orden->idinsumo);
                $data_insumo = DATA::Ejecutar($sql_insumo,$param_insumo,false);
                
                //Inserta en tabla intermedia insumos y productos
                $sql="INSERT INTO insumosxordensalida (id,idordensalida, idinsumo, cantidad, costopromedio)
                VALUES (uuid(),:idordensalida, :idinsumo, :cantidad, :costopromedio)";
                $param= array(':idordensalida'=>$ins_orden->idordensalida, ':idinsumo'=>$ins_orden->idinsumo,':cantidad'=>$ins_orden->cantidad, ':costopromedio'=>$ins_orden->costopromedio);
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
            $sql='DELETE FROM insumoxordensalida  
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