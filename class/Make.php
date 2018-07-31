<?php
if(isset($_POST["action"])){
    $opt= $_POST["action"];
    unset($_POST['action']);    
    // Classes
    require_once("Conexion.php");
    require_once("Usuario.php");
    if (!isset($_SESSION))
        session_start();
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
            $sql= 'SELECT d.id, f.consecutivo, d.tamano, p1.nombre as sabor1, 
                    p2.nombre as sabor2, p3.nombre as topping, f.fechaCreacion
                FROM tropical.detalleOrden d inner join factura f on f.id=d.idFactura
                    left join insumosXBodega i on i.id= d.idSabor1 inner join producto p1 on p1.id=i.idProducto
                    left join insumosXBodega i2 on i2.id= d.idSabor2 inner join producto p2 on p2.id=i2.idProducto
                    left join insumosXBodega i3 on i3.id= d.idTopping left join producto p3 on p3.id=i3.idProducto
                    WHERE estado= 0 AND f.idBodega=:idBodega
                    ORDER BY f.fechaCreacion asc';
            $param= array(':idBodega'=>$_SESSION['userSession']->idBodega);
            $data= DATA::Ejecutar($sql, $param);
            if(count($data)){
                $items= [];
                foreach ($data as $key => $value){
                    $item= [];
                    $item = array(
                        "id" =>$value['id'], // consec. de factura.
                        "consecutivo" =>$value['consecutivo'], // consec. de factura.
                        "tamano" => $value['tamano']==0?'8':'12',                             
                        "sabor1" =>  $value['sabor1'],
                        "sabor2" =>  $value['sabor2'],
                        "topping" => $value['topping']==null?'Sin Topping':'Topping: ' . $value['topping'],
                        "fechaCreacion" => $value['fechaCreacion']
                    );
                    array_push($items, $item);
                }
                return $items;
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