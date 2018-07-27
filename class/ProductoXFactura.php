<?php
    require_once("Conexion.php");
    
class ProductoXFactura{
   
    public static $id=null;

    public static function Read($id){
        try{
            $sql="SELECT detalle from productosXFactura
            where idFactura = :idDistribucion";
            $param= array(':idDistribucion'=>$id);
            $data = DATA::Ejecutar($sql,$param);            
            $lista = [];
            foreach ($data as $key => $value){
                $producto = new ProductoXFactura();
                $producto->detalle = $value['detalle']; //id del producto.       
                array_push ($lista, $producto);
            }
            return $lista;
        }
        catch(Exception $e) {
            return false;
        }
    }

    public static function Create($obj){
        try {
            $created = true;
            $cantidad = 1;
            $idUnidadMedida = 33;
            $montoTotal = 0;
            $subTotal = 0;
            $montoTotalLinea = 0;


            foreach ($obj as $item) {       
                
                $subTotal = $cantidad * $item->precioUnitario;
                $montoTotalLinea = $subTotal;

                $sql="INSERT INTO productosXFactura (id, idFactura, idPrecio, numeroLinea, cantidad, idUnidadMedida, detalle, precioUnitario, montoTotal, subTotal, montoTotalLinea)
                VALUES (uuid(), :idFactura, :idPrecio, :numeroLinea, :cantidad, :idUnidadMedida, :detalle, :precioUnitario, :montoTotal, :subTotal, :montoTotalLinea)";              

                $param= array(':idFactura'=>self::$id,':idPrecio'=>$item->idPrecio, ':numeroLinea'=>$item->numeroLinea, ':cantidad'=>$cantidad, ':idUnidadMedida'=>$idUnidadMedida,':detalle'=>$item->detalle, ':precioUnitario'=>$item->precioUnitario, ':montoTotal'=>$montoTotal, ':subTotal'=>$subTotal, ':montoTotalLinea'=>$montoTotalLinea);
                $data = DATA::Ejecutar($sql,$param, false);

            }
            return $created;
        }     
        catch(Exception $e) {
            return false;
        }
    }
}
?>    
   

