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
    $distribucion= new Distribucion();
    switch($opt){
        case "ReadAll":
            echo json_encode($distribucion->ReadAll());
            break;
        case "Read":
            echo json_encode($distribucion->Read());
            break;
        case "ReadbyOrden":
            echo json_encode($distribucion->ReadbyOrden());
            break;
        case "Create":
            echo json_encode($distribucion->Create());
            break;
        case "Update":
            $distribucion->Update();
            break;
        case "Delete":
            $distribucion->Delete();
            break;  
        case "Aceptar":
            $distribucion->Aceptar();
            break;   
    }
}

class Distribucion{
    public $id=null;
    public $fecha='';
    public $idbodega=null;
    public $orden='';
    public $idusuario=null;
    public $porcentajedescuento=0;
    public $porcentajeiva=null;
    public $lista= [];

    function __construct(){
        // identificador único
        if(isset($_POST["id"])){
            $this->id= $_POST["id"];
        }
        if(isset($_POST["obj"])){
            $obj= json_decode($_POST["obj"],true);
            require_once("UUID.php");
            $this->id= $obj["id"] ?? UUID::v4();
            //$this->fecha= $obj["fecha"] ?? '';
            $this->idbodega= $obj["idbodega"] ?? null;
            $this->porcentajedescuento= $obj["porcentajedescuento"] ?? 0;
            $this->porcentajeiva= $obj["porcentajeiva"] ?? '';
            $this->orden= $obj["orden"] ?? '';      
            //$this->idusuario= $obj["idusuario"] ?? null;
            // lista.
            if(isset($obj["lista"] )){
                require_once("ProductosXDistribucion.php");
                //
                foreach ($obj["lista"] as $itemlist) {
                    $item= new ProductosXDistribucion();
                    $item->iddistribucion= $this->id;
                    $item->idproducto= $itemlist['idproducto'];
                    $item->cantidad= $itemlist['cantidad'];
                    $item->valor= $itemlist['valor'];
                    array_push ($this->lista, $item);
                }
            }
        }
    }

    function ReadAll(){
        try {
            $sql='SELECT id, fecha, idbodega, orden, idusuario
                FROM     distribucion       
                ORDER BY fecha asc';
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

    function ReadbyOrden(){
        try {
            $sql='SELECT id, fecha, orden, idusuario, idbodega, porcentajedescuento, porcentajeiva 
                FROM tropical.distribucion
                WHERE orden=:orden';
            $param= array(':orden'=>$this->orden);
            $data= DATA::Ejecutar($sql,$param);     
            if(count($data)){
                $this->id = $data[0]['id'];
                $this->fecha = $data[0]['fecha'];
                $this->idusuario = $data[0]['idusuario'];
                $this->idbodega = $data[0]['idbodega'];
                $this->porcentajedescuento = $data[0]['porcentajedescuento'];
                $this->porcentajeiva = $data[0]['porcentajeiva'];
                // productos x distribucion.
                $this->lista= ProductosXDistribucion::Read($this->id);
                //
                return $this;
            }
            else return null;
        }     
        catch(Exception $e) {
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar el distribucion'))
            );
        }
    }

    function Create(){
        try {
            $sql="INSERT INTO distribucion  (id, idbodega, idusuario, porcentajedescuento, porcentajeiva) 
                VALUES (:id, :idbodega, :idusuario, :porcentajedescuento, :porcentajeiva);";
            $param= array(':id'=>$this->id ,
                ':idbodega'=>$this->idbodega, 
                ':idusuario'=>$_SESSION['usersession']->id,
                ':porcentajedescuento'=>$this->porcentajedescuento,
                ':porcentajeiva'=>$this->porcentajeiva,
            );
            $data = DATA::Ejecutar($sql,$param,false);
            if($data)
            {
                //save array obj
                if(ProductosXDistribucion::Create($this->lista)){
                    // retorna orden autogenerada.
                    return $this->Read();
                }
                else throw new Exception('Error al guardar los productos.', 03);
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

    function Aceptar(){
        try {
            $sql="CALL spUpdateSaldosPromedioInsumoBodegaEntrada(:mid, :ncantidad);";
            $param= array(':mid'=>$id, ':ncantidad'=>$ncantidad);
            $data = DATA::Ejecutar($sql,$param,false);
            if($data)
                return true;
            else throw new Exception('Error al calcular SALDOS Y PROMEDIOS, debe realizar el cálculo manualmente.', 666);
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
            $sql="UPDATE distribucion 
                SET fecha=:fecha, idbodega=:idbodega, orden=:orden, idusuario=:idusuario
                WHERE id=:id";
            $param= array(':id'=>$this->id, ':fecha'=>$this->fecha, ':idbodega'=>$this->idbodega, ':orden'=>$this->orden, ':idusuario'=>$this->idusuario);
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
            $sql='DELETE FROM distribucion  
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

    function ReadByCode(){
        try{     
            $sql="SELECT id, fecha, idbodega, descripcion
                FROM distribucion
                WHERE idbodega= :idbodega";
            $param= array(':idbodega'=>$this->idbodega);
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
}



?>