<?php
if(isset($_POST["action"])){
    $opt= $_POST["action"];
    unset($_POST['action']);
    // Classes
    require_once("Conexion.php");
    require_once('Evento.php');
    require_once('Usuario.php');
    // Session
    if (!isset($_SESSION))
        session_start();
    // Instance
    $productotemporal= new ProductoTemporal();
    switch($opt){
        case "ReadAll":
            echo json_encode($productotemporal->ReadAll());
            break;
        case "Read":
            echo json_encode($productotemporal->Read());
            break;
        case "Create":
            $productotemporal->Create();
            break;
        case "Update":
            $productotemporal->Update();
            break;
        case "Delete":
            echo json_encode($productotemporal->Delete());
            break;   
    }
}

class ProductoTemporal{
    public $id=null;
    public $idproducto='';
    public $idusuario='';
    public $idusuariorecibe='';
    public $usuario='';
    public $usuariorecibe='';
    public $producto='';
    public $cantidad=0;
    public $estado=0;
    public $listainsumo=[];

    function __construct(){
        // identificador único
        if(isset($_POST["id"])){
            $this->id= $_POST["id"];
        }
        if(isset($_POST["obj"])){
            $obj= json_decode($_POST["obj"],true);
            require_once("UUID.php");
            $this->id= $obj["id"] ?? UUID::v4();
            $this->idproducto= $obj["idproducto"] ?? '';
            $this->idusuariorecibe= $obj["idusuariorecibe"] ?? '';
            $this->cantidad= $obj["cantidad"] ?? 0;            
            $this->estado= $obj["estado"] ?? 0;
            //Insumos del Producto
            if (isset($obj["listainsumo"] )) {
                require_once("InsumosXProducto.php");    
                //            
                foreach ($obj["listainsumo"] as $objInsumo) {
                    $insprod= new InsumosXProducto();
                    $insprod->idinsumo= $objInsumo['id'];
                    $insprod->idproductotemporal= $this->id;
                    $insprod->cantidad= $objInsumo['cantidad'];
                    $insprod->costo= $objInsumo['costo'];
                    array_push ($this->listainsumo, $insprod);
                }
            }
        }
    }

    function ReadAll(){
        try {
            $sql='SELECT id, idproducto, (select nombre from producto where id=idproducto) as producto, idusuario, 
            (select nombre from usuario where id=idusuario) as usuario, 
            idusuariorecibe, (select nombre from usuario where id=idusuariorecibe) as usuariorecibe,cantidad, estado
                FROM     productotemporal       
                ORDER BY idproducto asc';
            $data= DATA::Ejecutar($sql);
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
            $productotemporal=null;
            $insumosxproducto=null;

            $sql_productotemporal='SELECT id, idusuario, (SELECT nombre FROM usuario WHERE id=idusuario) AS usuario, idproducto, 
            idusuariorecibe, (SELECT nombre FROM usuario WHERE id=idusuariorecibe) AS usuariorecibe,
            (SELECT nombre FROM producto WHERE id=idproducto) AS producto, cantidad, estado FROM productotemporal 
            WHERE id=:id';
            
            $sql_insumosxproducto='SELECT id,idproductotemporal,idinsumo,(SELECT nombre FROM insumo WHERE id=idinsumo) AS nombre,cantidad,costo FROM insumosxproducto WHERE idproductotemporal=:id';

            $param= array(':id'=>$this->id);
            $productotemporal = DATA::Ejecutar($sql_productotemporal,$param);
            $insumosxproducto = DATA::Ejecutar($sql_insumosxproducto,$param);

            $this->id = $productotemporal[0]['id'];
            $this->idproducto = $productotemporal[0]['idproducto'];
            $this->idusuario = $productotemporal[0]['idusuario'];
            $this->idusuariorecibe = $productotemporal[0]['idusuariorecibe'];
            $this->usuario = $productotemporal[0]['usuario'];
            $this->usuariorecibe = $productotemporal[0]['usuariorecibe'];
            $this->producto = $productotemporal[0]['producto'];
            $this->cantidad = $productotemporal[0]['cantidad'];
            $this->estado = $productotemporal[0]['estado'];
            
            foreach ($insumosxproducto as $key => $value){
                require_once("InsumosxProducto.php");
                $insprod = new InsumosxProducto();
                
                $insprod->id = $value['id'];
                $insprod->idinsumo = $value['idinsumo'];
                $insprod->nombre = $value['nombre'];
                $insprod->idproductotemporal = $value['idproductotemporal'];
                $insprod->cantidad = $value['cantidad'];
                $insprod->costo = $value['costo'];
                array_push ($this->listainsumo, $insprod);
            }
            return $this;
        }     
        catch(Exception $e) {
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar el productotemporal'))
            );
        }
    }

    function Create(){
        try {
            $sql="INSERT INTO productotemporal   (id, idproducto, idusuario, idusuariorecibe, cantidad, estado, fecha) 
                VALUES (:uuid, :idproducto, :idusuario, :idusuariorecibe, :cantidad, :estado, now())";
            //
            $param= array(':uuid'=>$this->id, ':idproducto'=>$this->idproducto, ':idusuario'=>$_SESSION['usersession']->id, 
            ':idusuariorecibe'=>$this->idusuariorecibe, ':cantidad'=>$this->cantidad, ':estado'=>$this->estado);
            $data = DATA::Ejecutar($sql,$param, false);

            //Actualizar la cantidad de la tabla de insumos
            // $sql="UPDATE insumo SET bueno=:bueno WHERE id=:id";
            // $sql="UPDATE insumo SET bueno=:bueno WHERE id=:id";
            // $data_insumo = DATA::Ejecutar($sql,$param, false);

            if($data)
            {
                //save array obj
                if(InsumosXProducto::Create($this->listainsumo))
                    return true;
                else throw new Exception('Error al guardar los insumos.', 03);
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
            $sql="UPDATE productotemporal 
                SET idproducto=:idproducto, idusuario=:idusuario, , idusuariorecibe=:idusuariorecibe, cantidad=:cantidad, estado=:estado
                WHERE id=:id";
            $param= array(':id'=>$this->id, ':idproducto'=>$this->idproducto, ':idusuario'=>$this->idusuario, ':idusuariorecibe'=>$this->idusuariorecibe,
            ':cantidad'=>$this->cantidad, ':estado'=>$this->estado);
            $data = DATA::Ejecutar($sql,$param,false);
            if($data){
                //update array obj
                if($this->listainsumo!=null)
                    if(InsumosXProducto::Update($this->listainsumo))
                        return true;            
                    else throw new Exception('Error al guardar los roles.', 03);
                else {
                    // no tiene roles
                    if(InsumosXProducto::Delete($this->id))
                        return true;
                    else throw new Exception('Error al guardar los roles.', 04);
                }
            }
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
            $sql="SELECT idproducto
                FROM insumosxproducto R
                WHERE R.idproducto= :id";                
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
            $sql='DELETE FROM productotemporal  
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

}



?>