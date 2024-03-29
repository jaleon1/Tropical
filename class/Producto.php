<?php
if(isset($_POST["action"])){
    $opt= $_POST["action"];
    unset($_POST['action']);
    // Classes
    require_once("Conexion.php");
    require_once("Usuario.php");
    // Session
    if (!isset($_SESSION))
        session_start();
    // Instance
    $producto= new Producto();
    switch($opt){
        case "ReadAll":
            echo json_encode($producto->ReadAll());
            break;
        case "Read":
            echo json_encode($producto->Read());
            break;
        case "ReadAllProductoVenta":
            echo json_encode($producto->ReadAllProductoVenta());
            break;
        case "ReadAllPrdVenta":
            echo json_encode($producto->ReadAllPrdVenta());
            break;
        case "ReadArticulo":
            echo json_encode($producto->ReadArticulo());
            break;
        case "ReadArticuloByCode":
            echo json_encode($producto->ReadArticuloByCode());
            break;
        case "Create":
            $producto->Create();
            break;
        case "Update":
            $producto->Update();
            break;
        case "UpdateCantidad":
            $producto->UpdateCantidad();
            break;
        case "Delete":
            echo json_encode($producto->Delete());
            break;   
        case "ReadByCode":
            echo json_encode($producto->ReadByCode());
            break;
        case "ActualizaPrecios":
            if(isset($_POST["obj"])){
                $obj= json_decode($_POST["obj"],true);
                foreach ($obj["lista"] as $itemlist) {
                    $item= new Producto();
                    $item->id= $itemlist['id'];
                    $item->precioVenta= $itemlist['precioVenta'];
                    array_push ($producto->lista, $item);
                }
                $producto->ActualizaPrecios();
            }
            break;
        case "ReadAllInventario":
            echo json_encode($producto->ReadAllInventario());
            break;
        case "ReadAllbyRange":
            echo json_encode($producto->ReadAllbyRange());
            break;
    }
}

class Producto{
    public $id=null;
    public $codigo='';
    public $nombre='';
    public $txtColor='';
    public $bgColor='';
    public $nombreAbreviado='';
    public $descripcion='';
    public $saldoCantidad='';
    public $saldoCosto='';
    public $costoPromedio='';
    public $precioVenta='';
    public $esVenta=0; // tipo de producto.
    public $lista= [];
    public $fechaInicial='';
    public $fechaFinal='';

    function __construct(){
        // identificador único
        if(isset($_POST["id"])){
            $this->id= $_POST["id"];
        }
        if(isset($_POST["obj"])){
            $obj= json_decode($_POST["obj"],true);
            $this->id= $obj["id"] ?? null;
            $this->codigo= $obj["codigo"] ?? '';
            $this->nombre= $obj["nombre"] ?? '';
            $this->txtColor= $obj["txtColor"] ?? '';
            $this->bgColor= $obj["bgColor"] ?? '';
            $this->nombreAbreviado= $obj["nombreAbreviado"] ?? '';
            $this->descripcion= $obj["descripcion"] ?? '';
            $this->saldoCantidad= $obj["saldoCantidad"] ?? '';
            $this->saldoCosto= $obj["saldoCosto"] ?? '';
            $this->costoPromedio= $obj["costoPromedio"] ?? '';
            $this->precioVenta= $obj["precioVenta"] ?? '';
            $this->esVenta= $obj["tipoProducto"] ?? 0;
            $this->fechaInicial= $obj["fechaInicial"] ?? '';
            $this->fechaFinal= $obj["fechaFinal"] ?? '';
        }
    }

