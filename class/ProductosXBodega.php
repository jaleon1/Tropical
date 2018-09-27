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
    $productosxbodega= new ProductosXBodega();
    switch($opt){
        case "ReadAll": // todos los productos de una bodega
            // $productosxbodega->idBodega = $_POST["idBodega"]; // id de la bodega
            echo json_encode($productosxbodega->ReadAll());
            break;
        case "Read":
            echo json_encode($productosxbodega->Read());
            break;
        case "Create":
            $productosxbodega->Create();
            break;
        case "Add":
            $productosxbodega->Add();
            break;
        case "Update":
            $productosxbodega->Update();
            break;
        case "Delete":
            echo json_encode($productosxbodega->Delete());
            break;   
        case "ActualizaPrecios":
            $productosxbodega->ActualizaPrecios();
            break;
    }
}

class ProductosXBodega{
    public $id=null;
    public $idBodega='';
    public $Tamano='1'; //1: Grande; 0: Mediano.
    public $precioVenta=0;
    public $lista=array();
    // public $idProducto='';
    // public $producto='';
    // public $cantidad=0;
    // public $costo=0;    

    function __construct(){
        // identificador único
        if(isset($_POST["id"])){
            $this->id= $_POST["id"] ?? null;
        }
        if(isset($_POST["idBodega"])){
            $this->idBodega= $_POST["idBodega"];
        }
        else $this->idBodega= $_SESSION["userSession"]->idBodega; // si no está seteada el idBodega, toma el de la sesion.
        if(isset($_POST["obj"])){
            $obj= json_decode($_POST["obj"],true);
            $this->id= $obj["id"] ?? null;
            $this->idBodega= $obj["idBodega"] ?? null;
            $this->idProducto= $obj["idProducto"] ?? null;
            $this->cantidad= $obj["cantidad"] ?? 0;      
            $this->costo= $obj["costo"] ?? 0;
            unset($_POST['obj']);
            // En caso de ser una lista de articulos para agregar O lista de productos por distribuir.
            if(isset($obj["lista"] )){
                //require_once("Producto.php");
                foreach ($obj["lista"] as $item) {
                    // $prodTemp =  new Producto();
                    // $prodTemp->id= $item['id'];            
                    // $prodTemp->idBodega= $item['idBodega'];
                    // $prodTemp->idProducto= $item['idProducto'];
                    // $prodTemp->cantidad= $item['cantidad'];
                    // $prodTemp->costo= $item['costo'];
                    // array_push ($this->lista, $prodTemp);
                    $prodTemp =  new ProductosXBodega();
                    $prodTemp->id= $item['id'];
                    $prodTemp->precioVenta= $item['precioVenta'];
                    array_push ($this->lista, $prodTemp);
                }
                unset($_POST['lista']);
            }
        }
    }

