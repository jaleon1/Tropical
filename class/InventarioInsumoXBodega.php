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
    public static function entrada($idProducto, $idBodega, $inOrden, $inCantidad, $inCostoUnitario){
        try {
            $sql="SELECT id, saldoCantidad, saldoCosto 
                FROM insumosXBodega 
                WHERE idProducto=:idProducto AND idBodega=:idBodega;";
            $param = array(
                ':idProducto'=>$idProducto,
                ':idBodega'=>$idBodega
            );
            $data = DATA::Ejecutar($sql,$param);
            $oldSaldoCantidad= 0;
            $oldSaldoCosto= 0;
            require_once("UUID.php");
            $idInsumo= UUID::v4();
            if($data){ // el producto ya está registrado.
                // cantidades en stock.
                $oldSaldoCantidad= $data[0]['saldoCantidad'];
                $oldSaldoCosto= $data[0]['saldoCosto'];
                $idInsumo= $data[0]['id'];
            }
            else { 
                // el producto aun no se ha registrado en la bodega.
                $sql="INSERT INTO insumosXBodega 
                    VALUES (:id, :idProducto, :idBodega, 0, 0, 0); ";
                $param= array(
                    ':id'=>$idInsumo,
                    ':idProducto'=>$idProducto,
                    ':idBodega'=>$idBodega
                );
                $data = DATA::Ejecutar($sql,$param);
            }
            // porciones.
            $sql="SELECT esVenta
                FROM producto
                WHERE id=:idProducto;";
            $param = array(':idProducto'=>$idProducto); // el insumo de la bodega es un producto en la Central.
            $data = DATA::Ejecutar($sql,$param);
            $porcion=0;
            if ($data[0]['esVenta']==0){        // artículo.
                $porcion= 1;
            }
            else if ($data[0]['esVenta']==1){   // botella de sabor.
                $porcion= 20;
            }
            else if ($data[0]['esVenta']==2){   // topping.
                $porcion= 40;
            }
            // calculo de saldos.
            self::$saldoCantidad = $oldSaldoCantidad + ($inCantidad*$porcion);
            self::$saldoCosto = $oldSaldoCosto + floatval($inCostoUnitario * $inCantidad);
            self::$costoPromedio = self::$saldoCosto / self::$saldoCantidad;
            // agrega ENTRADA histórico inventario.
            $sql="INSERT INTO inventarioBodega  (id, idBodega, idOrdenCompra, idInsumo, entrada, saldo, costoAdquisicion, valorEntrada, valorSaldo, costoPromedio)
                VALUES (uuid(), :idBodega, :idOrdenCompra, :idInsumo, :entrada, :saldo, :costoAdquisicion, :valorEntrada, :valorSaldo, :costoPromedio);";
            $param= array(
                ':idBodega'=>$idBodega,
                ':idOrdenCompra'=>$inOrden,
                ':idInsumo'=>$idInsumo,
                ':entrada'=>($inCantidad*$porcion),
                ':saldo'=>self::$saldoCantidad, 
                ':costoAdquisicion'=>$inCostoUnitario,
                ':valorEntrada'=>floatval($inCostoUnitario * $inCantidad),
                ':valorSaldo'=>self::$saldoCosto,
                ':costoPromedio'=>self::$costoPromedio
            );
            $data = DATA::Ejecutar($sql, $param, false);
            if($data){
                // actualiza saldos.
                $sql = 'UPDATE insumosXBodega
                    SET saldoCantidad=:saldoCantidad, saldoCosto=:saldoCosto, costoPromedio=:costoPromedio
                    WHERE id=:idInsumo;';
                $param = array(':idInsumo'=>$idInsumo, ':saldoCantidad'=>self::$saldoCantidad, ':saldoCosto'=>self::$saldoCosto, ':costoPromedio'=>self::$costoPromedio);
                $data = DATA::Ejecutar($sql, $param, false);
                if($data) 
                    return true;
                else throw new Exception('Error al consultar actualizar los saldos de insumo ('.$idInsumo.')' , ERROR_ENTRADA_INVENTARIO_BODEGA);        
            }
            else throw new Exception('Error al consultar insertar la entrada de inventario ('.$idInsumo.')' , ERROR_ENTRADA_INVENTARIO_BODEGA);
            
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
    //  actualiza los valores actuales del insumo.
    //
    public static function salida($idInsumo, $idBodega, $outOrden, $outCantidad){
        try {
            $sql="SELECT saldoCantidad, costoPromedio 
                FROM insumosXBodega 
                WHERE id=:idInsumo and idBodega =:idBodega;";
            $param = array(':idInsumo'=>$idInsumo, ':idBodega'=>$idBodega);
            $data = DATA::Ejecutar($sql,$param);
            if($data){
                // calculo de saldos. 
                self::$valorSalida = floatval($data[0]['costoPromedio'] * $outCantidad);               
                self::$saldoCantidad = $data[0]['saldoCantidad'] - $outCantidad;
                self::$saldoCosto = floatval($data[0]['costoPromedio'] * self::$saldoCantidad);
                if(self::$saldoCantidad < 0){
                    self::$saldoCantidad = 0;
                    self::$saldoCosto = 0;
                }
                // agrega SALIDA histórico inventario.
                $sql="INSERT INTO inventarioBodega  (id, idBodega, idOrdenSalida, idInsumo, salida, saldo, valorSalida, valorSaldo)
                    VALUES (uuid(), :idBodega, :idOrdenSalida, :idInsumo, :salida, :saldo, :valorSalida, :valorSaldo );";
                $param= array(
                    ':idBodega'=>$idBodega,
                    ':idOrdenSalida'=>$outOrden,
                    ':idInsumo'=>$idInsumo,
                    ':salida'=>$outCantidad,
                    ':saldo'=>self::$saldoCantidad, 
                    ':valorSalida'=> self::$valorSalida,
                    ':valorSaldo'=>self::$saldoCosto
                );
                $data = DATA::Ejecutar($sql, $param, false);
                // actualiza saldos.
                $sql = 'UPDATE insumosXBodega
                    SET saldoCantidad=:saldoCantidad, saldoCosto=:saldoCosto
                    WHERE id=:idInsumo and idBodega =:idBodega;';
                $param = array(':idInsumo'=>$idInsumo, ':idBodega'=>$idBodega, ':saldoCantidad'=>self::$saldoCantidad, ':saldoCosto'=>self::$saldoCosto);
                $data = DATA::Ejecutar($sql, $param, false);
                if($data) {
                    return true;
                }                
                else throw new Exception('Error al consultar actualizar los saldos de insumo x bodega ('.$idInsumo.')' , ERROR_SALIDA_INVENTARIO_INSUMOXBODEGA);
            }
            else throw new Exception('Error al consultar el codigo del insumo para actualizar inventario ('.$idInsumo.')' , ERROR_SALIDA_INVENTARIO_INSUMOXBODEGA);

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