<?php 
require_once("Conexion.php");
//require_once("InsumosXBodega.php");
define('ERROR_ENTRADA_INVENTARIO_BODEGA', '-798');
define('ERROR_SALIDA_INVENTARIO_BODEGA', '-799');

class inventarioBodega{
    // public $idOrdenCompra;
    // public $idOrdenSalida;
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
    public static function entrada($idProducto, $idBodega, $inOrden, $inCantidad, $inCostoUnitario){
        try {
            $sql="SELECT id, saldoCantidad, saldoCosto 
                FROM insumosXBodega 
                WHERE idproducto=:idProducto AND idBodega= :idBodega;";
            $param = array(
                ':idproducto'=>$idProducto,
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
                    VALUES (:id, :idproducto, :idBodega, 0, 0, 0); ";
                $param= array(
                    ':id'=>$idInsumo,
                    ':idproducto'=>$idProducto,
                    ':idBodega'=>$idBodega
                );
                $data = DATA::Ejecutar($sql,$param);
            }
            // porciones.
            $sql="SELECT esVenta
                INTO esVenta
                FROM producto
                WHERE p.id= idproducto;";
            $param = array(':idproducto'=>$idProducto); // el insumo de la bodega es un producto en la Central.
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
            $sql="INSERT INTO inventarioBodega  (id, idOrdenCompra, idInsumo, entrada, saldo, costoAdquisicion, valorEntrada, valorSaldo, costoPromedio)
                VALUES (uuid(), :idOrdenCompra, :idInsumo, :entrada, :saldo, :costoAdquisicion, :valorEntrada, :valorSaldo, :costoPromedio);";
            $param= array(
                ':idOrdenCompra'=>$inOrden,
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
    // Agrega la salida al histórico de inventario y actualiza los valores actuales del insumo.
    //
    public static function salida($idProducto, $idBodega, $outOrden, $outCantidad){
        try {
            $sql="SELECT saldoCantidad, costoPromedio 
                FROM insumosXBodega 
                WHERE id=:idProducto and idBodega =:idBodega;";
            $param = array(':idProducto'=>$idProducto, ':idBodega'=>$idBodega);
            $data = DATA::Ejecutar($sql,$param);
            if($data){
                $oldSaldoCantidad= $data[0]['saldoCantidad'];
                $oldSaldoCosto= $data[0]['saldoCosto'];
                $idInsumo= $data[0]['id'];
                // porcion.

                // calculo de saldos. 
                self::$valorSalida = floatval($data[0]['costoPromedio'] * $outCantidad);
                self::$saldoCantidad = $oldSaldoCantidad - $outCantidad;
                self::$saldoCosto = floatval($data[0]['costoPromedio'] * self::$saldoCantidad);
                // agrega ENTRADA histórico inventario.
                $sql="INSERT INTO inventarioBodega  (id, idOrdenSalida, idInsumo, salida, saldo, valorSalida, valorSaldo)
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
                    $sql = 'UPDATE insumosXBodega
                        SET saldoCantidad=:saldoCantidad, saldoCosto=:saldoCosto
                        WHERE id=:idInsumo;';
                    $param = array(':idInsumo'=>$idInsumo, ':saldoCantidad'=>self::$saldoCantidad, ':saldoCosto'=>self::$saldoCosto);
                    $data = DATA::Ejecutar($sql, $param, false);
                    if($data) 
                        return true;
                    else throw new Exception('Error al consultar actualizar los saldos de insumo ('.$idInsumo.')' , ERROR_SALIDA_INVENTARIO_BODEGA);        
                }
                else throw new Exception('Error al consultar insertar la entrada de inventario ('.$idInsumo.')' , ERROR_SALIDA_INVENTARIO_BODEGA);
            } 
            else throw new Exception('Error al consultar el codigo del insumo para actualizar inventario ('.$idInsumo.')' , ERROR_SALIDA_INVENTARIO_BODEGA);
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