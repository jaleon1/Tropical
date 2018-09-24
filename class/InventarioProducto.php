<?php 
require_once("Conexion.php");
require_once("Producto.php");

class InventarioProducto{
    public $idOrdenEntrada;
    public $idOrdenSalida;
    public $idProducto;
    public $entrada;
    public $salida;
    public $saldo;
    public $costoAdquisicion;
    public $valorEntrada;
    public $valorSalida;
    public $valorSaldo;
    public $costoPromedio;
    public $fecha;
    //
    public static function entrada($item){
        try {
            $created = true;
            $sql="SELECT saldoCantidad, saldoCosto, costoPromedio 
                FROM producto WHERE id=:idProducto;";
            $param = array(':idProducto'=>$item->id);
            $data = DATA::Ejecutar($sql,$param);
            //
            // $sql="SELECT fecha FROM ordenCompra WHERE id=:idOrdenEntrada;";
            // $param = array(':idOrdenEntrada'=>$item->idOrdenEntrada);
            // $fecha = DATA::Ejecutar($sql,$param);
            //                
            $sql="INSERT INTO inventarioProducto   (id, idOrdenEntrada, idProducto, entrada, saldo, costoAdquisicion, valorEntrada, valorSaldo, costoPromedio)
                VALUES (uuid(), :idOrdenEntrada, :idProducto, :entrada, :saldo, :costoAdquisicion, :valorEntrada, :valorSaldo, :costoPromedio);";
            $param= array(':idOrdenEntrada'=>$item->idOrdenEntrada, 
                ':idProducto'=>$item->id,
                ':entrada'=>$item->cantidad,
                ':saldo'=>$data[0]['saldoCantidad'], 
                ':costoAdquisicion'=>$item->costo, 
                ':valorEntrada'=>$item->costo * $item->cantidad,
                ':valorSaldo'=>$data[0]['saldoCosto'],
                ':costoPromedio'=>$data[0]['costoPromedio']
            );
            DATA::Ejecutar($sql,$param,false);                
            
            return $created;
        }     
        catch(Exception $e) {
            return false;
        }
    }

    public static function salida($obj){
        try {
            $created = true;
            foreach ($obj as $item) {          
                
                $sql="SELECT saldoCantidad, saldoCosto, costoPromedio FROM insumo WHERE id=:idProducto;";
                $param= array(':idProducto'=>$item->idProducto);
                $data=DATA::Ejecutar($sql,$param);              
                
                $sql="SELECT fecha FROM ordenSalida WHERE id=:idOrdenSalida;";
                $param= array(':idOrdenSalida'=>$item->idOrdenSalida);
                $fecha=DATA::Ejecutar($sql,$param);

                $costoAdquisicion = $item->cantidad*$item->costoPromedio;
                $sql="INSERT INTO inventarioProducto   (id, idOrdenSalida, idProducto, salida, saldo, costoAdquisicion, valorSalida, valorSaldo, costoPromedio, fecha)
                    VALUES (uuid(), :idOrdenSalida, :idProducto, :salida, :saldo, :costoAdquisicion, :valorSalida, :valorSaldo, :costoPromedio, :fecha)";
                $param= array(':idOrdenSalida'=>$item->idOrdenSalida, 
                    ':idProducto'=>$item->idProducto,
                    ':salida'=>$item->cantidad,
                    ':saldo'=>$data[0]['saldoCantidad'], 
                    ':costoAdquisicion'=>$item->costoPromedio,
                    ':valorSalida'=>(string)$costoAdquisicion,
                    ':valorSaldo'=>$data[0]['saldoCosto'],
                    ':costoPromedio'=>$data[0]['costoPromedio'],
                    ':fecha'=>$fecha[0]['fecha']
                );
                DATA::Ejecutar($sql,$param,false);                
            }
            return $created;
        }     
        catch(Exception $e) {
            return false;
        }
    }

}
?>