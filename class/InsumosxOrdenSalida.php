<?php 
require_once("Conexion.php");

class InsumosxOrdenSalida{
    public $idInsumo;
    public $cantidad;
    public $costoPromedio;
    public $saldoCantidad=0.00;

    function Read($idOrdenSalida){
        try {
            $sql='SELECT `insumosXOrdenSalida`.`idOrdenSalida`,
            `insumosXOrdenSalida`.`id`,
            `insumosXOrdenSalida`.`idInsumo`,
            (SELECT nombre FROM insumo WHERE id=`insumosXOrdenSalida`.`idInsumo`) AS nombreInsumo,
            (SELECT codigo FROM insumo WHERE id=`insumosXOrdenSalida`.`idInsumo`) AS codigo,
            `insumosXOrdenSalida`.`cantidad`,
            `insumosXOrdenSalida`.`costoPromedio`
            FROM `tropical`.`insumosXOrdenSalida` WHERE idOrdenSalida=:id';
            $param= array(':id'=>$idOrdenSalida);
            $data= DATA::Ejecutar($sql,$param);
            return $data;
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
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
                // inventario
                //InventarioInsumo::salida( $ins_orden->idInsumo, $ins_orden->idOrdenSalida, $ins_orden->cantidad);
                if(!$data and !$data_insumo)
                    $created= false;
            }
            return $created;
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
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
                $sql_insumo1="SELECT cantidad FROM insumosXOrdenSalida WHERE idOrdenSalida=:idOrdenSalida AND idInsumo=:idInsumo";
                
                $param_orden1= array(':idOrdenSalida'=>$ins_orden->idOrdenSalida,':idInsumo'=>$ins_orden->idInsumo);
                $cantidadorden= DATA::Ejecutar($sql_insumo1,$param_orden1);
                
                $saldoCantidad = floatval($cantidadinsumo[0]["saldoCantidad"]) + floatval($cantidadorden[0]["cantidad"]);
                // $saldoCantidad = (real)$cantidadorden[0]['cantidad'];
                
                //Actualiza la cantidad de Insumos
                $sql_insumo="UPDATE insumo SET saldoCantidad=:saldoCantidad WHERE id=:idInsumo";
                $param= array(':saldoCantidad'=>$saldoCantidad, ':idInsumo'=>$ins_orden->idInsumo);
                $data_insumo = DATA::Ejecutar($sql_insumo,$param,false);
                
                if(!$data_insumo)
                $created= false;
            }
            return $created;
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            return false;
        }
    }

    public static function UpdateSaldoCantidadInsumo2($insumo){
        try {
            $created = true;
            foreach($insumo as $ins) { 
                //Selecciona la cantidad de Insumos
                $sql_insumo="SELECT saldoCantidad FROM insumo WHERE id=:idInsumo";
                $param_insumo= array(':idInsumo'=>$ins['idInsumo']);
                $cantidadinsumo = DATA::Ejecutar($sql_insumo,$param_insumo);
                
                //Selecciona la cantidad de Insumos
                $sql_insumo="SELECT cantidad FROM insumosXOrdenSalida WHERE idOrdenSalida=:idOrdenSalida AND idInsumo=:idInsumo";
                $param_orden= array(':idOrdenSalida'=>$ins['idOrdenSalida'],':idInsumo'=>$ins['idInsumo']);
                $cantidadorden = DATA::Ejecutar($sql_insumo,$param_orden);
                
                $saldoCantidad = $cantidadinsumo[0][0] + $cantidadorden[0][0];

                //Actualiza la cantidad de Insumos
                $sql_insumo="UPDATE insumo SET saldoCantidad=:saldoCantidad WHERE id=:idInsumo";
                $param= array(':saldoCantidad'=>$saldoCantidad, ':idInsumo'=>$ins['idInsumo']);
                $data_insumo = DATA::Ejecutar($sql_insumo,$param,false);

                if(!$data_insumo)
                $created= false;
            }
            $sql='DELETE FROM insumosXOrdenSalida  
            WHERE idOrdenSalida=:idOrdenSalida';
            $param= array(':idOrdenSalida'=>$insumo[0]['idOrdenSalida']);
            $data= DATA::Ejecutar($sql, $param, false);
            
            return $created;
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
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
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al actualizar producto'))
            );
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
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            return false;
        }
    }
}
?>