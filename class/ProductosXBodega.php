<?php
if(isset($_POST["action"])){
    $opt= $_POST["action"];
    unset($_POST['action']);
    // Classes
    require_once("Conexion.php");
    // Session
    if (!isset($_SESSION))
        session_start();
    // Instance
    $productosxbodega= new ProductosXBodega();
    switch($opt){
        case "ReadAll": // todos los productos de una bodega
            $productosxbodega->idbodega = $_POST["idbodega"]; // id de la bodega
            echo json_encode($productosxbodega->ReadAll());
            break;
        case "Read":
            echo json_encode($productosxbodega->Read());
            break;
        case "Create":
            $productosxbodega->Create();
            break;
        case "Update":
            $productosxbodega->Update();
            break;
        case "Delete":
            echo json_encode($productosxbodega->Delete());
            break;   
    }
}

class ProductosXBodega{
    public $id=null;
    public $idbodega='';
    public $idproducto='';
    public $producto='';
    public $cantidad=0;
    public $costo=0;

    function __construct(){
        // identificador único
        if(isset($_POST["id"])){
            $this->id= $_POST["id"];
        }
        if(isset($_POST["obj"])){
            $obj= json_decode($_POST["obj"],true);
            $this->id= $obj["id"] ?? null;
            $this->idbodega= $obj["idbodega"] ?? null;
            $this->idproducto= $obj["idproducto"] ?? null;
            $this->cantidad= $obj["cantidad"] ?? 0;      
            $this->costo= $obj["costo"] ?? 0;
            // En caso de ser una lista de articulos para agregar O lista de productos por distribuir.
            if(isset($obj["lista"] )){
                foreach ($obj["lista"] as $item) {
                    $this->id= $item['id'];            
                    $this->idbodega= $item['idbodega'];
                    $this->idproducto= $item['idproducto'];
                    $this->cantidad= $item['cantidad'];
                    $this->costo= $item['costo'];
                    $this->Create();
                    // Si tiene ID de producto es porque viene de la bodega principal y debe restar
                    if($this->id!=null){
                        $this->RestarBodega($this->id, $this->cantidad);
                    }
                }
                die( );
            }
        }
    }

    function ReadAll(){
        try {
            $sql='SELECT pb.id, idbodega, idproducto, nombre as producto, pb.cantidad, pb.costo
                FROM     productosxbodega   pb INNER JOIN producto p on p.id=pb.idproducto
                WHERE    idbodega= :idbodega
                ORDER BY idbodega asc';
            $param= array(':idbodega'=>$this->idbodega);
            $data= DATA::Ejecutar($sql,$param);
            return $data;
        }     
        catch(Exception $e) {
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar la lista'))
            );
        }
    }

    function Read(){
        try {
            $sql='SELECT pb.id,pb.idbodega, pb.idproducto, pb.cantidad, pb.costo , p.nombre as producto
                FROM productosxbodega pb INNER JOIN producto p on p.id=pb.idproducto
                where pb.id=:id';
            $param= array(':id'=>$this->id);
            $data= DATA::Ejecutar($sql,$param);
            return $data;
        }     
        catch(Exception $e) {
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar el productosxbodega'))
            );
        }
    }

    function Create(){
        try {
            $sql="INSERT INTO productosxbodega (id, idbodega, idproducto, cantidad, costo) VALUES (uuid(),:idbodega, :idproducto, :cantidad, :costo);";
            //
            $param= array(':idbodega'=>$this->idbodega, ':idproducto'=>$this->idproducto, ':cantidad'=>$this->cantidad, ':costo'=>$this->costo);
            $data = DATA::Ejecutar($sql,$param, false);
            if($data)
            {
                return true;
            }
            else throw new Exception('Error al guardar.', 02);
        }     
        catch(Exception $e) {
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }

    function Update(){
        try {
            $sql="UPDATE productosxbodega 
                SET cantidad=:cantidad, costo=:costo
                WHERE id=:id";
            $param= array(':id'=>$this->id, ':cantidad'=>$this->cantidad, ':costo'=>$this->costo);
            $data = DATA::Ejecutar($sql,$param,false);
            if($data)
                return true;
            else throw new Exception('Error al guardar.', 123);
        }     
        catch(Exception $e) {
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
            $sql='DELETE FROM productosxbodega  
            WHERE id= :id';
            $param= array(':id'=>$this->id);
            $data= DATA::Ejecutar($sql, $param, false);
            if($data)
                return $sessiondata['status']=0; 
            else throw new Exception('Error al eliminar.', 978);
        }
        catch(Exception $e) {
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }

    function RestarBodega($idPB, $cantidadrestar){
        try {
            $sql="UPDATE productosxbodega 
                SET cantidad= cantidad - :cantidadrestar
                WHERE id= :idPB";
            //
            $param= array(':id'=>$idPB, ':cantidadrestar'=>$cantidadrestar);
            $data = DATA::Ejecutar($sql,$param, false);
            if($data)
            {
                return true;
            }
            else throw new Exception('Error al guardar.', 02);
        }     
        catch(Exception $e) {
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }

}

?>