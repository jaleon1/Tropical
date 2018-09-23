<?php 
require_once("Conexion.php");

class InventarioInsumo{
    public $idOrdenCompra;
    public $idOrdensalida;
    public $idInsumo;
    public $entrada;
    public $salida;
    public $saldo;
    public $costoAdquisicion;
    public $valorEntrada;
    public $valorSalida;
    public $valorSaldo;
    public $costoPromedio;
    //
    public static function Create($obj){
        try {
            $created = true;
            require_once("Insumo.php");
            foreach ($obj as $item) {             
                
                $sql="INSERT INTO inventarioInsumo   (id, idOrdenCompra, idInsumo, entrada, saldo, costoAdquisicion, valorEntrada, valorSaldo, costoPromedio)
                    VALUES (uuid(), :idOrdenCompra, :idInsumo, :entrada, :saldo, :costoAdquisicion, :valorEntrada, :valorSaldo, :costoPromedio)";
                $param= array(':idOrdenCompra'=>$item->idOrdenCompra, 
                    ':idInsumo'=>$item->idInsumo,
                    ':entrada'=>$item->cantidadBueno,
                    ':saldo'=>'100', 
                    ':costoAdquisicion'=>$item->costoUnitario, 
                    ':valorEntrada'=>$item->valorBueno,
                    ':valorSaldo'=>'100',
                    ':costoPromedio'=>'100'
                );
                DATA::Ejecutar($sql,$param,false);                
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
            $updated= self::Delete($obj[0]->costoUnitario);
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
            $sql='DELETE FROM insumosXOrdenCompra  
                WHERE costoUnitario= :costoUnitario';
            $param= array(':costoUnitario'=> $_idproductotemporal);
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