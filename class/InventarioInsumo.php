<?php 
require_once("Conexion.php");
require_once("Insumo.php");
define('ERROR_ENTRADA_INVENTARIO_INSUMO', '-750');
define('ERROR_SALIDA_INVENTARIO_INSUMO', '-751');

class InventarioInsumo{
    // public $idOrdenCompra;
    // public $idOrdensalida;
    public static $idOrden; // entrada o salida
    public static $idInsumo;
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
                FROM insumo WHERE id=:idInsumo;";
            $param = array(':idInsumo'=>$idInsumo);
            $data = DATA::Ejecutar($sql,$param);
            if($data){
                // calculo de saldos.
                self::$saldoCantidad = $data[0]['saldoCantidad'] + $inCantidad;
                self::$saldoCosto = $data[0]['saldoCosto'] + floatval($inCostoUnitario * $inCantidad);
                self::$costoPromedio = self::$saldoCosto / self::$saldoCantidad;
                // agrega ENTRADA histórico inventario.
                $sql="INSERT INTO inventarioInsumo  (id, idOrdenCompra, idInsumo, entrada, saldo, costoAdquisicion, valorEntrada, valorSaldo, costoPromedio)
                    VALUES (uuid(), :idOrdenCompra, :idInsumo, :entrada, :saldo, :costoAdquisicion, :valorEntrada, :valorSaldo, :costoPromedio);";
                $param= array(':idOrdenCompra'=>$inOrden,
                    ':idInsumo'=>$idInsumo,
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
                    $sql = 'UPDATE insumo
                        SET saldoCantidad=:saldoCantidad, saldoCosto=:saldoCosto, costoPromedio=:costoPromedio
                        WHERE id=:idInsumo;';
                    $param = array(':idInsumo'=>$idInsumo, ':saldoCantidad'=>self::$saldoCantidad, ':saldoCosto'=>self::$saldoCosto, ':costoPromedio'=>self::$costoPromedio);
                    $data = DATA::Ejecutar($sql, $param, false);
                    if($data) 
                        return true;
                    else throw new Exception('Error al consultar actualizar los saldos de insumo ('.$idInsumo.')' , ERROR_ENTRADA_INVENTARIO_INSUMO);        
                }
                else throw new Exception('Error al consultar insertar la entrada de inventario ('.$idInsumo.')' , ERROR_ENTRADA_INVENTARIO_INSUMO);
            } 
            else throw new Exception('Error al consultar el codigo del insumo para actualizar inventario ('.$idInsumo.')' , ERROR_ENTRADA_INVENTARIO_INSUMO);
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
    // Agrega la salida al histórico de inventario y actualiza los valores actuales del insumo.
    //
    public static function salida($idInsumo, $outOrden, $outCantidad){
        try {
            $sql="SELECT saldoCantidad, costoPromedio 
                FROM insumo WHERE id=:idInsumo;";
            $param = array(':idInsumo'=>$idInsumo);
            $data = DATA::Ejecutar($sql,$param);
            if($data){
                // calculo de saldos. 
                self::$valorSalida = floatval($data[0]['costoPromedio'] * $outCantidad);
                self::$saldoCantidad = $data[0]['saldoCantidad'] - $outCantidad;
                self::$saldoCosto = floatval($data[0]['costoPromedio'] * self::$saldoCantidad);
                // agrega ENTRADA histórico inventario.
                $sql="INSERT INTO inventarioInsumo  (id, idOrdenSalida, idInsumo, salida, saldo, valorSalida, valorSaldo)
                    VALUES (uuid(), :idOrdenSalida, :idInsumo, :salida, :saldo, :valorSalida, :valorSaldo );";
                $param= array(':idOrdenSalida'=>$outOrden, 
                    ':idInsumo'=>$idInsumo,
                    ':salida'=>$outCantidad,
                    ':saldo'=>self::$saldoCantidad, 
                    ':valorSalida'=> self::$valorSalida,
                    ':valorSaldo'=>self::$saldoCosto
                );
                $data = DATA::Ejecutar($sql, $param, false);
                if($data){
                    // actualiza saldos.
                    $sql = 'UPDATE insumo
                        SET saldoCantidad=:saldoCantidad, saldoCosto=:saldoCosto
                        WHERE id=:idInsumo;';
                    $param = array(':idInsumo'=>$idInsumo, ':saldoCantidad'=>self::$saldoCantidad, ':saldoCosto'=>self::$saldoCosto);
                    $data = DATA::Ejecutar($sql, $param, false);
                    if($data) 
                        return true;
                    else throw new Exception('Error al consultar actualizar los saldos de insumo ('.$idInsumo.')' , ERROR_SALIDA_INVENTARIO_INSUMO);        
                }
                else throw new Exception('Error al consultar insertar la entrada de inventario ('.$idInsumo.')' , ERROR_SALIDA_INVENTARIO_INSUMO);
            } 
            else throw new Exception('Error al consultar el codigo del insumo para actualizar inventario ('.$idInsumo.')' , ERROR_SALIDA_INVENTARIO_INSUMO);
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