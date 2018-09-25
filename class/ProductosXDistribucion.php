<?php 
require_once("Conexion.php");
require_once("InventarioProducto.php");

class ProductosXDistribucion{
    public $id;
    public $idDistribucion;
    public $idProducto;
    public $cantidad;
    public $valor;
    //
    public static function Read($id){
        try{
            $sql="SELECT pd.idProducto as id, pd.cantidad, pd.valor,
                    p.codigo, p.nombre, p.descripcion
                FROM productosXDistribucion pd INNER JOIN producto p on p.id = pd.idProducto	
                WHERE pd.idDistribucion= :idDistribucion";
            $param= array(':idDistribucion'=>$id);
            $data = DATA::Ejecutar($sql,$param);            
            $lista = [];
            foreach ($data as $key => $value){
                $producto = new ProductosXDistribucion();
                $producto->id = $value['id']; //id del producto.
                //$producto->idProducto = $value['idProducto'];
                $producto->cantidad = $value['cantidad'];
                $producto->precioVenta = $value['valor'];
                //
                $producto->codigo = $value['codigo'];
                $producto->nombre = $value['nombre'];
                $producto->descripcion = $value['descripcion'];          
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
            require_once("Producto.php");
            foreach ($obj as $item) {             
                $sql="INSERT INTO productosXDistribucion   (id, idDistribucion, idProducto, cantidad, valor)
                    VALUES (uuid(), :idDistribucion, :idProducto, :cantidad, :valor)";
                $param= array(':idDistribucion'=>$item->idDistribucion, 
                    ':idProducto'=>$item->idProducto,
                    ':cantidad'=>$item->cantidad, 
                    ':valor'=>$item->valor
                );
                $data = DATA::Ejecutar($sql,$param,false);                
                if($data){
                    $sql="SELECT orden 
                        FROM distribucion   
                        WHERE id=:idDistribucion";
                    $param= array(':idDistribucion'=>$item->idDistribucion);
                    $data = DATA::Ejecutar($sql,$param);
                    // Actualiza los saldos y calcula promedio
                    InventarioProducto::salida($item->idProducto, $data[0]['orden'] ,$item->cantidad);
                }
                else $created= false;
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
            $updated= self::Delete($obj[0]->cantidad);
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
                WHERE cantidad= :cantidad';
            $param= array(':cantidad'=> $_idproductotemporal);
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