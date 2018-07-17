<?php
if(isset($_POST["action"])){
    $opt= $_POST["action"];
    unset($_POST['action']);
    // Classes
    require_once("Conexion.php");
    switch($opt){
        case "Read":
            echo json_encode(Read());
            break;
        case "Write":
            echo json_encode(Write());
            break;
    }
}
    
    function Read(){
        try {
            if(isset($_POST['local'])){
                $local= $_POST["local"];
                //
                // $sql='SELECT d.id as id, f.consecutivo , d.tamano , p1.nombre as sabor1, 
                //         p2.nombre as sabor2, p3.nombre as topping, f.fechaCreacion
                //     FROM detalleOrden d inner join factura f on f.id=d.idfactura
                //         -- left join insumosXBodega ib on ib.id= d.idSabor1 
                //         left join producto p1 on p1.id=d.idsabor1
                //         left join producto p2 on p2.id=d.idsabor2
                //         left join producto p3 on p3.id=d.idTopping
                //     WHERE estado= 0 AND f.local=:local';
                $sql= 'SELECT d.id, f.consecutivo, d.tamano, p1.nombre as sabor1, 
                        p2.nombre as sabor2, p3.nombre as topping, f.fechaCreacion
                    FROM tropical.detalleOrden d inner join factura f on f.id=d.idFactura
                        left join insumosXBodega i on i.id= d.idSabor1 inner join producto p1 on p1.id=i.idProducto
                        left join insumosXBodega i2 on i2.id= d.idSabor2 inner join producto p2 on p2.id=i2.idProducto
                        left join insumosXBodega i3 on i3.id= d.idTopping inner join producto p3 on p3.id=i3.idProducto
                        WHERE estado= 0 AND f.local=:local';
                $param= array(':local'=>$local);
                $data= DATA::Ejecutar($sql, $param);
                if(count($data)){
                    $items= [];
                    foreach ($data as $key => $value){
                        $item= [];
                        $item = array(
                            "id" =>$value['id'], // consec. de factura.
                            "consecutivo" =>$value['consecutivo'], // consec. de factura.
                            "tamano" => $value['tamano']==0?'M':'L',                             
                            "sabor1" =>  $value['sabor1'],
                            "sabor2" =>  $value['sabor2'],
                            "topping" => $value['topping'],
                            "fechaCreacion" => $value['fechaCreacion']
                        );
                        array_push($items, $item);
                    }
                    return $items;
                }
                else return '';
            }
            else return '';
        }     
        catch(Exception $e) {
            header('HTTP/1.0 405 Read error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar la lista'))
            );
        }
    }        

    function Write(){
        try {
            if(isset($_POST['id'])){
                $id= $_POST["id"];
                //
                $sql='UPDATE detalleOrden
                    SET estado=1
                    WHERE id=:id';
                $param= array(':id'=>$id);
                $data= DATA::Ejecutar($sql, $param);
                return true;
            }
            else return '';
        }     
        catch(Exception $e) {
            header('HTTP/1.0 406 Write error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al actualizar la orden'))
            );
        }
    }
?>