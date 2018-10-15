<?php
if(isset($_POST["action"])){
    $opt= $_POST["action"];
    unset($_POST['action']);
    // Classes
    require_once("Conexion.php");
    require_once("Insumo.php");
    require_once("Producto.php");
    require_once("InventarioInsumo.php");
    require_once("InventarioProducto.php");
    // Session
    if (!isset($_SESSION))
        session_start();
    // Instance
    $merma= new Merma();
    switch($opt){
        case "ReadAll":
            echo json_encode($merma->ReadAll());
            break;
        case "Create":
            echo json_encode($merma->Create());
            break;
    }
}

class Merma{
    public $id=null;
    public $idProducto='';
    public $idInsumo='';
    public $descripcion='';
    public $cantidad=0;
    public $fecha;

    function __construct(){
        // identificador único
        if(isset($_POST["id"])){
            $this->id= $_POST["id"];
        }
        if(isset($_POST["obj"])){
            $obj= json_decode($_POST["obj"],true);
            require_once("UUID.php");
            $this->id= $obj["id"] ?? UUID::v4();
            // merma
            if(isset($obj["listaInsumo"] )){
                $this->listaInsumo= [];
                foreach ($obj["listaInsumo"] as $itemlist) {
                    $item= new Insumo();
                    $item->id = $itemlist['idInsumo'];
                    $item->cantidad = $itemlist['cantidad'];
                    $item->descripcion= $itemlist['descripcion'];
                    array_push ($this->listaInsumo, $item);
                }
            }
            if(isset($obj["listaProducto"] )){
                $this->listaProducto= [];
                foreach ($obj["listaProducto"] as $itemlist) {
                    $item= new Producto();
                    $item->id = $itemlist['idProducto'];
                    $item->cantidad = $itemlist['cantidad'];
                    $item->descripcion= $itemlist['descripcion'];
                    array_push ($this->listaProducto, $item);
                }
            }
        }
    }

    function ReadAll(){
        try {
            $sql='SELECT m.id, i.codigo, m.consecutivo, i.nombre, i.descripcion, m.cantidad, m.descripcion, m.fecha
                FROM mermaInsumo m inner join insumo i on i.id = m.idInsumo
                UNION
                SELECT m.id, p.codigo, m.consecutivo, p.nombre, p.descripcion, m.cantidad, m.descripcion, m.fecha
                FROM mermaProducto m inner join producto p on p.id = m.idProducto';
            $data= DATA::Ejecutar($sql);
            return $data;
        }     
        catch(Exception $e) {
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar la lista'))
            );
        }
    }

    function Create(){
        try {
            $created=true;            
            // insumos
            foreach ($this->listaInsumo as $item) {
                // historico merma
                $sql="INSERT INTO mermaInsumo (id, idInsumo, cantidad, descripcion)
                    VALUES (:id, :idInsumo, :cantidad, :descripcion)";
                $param= array(':id'=> $this->id, ':idInsumo'=> $item->id, ':cantidad'=> $item->cantidad, ':descripcion'=> $item->descripcion);
                $data = DATA::Ejecutar($sql,$param,false);
                if(!$data)
                    $created= false;
                // actualiza item
                InventarioInsumo::salida( $item->id, $this->id, $item->cantidad);
            }
            // productos
            foreach ($this->listaProducto as $item) {
                // historico merma
                $sql="INSERT INTO mermaProducto (id, idProducto, cantidad, descripcion)
                    VALUES (:id, :idProducto, :cantidad, :descripcion)";
                $param= array(':id'=> $this->id, ':idProducto'=> $item->id, ':cantidad'=> $item->cantidad, ':descripcion'=> $item->descripcion);
                $data = DATA::Ejecutar($sql,$param,false);
                if(!$data)
                    $created= false;
                // actualiza item y registra inventario.                
                InventarioProducto::salida($item->id, $this->id, $item->cantidad);
            }
            //
            if($created)
                return true;
            else throw new Exception('Error al restar MERMA, debe realizar el procedimiento manualmente.', 666);
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }
    //Merma (SALIDA)
    function CreateInventarioInsumo($obj){
        try {
            $created = true;
            require_once("Insumo.php");
            foreach ($obj as $item) {          
                
                $sql="SELECT saldoCantidad, saldoCosto, costoPromedio FROM insumo WHERE id=:idInsumo;";
                $param= array(':idInsumo'=>$item->id);
                $valor=DATA::Ejecutar($sql,$param);              
                
                $sql="select id,fecha,consecutivo from mermaInsumo order by fecha desc limit 1;";
                $data=DATA::Ejecutar($sql);

                $valorSalida = $item->cantidad*$valor[0]['costoPromedio'];

                $sql="INSERT INTO inventarioInsumo   (id, idMerma, idInsumo, salida, saldo, valorSalida, valorSaldo, costoPromedio, fecha, consecutivo)
                    VALUES (uuid(), :idMerma, :idInsumo, :salida, :saldo, :valorSalida, :valorSaldo, :costoPromedio, :fecha, :consecutivo)";
                $param= array(':idMerma'=>$data[0]['id'],
                    ':idInsumo'=>$item->id,
                    ':salida'=>$item->cantidad,
                    ':saldo'=>$valor[0]['saldoCantidad'], 
                    ':valorSalida'=>(string)$valorSalida,
                    ':valorSaldo'=>$valor[0]['saldoCosto'],
                    ':costoPromedio'=>$valor[0]['costoPromedio'],
                    ':fecha'=>$data[0]['fecha'],
                    ':consecutivo'=>$data['consecutivo']
                );
                DATA::Ejecutar($sql,$param,false);                
            }
            return $created;
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            return false;
        }
    }
}


?>