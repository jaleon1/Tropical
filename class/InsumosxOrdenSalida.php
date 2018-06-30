<?php 
require_once("Conexion.php");

class InsumosxOrdenSalida{
    public $idinsumo;
    public $cantidad;
    public $costopromedio;

    function Read($idordensalida){
        try {
            $sql='SELECT `insumosxordensalida`.`idordensalida`,
            `insumosxordensalida`.`id`,
            `insumosxordensalida`.`idinsumo`,
            (SELECT nombre FROM insumo WHERE id=`insumosxordensalida`.`idinsumo`) AS nombreinsumo,
            `insumosxordensalida`.`cantidad`,
            `insumosxordensalida`.`costopromedio`
            FROM `tropical`.`insumosxordensalida` WHERE idordensalida=:id';
            $param= array(':id'=>$idordensalida);
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
                $sql_insumo="SELECT saldocantidad,costopromedio FROM insumo WHERE id=:idinsumo";
                $param_insumo= array(':idinsumo'=>$ins_orden->idinsumo);
                $data_insumo = DATA::Ejecutar($sql_insumo,$param_insumo);
                $saldocantidad = $data_insumo[0][0] - $ins_orden->cantidad;
                $saldocosto = $data_insumo[0][1] * $saldocantidad;

                //Actualiza la cantidad de Insumos
                $sql_insumo="UPDATE insumo SET saldocantidad=:saldocantidad, saldocosto=:saldocosto WHERE id=:idinsumo";
                $param_insumo= array(':saldocantidad'=>$saldocantidad, ':saldocosto'=>$saldocosto, ':idinsumo'=>$ins_orden->idinsumo);
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

    public static function UpdateSaldoCantidadInsumo($obj){
        try {
            $created = true;
            foreach ($obj as $ins_orden) {
                //Selecciona la cantidad de Insumos
                $sql_insumo="SELECT saldocantidad FROM insumo WHERE id=:idinsumo";
                $param_insumo= array(':idinsumo'=>$ins_orden->idinsumo);
                $cantidadinsumo = DATA::Ejecutar($sql_insumo,$param_insumo);
                
                //Selecciona la cantidad de Insumos
                $sql_insumo="SELECT cantidad FROM insumosxordensalida WHERE idordensalida=:idordensalida AND idinsumo=:idinsumo";
                $param_orden= array(':idordensalida'=>$ins_orden->idordensalida,':idinsumo'=>$ins_orden->idinsumo);
                $cantidadorden = DATA::Ejecutar($sql_insumo,$param_orden);
                
                $saldocantidad = $cantidadinsumo[0][0] + $cantidadorden[0][0];

                //Actualiza la cantidad de Insumos
                $sql_insumo="UPDATE insumo SET saldocantidad=:saldocantidad WHERE id=:idinsumo";
                $param= array(':saldocantidad'=>$saldocantidad, ':idinsumo'=>$ins_orden->idinsumo);
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
            $updated= self::Delete($obj[0]->idordensalida);
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
            $sql='DELETE FROM insumosxordensalida  
                WHERE idordensalida= :idordensalida';
            $param= array(':idordensalida'=> $_idordensalida);
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