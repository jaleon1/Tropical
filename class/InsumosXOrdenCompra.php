<?php 
require_once("Conexion.php");
require_once("InventarioProducto.php");
require_once("InventarioInsumo.php");

class InsumosXOrdenCompra{
    public $idOrdenCompra;
    public $OrdenCompra;
    public $idInsumo;
    public $costoUnitario;
    public $cantidadBueno;
    public $cantidadMalo;
    public $valorBueno;
    public $valorMalo;
    //
    public static function Create($obj){
        try {
            $created = true;
            require_once("Insumo.php");
            foreach ($obj as $item) {             
                $sql="INSERT INTO insumosXOrdenCompra   (id, idOrdenCompra, idInsumo, costoUnitario, cantidadBueno, cantidadMalo, valorBueno, valorMalo)
                    VALUES (uuid(), :idOrdenCompra, :idInsumo, :costoUnitario, :cantidadBueno, :cantidadMalo, :valorBueno, :valorMalo)";
                $param= array(':idOrdenCompra'=>$item->idOrdenCompra, 
                    ':idInsumo'=>$item->idInsumo,
                    ':costoUnitario'=>$item->costoUnitario, 
                    ':cantidadBueno'=>$item->cantidadBueno, 
                    ':cantidadMalo'=>$item->cantidadMalo,
                    ':valorBueno'=>$item->valorBueno,
                    ':valorMalo'=>$item->valorMalo
                );
                $data = DATA::Ejecutar($sql,$param,false);                
                if($data){
                    // Actualiza los saldos y calcula promedio
                    if($item->esVenta==0) { // 0= articulo
                        InventarioProducto::entrada($item->idInsumo, $item->idOrdenCompra, $item->cantidadBueno, $item->costoUnitario);
                    }
                    else { // -1= insumo.
                        InventarioInsumo::entrada($item->idInsumo, $item->idOrdenCompra, $item->cantidadBueno, $item->costoUnitario);
                    }
                }
                else $created= false;
            }
            return $created;
        }     
        catch(Exception $e) {
            return false;
        }
    }

    public static function Read($idOrdenCompra){
        try {
            $sql='SELECT `insumosXOrdenCompra`.`id`,
                `insumosXOrdenCompra`.`idOrdenCompra`,
                `insumosXOrdenCompra`.`idInsumo`,
                `insumosXOrdenCompra`.`costoUnitario`,
                `insumosXOrdenCompra`.`cantidadBueno`,
                `insumosXOrdenCompra`.`cantidadMalo`,
                `insumosXOrdenCompra`.`valorBueno`,
                `insumosXOrdenCompra`.`valorMalo`
            FROM `tropical`.`insumosXOrdenCompra`
                where idOrdenCompra=:idOrdenCompra';
            $param= array(':idOrdenCompra'=>$idOrdenCompra);
            $data= DATA::Ejecutar($sql,$param);
            return $data;
        }     
        catch(Exception $e) {
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar el ordenCompra'))
            );
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