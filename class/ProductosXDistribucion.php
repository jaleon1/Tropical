<?php 
require_once("Conexion.php");

class ProductosXDistribucion{
    public $id;
    public $iddistribucion;
    public $idproducto;
    public $cantidad;
    public $valor;
    //
    public static function Read($id){
        try{
            $sql="SELECT pd.id, pd.idproducto, pd.cantidad, pd.valor,
                    p.codigo, p.nombre, p.descripcion
                FROM productosxdistribucion pd INNER JOIN producto p on p.id = pd.idproducto	
                WHERE pd.iddistribucion= :iddistribucion";
            $param= array(':iddistribucion'=>$id);
            $data = DATA::Ejecutar($sql,$param);            
            $lista = [];
            foreach ($data as $key => $value){
                $producto = new ProductosXDistribucion();
                $producto->id = $value['id'];
                $producto->idproducto = $value['idproducto'];
                $producto->cantidad = $value['cantidad'];
                $producto->precioventa = $value['valor'];
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
                $sql="INSERT INTO productosxdistribucion   (id, iddistribucion, idproducto, cantidad, valor)
                    VALUES (uuid(), :iddistribucion, :idproducto, :cantidad, :valor)";
                $param= array(':iddistribucion'=>$item->iddistribucion, 
                    ':idproducto'=>$item->idproducto,
                    ':cantidad'=>$item->cantidad, 
                    ':valor'=>$item->valor
                );
                $data = DATA::Ejecutar($sql,$param,false);                
                if($data){
                    // Actualiza los saldos y calcula promedio
                    Producto::UpdateSaldoPromedioSalida($item->idproducto, $item->cantidad);
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
            $sql='DELETE FROM insumosxordencompra  
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