    function ReadAll(){
        try {
            $sql='SELECT id, tamano, precioVenta
                FROM     preciosXBodega
                WHERE    idBodega= :idBodega';
                //    AND		 p.articulo = "0"
            $param= array(':idBodega'=>$this->idBodega);
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


    function ReadAllPrd_Bdg(){
        try {
            $sql='SELECT pb.id, idBodega, idProducto, nombre as producto, pb.cantidad, pb.costo, p.bgColor, p.txtColor
                FROM     preciosXBodega   pb INNER JOIN producto p on p.id=pb.idProducto
                WHERE    idBodega= :idBodega
                AND		 p.articulo = "0"
                ORDER BY idBodega asc';
            $param= array(':idBodega'=>$this->idBodega);
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


    function Read(){
        try {
            $sql='SELECT pb.id,pb.idBodega, pb.idProducto, pb.cantidad, pb.costo , p.nombre as producto
                FROM preciosXBodega pb INNER JOIN producto p on p.id=pb.idProducto
                where pb.id=:id';
            $param= array(':id'=>$this->id);
            $data= DATA::Ejecutar($sql,$param);
            return $data;
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar el productosxbodega'))
            );
        }
    }

    // function Create2_borrar_si_no_se_usa(){
    //     try {
    //         $sql="INSERT INTO preciosXBodega (id, idBodega, idProducto, cantidad, costo) VALUES (uuid(),:idBodega, :idProducto, :cantidad, 
    //         (SELECT SUM(costo) FROM insumosxproducto WHERE idProductoTemporal=:idProductoTemporal) );";
    //         //
    //         $param= array(':idBodega'=>$this->idBodega, ':idProducto'=>$this->idProducto, ':cantidad'=>$this->cantidad,':idProductoTemporal'=>$_POST["idProductoTemporal"]);
    //         $data = DATA::Ejecutar($sql,$param, false);
    //         $sql2 = "UPDATE elaborarProducto SET estado=1 WHERE id=:idProductoTemporal";
    //         $param2=array(':idProductoTemporal'=>$_POST["idProductoTemporal"]);
    //         $data2 = DATA::Ejecutar($sql2, $param2, false);
    //         if($data && $data2)
    //         {
    //             return true;
    //         }
    //         else throw new Exception('Error al guardar.', 02);
    //     }     
    //     catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
    //         header('HTTP/1.0 400 Bad error');
    //         die(json_encode(array(
    //             'code' => $e->getCode() ,
    //             'msg' => $e->getMessage()))
    //         );
    //     }
    // }

    function create(){
        try {
            $sql="INSERT INTO preciosXBodega (id, idBodega, tamano, precioVenta) 
                VALUES (uuid(), :idBodega, :tamano, :precioVenta);";
            //
            $this->tamano=0;
            $param= array(':idBodega'=>$this->idBodega, ':tamano'=>$this->tamano, ':precioVenta'=>$this->precioVenta );
            $data = DATA::Ejecutar($sql,$param, false);
            $this->tamano=1;
            $param= array(':idBodega'=>$this->idBodega, ':tamano'=>$this->tamano, ':precioVenta'=>$this->precioVenta );
            $data = DATA::Ejecutar($sql, $param, false);
            if($data)
            {
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

    function Add(){
        try {
            foreach ($this->lista as $producto) {
                $sql="INSERT INTO preciosXBodega (id, idBodega, idProducto, cantidad, costo) VALUES (uuid(),:idBodega, :idProducto, :cantidad, :costo);";
                //
                $param= array(':idBodega'=>$producto->idBodega, ':idProducto'=>$producto->idProducto, ':cantidad'=>$producto->cantidad, ':costo'=>$producto->costo);
                $data = DATA::Ejecutar($sql,$param, false);
                if($data){
                    // Si tiene ID de producto es porque viene de la bodega principal y debe restar
                    if($producto->id!=null)
                        $this->RestarBodega($producto->id, $producto->cantidad );
                }
                else throw new Exception('Error al guardar.', 02);                
            }   
            //
            return true;         
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
            $sql="UPDATE preciosXBodega 
                SET cantidad=:cantidad, costo=:costo
                WHERE id=:id";
            $param= array(':id'=>$this->id, ':cantidad'=>$this->cantidad, ':costo'=>$this->costo);
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
                FROM /*  definir relacion */ R
                WHERE R./*definir campo relacion*/= :id";                
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
            // if($this->CheckRelatedItems()){
            //     //$sessiondata array que devuelve si hay relaciones del objeto con otras tablas.
            //     $sessiondata['status']=1; 
            //     $sessiondata['msg']='Registro en uso'; 
            //     return $sessiondata;           
            // }                    
            $sql='DELETE FROM preciosXBodega  
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

    function RestarBodega($idprob, $cantidad){
        try {
            $sql="UPDATE productosXBodega 
                SET cantidad= cantidad - :cantidad
                WHERE id= :id   ";
            //
            $param= array(':id'=>$idprob, ':cantidad'=> $cantidad);
            $data = DATA::Ejecutar($sql,$param, false);
            if(!$data)
                throw new Exception('Error al guardar.', 02);
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
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
                $sql="UPDATE preciosXBodega
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

}

?>
