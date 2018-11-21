<?php 
require_once("Conexion.php");
require_once("Insumo.php");
define('ERROR_ENTRADA_INVENTARIO_INSUMOXBODEGAXBODEGA', '-850');
define('ERROR_SALIDA_INVENTARIO_INSUMOXBODEGA', '-851');

class InventarioInsumoXBodega{
    // public $idOrdenCompra;
    // public $idOrdenSalida;
    public static $idOrden; // entrada o salida
    public static $idProducto; // insumo de bodega relacionado con producto (sabor - articulo).
    public static $idBodega;
    public static $entrada;
    public static $salida;
    public static $saldo;
    public static $costoUnitario;
    public static $valorEntrada;
    public static $valorSalida;
    public static $valorSaldo;
    public static $fecha;
    public static $costoPromedio; // valor actual.
    public static $saldoCantidad; // valor actual.
    public static $saldoCosto; // valor actual.
    //
    public static function entrada($idInsumo, $inOrden, $inCantidad, $inCostoUnitario){
        try {          
            $sql="SELECT saldoCantidad, saldoCosto 
                FROM insumosXBodega 
                WHERE id=:idInsumo;";
            $param = array(':idInsumo'=>$idInsumo);
            $data = DATA::Ejecutar($sql,$param);
            if($data){
                // calculo de saldos.
                self::$saldoCantidad = $data[0]['saldoCantidad'] + $inCantidad;
                self::$saldoCosto = $data[0]['saldoCosto'] + floatval($inCostoUnitario * $inCantidad);
                self::$costoPromedio = self::$saldoCosto / self::$saldoCantidad;
                // agrega ENTRADA histórico inventario. *** NO IMPLEMENTADO ***                
                // actualiza saldos.
                $sql = 'UPDATE insumosXBodega
                    SET saldoCantidad=:saldoCantidad, saldoCosto=:saldoCosto, costoPromedio=:costoPromedio
                    WHERE id=:idInsumo;';
                $param = array(':idInsumo'=>$idInsumo, ':saldoCantidad'=>self::$saldoCantidad, ':saldoCosto'=>self::$saldoCosto, ':costoPromedio'=>self::$costoPromedio);
                $data = DATA::Ejecutar($sql, $param, false);
                if($data) 
                    return true;
                else throw new Exception('Error al consultar actualizar los saldos de insumo ('.$idInsumo.')' , ERROR_ENTRADA_INVENTARIO_INSUMOXBODEGA);
            } 
            else throw new Exception('Error al consultar el codigo del insumo para actualizar inventario ('.$idInsumo.')' , ERROR_ENTRADA_INVENTARIO_INSUMOXBODEGA);
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
    //  actualiza los valores actuales del insumo. falta: Agrega la salida al histórico de inventario.
    //
    public static function salida($idProducto, $outOrden, $outCantidad){
        try {
            $sql="SELECT saldoCantidad, costoPromedio 
                FROM insumosXBodega 
                WHERE id=:idProducto and idBodega =:idBodega;";
            $param = array(':idProducto'=>$idProducto, ':idBodega'=>$_SESSION['userSession']->idBodega);
            $data = DATA::Ejecutar($sql,$param);
            if($data){
                // calculo de saldos. 
                // self::$valorSalida = floatval($data[0]['costoPromedio'] * $outCantidad);
                self::$saldoCantidad = $data[0]['saldoCantidad'] - $outCantidad;
                self::$saldoCosto = floatval($data[0]['costoPromedio'] * self::$saldoCantidad);
                if(self::$saldoCantidad < 0){
                    self::$saldoCantidad = 0;
                    self::$saldoCosto = 0;
                }
                // agrega ENTRADA histórico inventario. *** NO IMPLEMENTADO ***
                // actualiza saldos.
                $sql = 'UPDATE insumosXBodega
                    SET saldoCantidad=:saldoCantidad, saldoCosto=:saldoCosto
                    WHERE id=:idProducto and idBodega =:idBodega;';
                $param = array(':idProducto'=>$idProducto, ':idBodega'=>$_SESSION['userSession']->idBodega, ':saldoCantidad'=>self::$saldoCantidad, ':saldoCosto'=>self::$saldoCosto);
                $data = DATA::Ejecutar($sql, $param, false);
                if($data) {
                    return true;
                }                
                else throw new Exception('Error al consultar actualizar los saldos de insumo x bodega ('.$idProducto.')' , ERROR_SALIDA_INVENTARIO_INSUMOXBODEGA);
            }
            else throw new Exception('Error al consultar el codigo del insumo para actualizar inventario ('.$idProducto.')' , ERROR_SALIDA_INVENTARIO_INSUMOXBODEGA);

        }
        catch(Exception $e) {
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            // header('HTTP/1.0 400 Bad error');
            // die(json_encode(array(
            //     'code' => $e->getCode() ,
            //     'msg' => $e->getMessage()))
            // );
        }
    }

    public static function mermaAgenciaSalida($id, $outOrden, $outCantidad){
        try {
            $sql="SELECT saldoCantidad, costoPromedio 
                FROM insumosXBodega 
                WHERE id=:id and idBodega =:idBodega;";
            $param = array(':id'=>$id, ':idBodega'=>$_SESSION['userSession']->idBodega);
            $data = DATA::Ejecutar($sql,$param);
            if($data){
                // calculo de saldos. 
                // self::$valorSalida = floatval($data[0]['costoPromedio'] * $outCantidad);
                self::$saldoCantidad = $data[0]['saldoCantidad'] - $outCantidad;
                self::$saldoCosto = floatval($data[0]['costoPromedio'] * self::$saldoCantidad);
                if(self::$saldoCantidad < 0){
                    self::$saldoCantidad = 0;
                    self::$saldoCosto = 0;
                }
                // agrega ENTRADA histórico inventario. *** NO IMPLEMENTADO ***
                // actualiza saldos.
                $sql = 'UPDATE insumosXBodega
                    SET saldoCantidad=:saldoCantidad, saldoCosto=:saldoCosto
                    WHERE id=:id and idBodega =:idBodega;';
                $param = array(':id'=>$id, ':idBodega'=>$_SESSION['userSession']->idBodega, ':saldoCantidad'=>self::$saldoCantidad, ':saldoCosto'=>self::$saldoCosto);
                $data = DATA::Ejecutar($sql, $param, false);
                if($data) {
                    return true;
                }                
                else throw new Exception('Error al consultar actualizar los saldos de insumo x bodega ('.$id.')' , ERROR_SALIDA_INVENTARIO_INSUMOXBODEGA);
            }
            else throw new Exception('Error al consultar el codigo del insumo para actualizar inventario ('.$id.')' , ERROR_SALIDA_INVENTARIO_INSUMOXBODEGA);
        }
        catch(Exception $e) {
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            // header('HTTP/1.0 400 Bad error');
            // die(json_encode(array(
            //     'code' => $e->getCode() ,
            //     'msg' => $e->getMessage()))
            // );
        }
    }


}
?>