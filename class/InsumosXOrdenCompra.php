<?php 
require_once("Conexion.php");

class InsumosXOrdenCompra{
    public $idordencompra;
    public $idinsumo;
    public $costounitario;
    public $cantidadbueno;
    public $cantidadmalo;
    public $valorbueno;
    public $valormalo;
    //
    public static function Create($obj){
        try {
            $created = true;
            require_once("Insumo.php");
            foreach ($obj as $item) {             
                $sql="INSERT INTO insumosxordencompra   (id, idordencompra, idinsumo, costounitario, cantidadbueno, cantidadmalo, valorbueno, valormalo)
                    VALUES (uuid(), :idordencompra, :idinsumo, :costounitario, :cantidadbueno, :cantidadmalo, :valorbueno, :valormalo)";
                $param= array(':idordencompra'=>$item->idordencompra, 
                    ':idinsumo'=>$item->idinsumo,
                    ':costounitario'=>$item->costounitario, 
                    ':cantidadbueno'=>$item->cantidadbueno, 
                    ':cantidadmalo'=>$item->cantidadmalo,
                    ':valorbueno'=>$item->valorbueno,
                    ':valormalo'=>$item->valormalo
                );
                $data = DATA::Ejecutar($sql,$param,false);                
                if($data){
                    // Actualiza los saldos y calcula promedio
                    Insumo::UpdateSaldoPromedio($item->idinsumo, $item->cantidadbueno, $item->valorbueno);
                }
                else $created= false;
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
            $updated= self::Delete($obj[0]->costounitario);
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
            $sql='DELETE FROM insumosxordencompra  
                WHERE costounitario= :costounitario';
            $param= array(':costounitario'=> $_idproductotemporal);
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