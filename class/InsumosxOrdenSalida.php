<?php 
require_once("Conexion.php");

class InsumosxOrdenSalida{
    public $idInsumo;
    public $cantidad;
    public $costoPromedio;

    function Read($idOrdenSalida){
        try {
            $sql='SELECT `insumosXOrdenSalida`.`idOrdenSalida`,
            `insumosXOrdenSalida`.`id`,
            `insumosXOrdenSalida`.`idInsumo`,
            (SELECT nombre FROM insumo WHERE id=`insumosXOrdenSalida`.`idInsumo`) AS nombreInsumo,
            `insumosXOrdenSalida`.`cantidad`,
            `insumosXOrdenSalida`.`costoPromedio`
            FROM `tropical`.`insumosXOrdenSalida` WHERE idOrdenSalida=:id';
            $param= array(':id'=>$idOrdenSalida);
            $data= DATA::Ejecutar($sql,$param);
            return $data;
        }     
        catch(Exception $e) {
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar el producto'))
            );
        }
    }

    public static function Create($obj){
        try {
            $created = true;
            foreach ($obj as $ins_orden) {
                //Selecciona la cantidad de Insumos
                $sql_insumo="SELECT saldoCantidad,costoPromedio FROM insumo WHERE id=:idInsumo";
                $param_insumo= array(':idInsumo'=>$ins_orden->idInsumo);
                $data_insumo = DATA::Ejecutar($sql_insumo,$param_insumo);
                $saldoCantidad = $data_insumo[0][0] - $ins_orden->cantidad;
                $saldoCosto = $data_insumo[0][1] * $saldoCantidad;

                //Actualiza la cantidad de Insumos
                $sql_insumo="UPDATE insumo SET saldoCantidad=:saldoCantidad, saldoCosto=:saldoCosto WHERE id=:idInsumo";
                $param_insumo= array(':saldoCantidad'=>$saldoCantidad, ':saldoCosto'=>$saldoCosto, ':idInsumo'=>$ins_orden->idInsumo);
                $data_insumo = DATA::Ejecutar($sql_insumo,$param_insumo,false);
                
                //Inserta en tabla intermedia insumos y productos
                $sql="INSERT INTO insumosXOrdenSalida (id,idOrdenSalida, idInsumo, cantidad, costoPromedio)
                VALUES (uuid(),:idOrdenSalida, :idInsumo, :cantidad, :costoPromedio)";
                $param= array(':idOrdenSalida'=>$ins_orden->idOrdenSalida, ':idInsumo'=>$ins_orden->idInsumo,':cantidad'=>$ins_orden->cantidad, ':costoPromedio'=>$ins_orden->costoPromedio);
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

    public static function UpdateSaldoCantidadInsumo($obj){
        try {
            $created = true;
            foreach ($obj as $ins_orden) {
                //Selecciona la cantidad de Insumos
                $sql_insumo="SELECT saldoCantidad FROM insumo WHERE id=:idInsumo";
                $param_insumo= array(':idInsumo'=>$ins_orden->idInsumo);
                $cantidadinsumo = DATA::Ejecutar($sql_insumo,$param_insumo);
                
                //Selecciona la cantidad de Insumos
                $sql_insumo="SELECT cantidad FROM insumosXOrdenSalida WHERE idOrdenSalida=:idOrdenSalida AND idInsumo=:idInsumo";
                $param_orden= array(':idOrdenSalida'=>$ins_orden->idOrdenSalida,':idInsumo'=>$ins_orden->idInsumo);
                $cantidadorden = DATA::Ejecutar($sql_insumo,$param_orden);
                
                $saldoCantidad = $cantidadinsumo[0][0] + $cantidadorden[0][0];

                //Actualiza la cantidad de Insumos
                $sql_insumo="UPDATE insumo SET saldoCantidad=:saldoCantidad WHERE id=:idInsumo";
                $param= array(':saldoCantidad'=>$saldoCantidad, ':idInsumo'=>$ins_orden->idInsumo);
                $data_insumo = DATA::Ejecutar($sql_insumo,$param,false);
            
                if(!$data_insumo)
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
            // Devuelve el valor restado a los insumos
            $updated= self::UpdateSaldoCantidadInsumo($obj);
            // elimina todos los objetos relacionados
            $updated= self::Delete($obj[0]->idOrdenSalida);
            // crea los nuevos objetos
            $updated= self::Create($obj);
            return $updated;
        }     
        catch(Exception $e) {
            return false;
        }
    }

    public static function Delete($_idordensalida){
        try {                 
            $sql='DELETE FROM insumosXOrdenSalida  
                WHERE idOrdenSalida= :idOrdenSalida';
            $param= array(':idOrdenSalida'=> $_idordensalida);
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