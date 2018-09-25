<?php 
require_once("Conexion.php");
require_once("Producto.php");
define('ERROR_ENTRADA_INVENTARIO', '-650');
define('ERROR_SALIDA_INVENTARIO', '-651');

class InventarioProducto{
    //public static $idOrdenEntrada;
    // public static $idOrdenSalida;
    public static $idOrden; // entrada o salida
    public static $idProducto;
    public static $entrada; // cantidad
    public static $salida;  // cantidad
    public static $saldo;   // cantidad
    public static $costoUnitario; // costo unitario.
    public static $valorEntrada;
    public static $valorSalida;
    public static $valorSaldo;
    public static $fecha;
    public static $costoPromedio; // valor actual.
    public static $saldoCantidad; // valor actual.
    public static $saldoCosto; // valor actual.
    //
    // Agrega la entrada al histórico de inventario y actualiza los valores actuales del producto.
    //
    public static function entrada($idProducto, $inOrden, $inCantidad, $inCostoUnitario){
        try {
            $sql="SELECT saldoCantidad, saldoCosto 
                FROM producto WHERE id=:idProducto;";
            $param = array(':idProducto'=>$idProducto);
            $data = DATA::Ejecutar($sql,$param);
            if($data){
                // calculo de saldos.
                self::$saldoCantidad = $data[0]['saldoCantidad'] + $inCantidad;
                self::$saldoCosto = $data[0]['saldoCosto'] + floatval($inCostoUnitario * $inCantidad);
                self::$costoPromedio = self::$saldoCosto / self::$saldoCantidad;
                // agrega ENTRADA histórico inventario.
                $sql="INSERT INTO inventarioProducto  (id, idOrdenEntrada, idProducto, entrada, saldo, costoAdquisicion, valorEntrada, valorSaldo, costoPromedio)
                    VALUES (uuid(), :idOrdenEntrada, :idProducto, :entrada, :saldo, :costoAdquisicion, :valorEntrada, :valorSaldo, :costoPromedio);";
                $param= array(':idOrdenEntrada'=>$inOrden,
                    ':idProducto'=>$idProducto,
                    ':entrada'=>$inCantidad,
                    ':saldo'=>self::$saldoCantidad, 
                    ':costoAdquisicion'=>$inCostoUnitario,
                    ':valorEntrada'=>floatval($inCostoUnitario * $inCantidad),
                    ':valorSaldo'=>self::$saldoCosto,
                    ':costoPromedio'=>self::$costoPromedio
                );
                $data = DATA::Ejecutar($sql, $param, false);
                if($data){
                    // actualiza saldos.
                    $sql = 'UPDATE producto
                        SET saldoCantidad=:saldoCantidad, saldoCosto=:saldoCosto, costoPromedio=:costoPromedio
                        WHERE id=:idProducto;';
                    $param = array(':idProducto'=>$idProducto, ':saldoCantidad'=>self::$saldoCantidad, ':saldoCosto'=>self::$saldoCosto, ':costoPromedio'=>self::$costoPromedio);
                    $data = DATA::Ejecutar($sql, $param, false);
                    if($data) 
                        return true;
                    else throw new Exception('Error al consultar actualizar los saldos de producto ('.$idProducto.')' , ERROR_ENTRADA_INVENTARIO);        
                }
                else throw new Exception('Error al consultar insertar la entrada de inventario ('.$idProducto.')' , ERROR_ENTRADA_INVENTARIO);
            } 
            else throw new Exception('Error al consultar el codigo del producto para actualizar inventario ('.$idProducto.')' , ERROR_ENTRADA_INVENTARIO);
        }
        catch(Exception $e) {
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }
    //
    // Agrega la salida al histórico de inventario y actualiza los valores actuales del producto.
    //
    public static function salida($idProducto, $inOrden, $inCantidad, $inCostoUnitario){
        try {
            $sql="SELECT saldoCantidad, saldoCosto 
                FROM producto WHERE id=:idProducto;";
            $param = array(':idProducto'=>$outItem->id);
            $data = DATA::Ejecutar($sql,$param);
            if($data){
                // calculo de saldos.
                $outItem->saldoCantidad = $data[0]['saldoCantidad'] - $outItem->cantidad;
                $outItem->saldoCosto = $data[0]['saldoCosto'] - floatval($outItem->costoUnitario * $outItem->cantidad);
                // agrega ENTRADA histórico inventario.
                $sql="INSERT INTO inventarioProducto  (id, idOrdenSalida, idProducto, salida, saldo, valorSalida, valorSaldo)
                    VALUES (uuid(), :idOrdenSalida, :idProducto, :entrada, :saldo, :valorSalida, :valorSaldo );";
                $param= array(':idOrdenSalida'=>$outItem->idOrden, 
                    ':idProducto'=>$outItem->id,
                    ':entrada'=>$outItem->cantidad,
                    ':saldo'=>$outItem->saldoCantidad, 
                    ':valorSalida'=>floatval($outItem->costoUnitario * $outItem->cantidad),
                    ':valorSaldo'=>$outItem->saldoCosto
                );
                $data = DATA::Ejecutar($sql, $param, false);
                if($data){
                    // actualiza saldos.
                    $sql = 'UPDATE producto
                        SET saldoCantidad=:saldoCantidad, saldoCosto=:saldoCosto
                        WHERE id=:idProducto;';
                    $param = array(':idProducto'=>$outItem->id, ':saldoCantidad'=>$outItem->saldoCantidad, ':saldoCosto'=>$outItem->saldoCosto);
                    $data = DATA::Ejecutar($sql, $param, false);
                    if($data) 
                        return true;
                    else throw new Exception('Error al consultar actualizar los saldos de producto ('.$outItem->id.')' , ERROR_ENTRADA_INVENTARIO);        
                }
                else throw new Exception('Error al consultar insertar la entrada de inventario ('.$outItem->id.')' , ERROR_ENTRADA_INVENTARIO);
            } 
            else throw new Exception('Error al consultar el codigo del producto para actualizar inventario ('.$outItem->id.')' , ERROR_ENTRADA_INVENTARIO);
        }
        catch(Exception $e) {
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }

}
?>