<?php 
require_once("Conexion.php");
require_once("InventarioProducto.php");

class ProductosXDistribucion{
    public $id;
    public $idDistribucion;
    public $idProducto;
    public $cantidad;    
    //
    public static function Read($id){
        try{
            $sql="SELECT pd.id, pd.idDistribucion, pd.idProducto, numeroLinea, idTipoCodigo, codigo, cantidad, 
                    idUnidadMedida, unidadMedidaComercial, detalle, precioUnitario, montoTotal, montoDescuento, naturalezaDescuento, 
                    subTotal, codigoImpuesto, tarifaImpuesto, montoImpuesto, idExoneracionImpuesto, montoTotalLinea
                FROM productosXDistribucion pd
                WHERE pd.idDistribucion= :idDistribucion";
            $param= array(':idDistribucion'=>$id);
            $data = DATA::Ejecutar($sql,$param);            
            $detalleFactura = [];
            //$i=1;
            foreach ($data as $key => $value){
                $producto = new ProductosXDistribucion();
                $producto->id = $value['id'];
                $producto->idDistribucion = $value['idDistribucion'];
                $producto->idProducto = $value['idProducto']; //id del producto.
                //                
                $producto->numeroLinea = $value['numeroLinea'];
                $producto->idTipoCodigo = $value['idTipoCodigo'];
                $producto->codigo = $value['codigo'];
                $producto->cantidad = $value['cantidad'];
                $producto->idUnidadMedida = $value['idUnidadMedida'];
                $producto->unidadMedidaComercial = $value['unidadMedidaComercial'];
                $producto->detalle = $value['detalle'];
                $producto->precioUnitario = $value['precioUnitario'];
                $producto->montoTotal = $value['montoTotal'];
                $producto->montoDescuento = $value['montoDescuento'];
                $producto->naturalezaDescuento = $value['naturalezaDescuento'];
                $producto->subTotal = $value['subTotal'];
                $producto->codigoImpuesto = $value['codigoImpuesto'];
                $producto->tarifaImpuesto = $value['tarifaImpuesto'];
                $producto->montoImpuesto = $value['montoImpuesto'];
                $producto->idExoneracionImpuesto = $value['idExoneracionImpuesto'];
                $producto->montoTotalLinea = $value['montoTotalLinea'];
                array_push ($detalleFactura, $producto);
                //$i++;
            }
            return $detalleFactura;
        }
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            return false;
        }
    }

    public static function Create($obj){
        try {
            $created = true;
            require_once("Producto.php");
            foreach ($obj as $item) {             
                $sql="INSERT INTO productosXDistribucion   (id, idDistribucion, idProducto, numeroLinea, idTipoCodigo, codigo, cantidad, idUnidadMedida, detalle, precioUnitario, montoTotal, montoDescuento, naturalezaDescuento,
                subTotal, codigoImpuesto, tarifaImpuesto, montoImpuesto, idExoneracionImpuesto, montoTotalLinea)
            VALUES (uuid(), :idDistribucion, :idProducto, :numeroLinea, :idTipoCodigo, :codigo, :cantidad, :idUnidadMedida, :detalle, :precioUnitario, :montoTotal, :montoDescuento, :naturalezaDescuento,                
                :subTotal, :codigoImpuesto, :tarifaImpuesto, :montoImpuesto, :idExoneracionImpuesto, :montoTotalLinea)";
                //
                $param= array(
                    ':idDistribucion'=>$item->idDistribucion,
                    ':idProducto'=>$item->idProducto,
                    ':numeroLinea'=>$item->numeroLinea,
                    ':idTipoCodigo'=> $item->idTipoCodigo,
                    ':codigo'=> $item->codigo,                    
                    ':cantidad'=>$item->cantidad,
                    ':idUnidadMedida'=>$item->idUnidadMedida,
                    ':detalle'=>$item->detalle,
                    ':precioUnitario'=>$item->precioUnitario,
                    ':montoTotal'=>$item->montoTotal,
                    ':montoDescuento'=>$item->montoDescuento,
                    ':naturalezaDescuento'=>$item->naturalezaDescuento,                    
                    ':subTotal'=>$item->subTotal,                    
                    ':codigoImpuesto'=>$item->codigoImpuesto,
                    ':tarifaImpuesto'=>$item->tarifaImpuesto,
                    ':montoImpuesto'=>$item->montoImpuesto,
                    ':idExoneracionImpuesto'=>$item->idExoneracionImpuesto,
                    ':montoTotalLinea'=>$item->montoTotalLinea
                );
                $data = DATA::Ejecutar($sql,$param,false);                
                if($data){                    
                    // Actualiza los saldos y calcula promedio
                    InventarioProducto::salida($item->idProducto, $item->idDistribucion ,$item->cantidad);
                }
                else $created= false;
            }
            return $created;
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            return false;
        }
    }

    public static function Update($obj){
        try {
            $updated = true;
            // elimina todos los objetos relacionados
            $updated= self::Delete($obj[0]->cantidad);
            // crea los nuevos objetos
            $updated= self::Create($obj);
            return $updated;
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            return false;
        }
    }

    public static function Delete($_idproductotemporal){
        try {                 
            $sql='DELETE FROM insumosXOrdenCompra  
                WHERE cantidad= :cantidad';
            $param= array(':cantidad'=> $_idproductotemporal);
            $data= DATA::Ejecutar($sql, $param, false);
            if($data)
                return true;
            else false;
        }
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            return false;
        }
    }
}
?>