    function ReadAll(){
        try {
            $sql='SELECT id, codigo, nombre, txtColor, bgColor, nombreAbreviado, descripcion, saldoCantidad, saldoCosto, costoPromedio, precioVenta, esVenta
                FROM     producto       
                ORDER BY codigo asc';
            $data= DATA::Ejecutar($sql);
            return $data;
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar la lista'))
            );
        }
    }

    function ReadAllProductoVenta(){
        try {
            $sql='SELECT ib.id, p.codigo, p.nombre, p.txtColor, p.bgColor, p.nombreAbreviado, p.descripcion, ib.saldoCantidad, p.esVenta
            FROM insumosXBodega as ib
            INNER JOIN  producto as p on p.id = ib.idProducto
            WHERE (esVenta=1 or esVenta=2)
            and ib.idBodega = :idBodega
            ORDER BY p.nombre';
            $param= array(':idBodega'=>$_SESSION["userSession"]->idBodega);
            $data= DATA::Ejecutar($sql,$param);
            return $data;
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar la lista'))
            );
        }
    }
    // Si hago el filtro por tipo en el javascript ya no necesito esta funcion
    function ReadAllPrdVenta(){
        try {
            $sql='SELECT id, codigo, nombre, txtColor, bgColor, nombreAbreviado, descripcion, saldoCantidad, saldoCosto, costoPromedio, precioVenta, esVenta
                FROM     producto       
                WHERE esVenta=1 or esVenta=2
                ORDER BY codigo asc';
            $data= DATA::Ejecutar($sql);
            return $data;
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar la lista'))
            );
        }
    }

    function Read(){
        try {
            $sql='SELECT id, codigo, nombre, txtColor, bgColor, nombreAbreviado, descripcion, saldoCantidad, saldoCosto, costoPromedio, precioVenta, esVenta
                FROM producto  
                where id=:id';
            $param= array(':id'=>$this->id);
            $data= DATA::Ejecutar($sql,$param);
            return $data;
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar el producto'))
            );
        }
    }

    function ReadArticulo(){
        try {
            $sql='SELECT id, nombre, codigo, descripcion, saldoCosto, costoPromedio, precioVenta, esVenta
                FROM producto  
                where id=:id and esVenta=0';
            $param= array(':id'=>$this->id);
            $data= DATA::Ejecutar($sql,$param);
            return $data;
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar el producto'))
            );
        }
    }

    function ReadArticuloByCode(){
        try {
            $sql='SELECT id, nombre, codigo, descripcion, saldoCosto, costoPromedio, precioVenta, esVenta
                FROM producto  
                where codigo like :codigo and esVenta=0';
            $param= array(':codigo'=>'%'.$this->codigo.'%');
            $data= DATA::Ejecutar($sql,$param);
            return $data;
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar el producto'))
            );
        }
    }

    function Create(){
        try {
            // $this->txtColor = "010203";
            // $this->bgColor = "040506";
            $sql="INSERT INTO tropical.producto   (id, nombre, codigo, txtColor, bgColor, nombreAbreviado, descripcion, saldoCantidad, saldoCosto, costoPromedio, precioVenta, esVenta) 
            VALUES (uuid(), :nombre, :codigo ,:txtColor, :bgColor, :nombreAbreviado, :descripcion, :saldoCantidad, :saldoCosto, :costoPromedio ,:precioVenta, :esVenta);";
            //
            $param= array(':nombre'=>$this->nombre, 
            ':codigo'=>$this->codigo,
            ':txtColor'=>$this->txtColor,
            ':bgColor'=>$this->bgColor,
            ':nombreAbreviado'=>$this->nombreAbreviado,
            ':descripcion'=>$this->descripcion,
            ':saldoCantidad'=>$this->saldoCantidad,
            ':saldoCosto'=>$this->saldoCosto,
            ':costoPromedio'=>$this->costoPromedio,
            ':precioVenta'=>$this->precioVenta, 
            ':esVenta'=>$this->esVenta);

            $data = DATA::Ejecutar($sql,$param, false);
            if($data)
            {
                //get id.
                //save array obj
                return true;
            }
            else throw new Exception('Error al guardar.', 02);
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }

    function Update(){
        try {
            $sql="UPDATE producto 
                SET codigo=:codigo, nombre=:nombre, txtColor=:txtColor, bgColor=:bgColor, nombreAbreviado=:nombreAbreviado, descripcion=:descripcion, saldoCantidad=:saldoCantidad, saldoCosto=:saldoCosto, costoPromedio=:costoPromedio, precioVenta=:precioVenta, esVenta=:esVenta
                WHERE id=:id";
            $param= array(':id'=>$this->id, ':codigo'=>$this->codigo, ':nombre'=>$this->nombre, ':txtColor'=>$this->txtColor,':bgColor'=>$this->bgColor,':nombreAbreviado'=>$this->nombreAbreviado,':descripcion'=>$this->descripcion,':saldoCantidad'=>$this->saldoCantidad,':saldoCosto'=>$this->saldoCosto,':costoPromedio'=>$this->costoPromedio,':precioVenta'=>$this->precioVenta, ':esVenta'=>$this->esVenta);
            $data = DATA::Ejecutar($sql,$param,false);
            if($data)
                return true;
            else throw new Exception('Error al guardar.', 123);
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }

    private function CheckRelatedItems(){
        try{
            $sql="SELECT id
                FROM productosXDistribucion
                WHERE idProducto= :id";                
            $param= array(':id'=>$this->id);
            $data= DATA::Ejecutar($sql, $param);
            if(count($data))
                return true;
            else return false;
        }
        catch(Exception $e){
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }

    function Delete(){
        try {
            if($this->CheckRelatedItems()){
                //$sessiondata array que devuelve si hay relaciones del objeto con otras tablas.
                $sessiondata['status']=1; 
                $sessiondata['msg']='Registro en uso'; 
                return $sessiondata;           
            }                    
            $sql='DELETE FROM producto  
            WHERE id= :id';
            $param= array(':id'=>$this->id);
            $data= DATA::Ejecutar($sql, $param, false);
            if($data)
                return $sessiondata['status']=0;
            else throw new Exception('Error al eliminar.', 978);
        }
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }

    function ReadByCode(){
        try{
            $sql="SELECT id, nombre, codigo, descripcion, saldoCosto, costoPromedio, precioVenta, esVenta, saldoCantidad
                FROM producto 
                WHERE codigo like :codigo";
            $param= array(':codigo'=>'%'.$this->codigo.'%');

            $data= DATA::Ejecutar($sql,$param);
            
            if(count($data))
                return $data;
            else return false;
        }
        catch(Exception $e){
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }

    function ActualizaPrecios(){
        try{     
            $created = true;
            foreach ($this->lista as $item) {
                $sql="UPDATE producto
                    SET precioVenta=:precioVenta
                    WHERE id= :id";
                $param= array(':id'=>$item->id, ':precioVenta'=>$item->precioVenta);
                $data= DATA::Ejecutar($sql,$param, false);
                if(!$data)
                    $created= false;                
            }
            if(!$created)
                throw new Exception('Error al actualizar precios, REVISAR manualmente.', 666);
            else return true;
            // 
        }
        catch(Exception $e){
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }

    public static function RevierteProducto($id, $cantidad, $costo){
        try {
            $sql="CALL spRevierteProducto(:mid, :ncantidad, :ncosto);";
            $param= array(':mid'=>$id, ':ncantidad'=>$cantidad, ':ncosto'=>$costo);
            $data = DATA::Ejecutar($sql,$param,false);
            if($data)
                return true;
            else throw new Exception('Error al calcular SALDOS Y PROMEDIOS, debe realizar el cálculo manualmente.', 666);
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    } 

    function ReadAllInventario(){
        try {
            $sql='SELECT i.id,            
            COALESCE(o.orden, CONCAT("Orden: ", s.numeroOrden)) as idOrdenEntrada,
            COALESCE(CONCAT("Traslado: ", d.orden), CONCAT("Merma:", m.consecutivo), CONCAT("Ord Cancel:", os.numeroOrden)) as idOrdenSalida,            
            p.codigo AS producto,
            entrada,
            salida,
            saldo,
            costoAdquisicion,
            valorEntrada,
            valorSalida,
            valorSaldo,
            i.costoPromedio,
            i.fecha
                FROM  inventarioProducto i inner join producto p on p.id = i.idProducto
                    left join ordenCompra o on i.idOrdenEntrada = o.id 
                    left join ordenSalida s on i.idOrdenEntrada = s.id
                    left join distribucion d on i.idOrdenSalida = d.id
                    left join mermaProducto m on i.idOrdenSalida = m.id
                    left join ordenSalida os on i.idOrdenSalida = os.id
                ORDER BY fecha desc';
            $data= DATA::Ejecutar($sql);
            return $data;
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar la lista'))
            );
        }    
    }

    function ReadAllbyRange(){
        try {
            $sql='SELECT i.id,            
            COALESCE(
              o.orden, 
              CONCAT("Orden: ", s.numeroOrden),
              CONCAT("Revierte Traslado: ",dE.orden)
            ) as idOrdenEntrada,
            COALESCE(CONCAT("Traslado: ", d.orden), CONCAT("Merma:", m.consecutivo), CONCAT("Ord Cancel:", os.numeroOrden)) as idOrdenSalida,            
            p.codigo AS producto,
            entrada,
            salida,
            saldo,
            costoAdquisicion,
            valorEntrada,
            valorSalida,
            valorSaldo,
            i.costoPromedio,
            i.fecha
            FROM  inventarioProducto i inner join producto p on p.id = i.idProducto
                left join ordenCompra o on i.idOrdenEntrada = o.id 
                left join ordenSalida s on i.idOrdenEntrada = s.id
                left join distribucion d on i.idOrdenSalida = d.id
                left join distribucion dE on i.idOrdenEntrada = dE.id
                left join mermaProducto m on i.idOrdenSalida = m.id
                left join ordenSalida os on i.idOrdenSalida = os.id
            WHERE i.fecha Between :fechaInicial and :fechaFinal               
            ORDER BY i.fecha desc;';
            
            $param= array(':fechaInicial'=>$this->fechaInicial, ':fechaFinal'=>$this->fechaFinal);            
            $data= DATA::Ejecutar($sql, $param);
            return $data;
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar la lista'))
            );
        }    
    }


}

?>