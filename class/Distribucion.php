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
    public $idBodega=null;
    public $orden='';
    public $idUsuario=null;
    public $porcentajeDescuento=0;
    public $porcentajeIva=null;
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
            $this->idBodega= $obj["idBodega"] ?? $_SESSION["userSession"]->idBodega; // si no está seteada el idBodega, toma el de la sesion.
            $this->porcentajeDescuento= $obj["porcentajeDescuento"] ?? 0;
            $this->porcentajeIva= $obj["porcentajeIva"] ?? '';
            $this->orden= $obj["orden"] ?? '';      
            //$this->idUsuario= $obj["idUsuario"] ?? null;
            // lista.
            if(isset($obj["lista"] )){
                require_once("ProductosXDistribucion.php");
                //
                foreach ($obj["lista"] as $itemlist) {
                    $item= new ProductosXDistribucion();
                    $item->idDistribucion= $this->id;
                    $item->idProducto= $itemlist['idProducto'];
                    $item->cantidad= $itemlist['cantidad'];
                    $item->valor= $itemlist['valor'];
                    array_push ($this->lista, $item);
                }
            }
        }
    }

    function ReadAll(){
        try {
            $sql='SELECT id, fecha, idBodega, orden, idUsuario
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
            $sql='SELECT id, fecha, orden, idUsuario, idBodega, porcentajeDescuento, porcentajeIva
                FROM distribucion
                WHERE orden=:orden AND idBodega=:idBodega AND idEstado=0';
            $param= array(':orden'=>$this->orden, ':idBodega'=>$this->idBodega);
            $data= DATA::Ejecutar($sql,$param);     
            if(count($data)){
                $this->id = $data[0]['id'];
                $this->fecha = $data[0]['fecha'];
                $this->idUsuario = $data[0]['idUsuario'];
                $this->idBodega = $data[0]['idBodega'];
                $this->porcentajeDescuento = $data[0]['porcentajeDescuento'];
                $this->porcentajeIva = $data[0]['porcentajeIva'];
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

    // function Read(){
    //     try {
    //         $sql='SELECT id, fecha, orden, idUsuario, idBodega, porcentajeDescuento, porcentajeIva 
    //             FROM distribucion  
    //             where id=:id';
    //         $param= array(':id'=>$this->id);
    //         $data= DATA::Ejecutar($sql,$param);
    //         return $data;
    //     }     
    //     catch(Exception $e) {
    //         header('HTTP/1.0 400 Bad error');
    //         die(json_encode(array(
    //             'code' => $e->getCode() ,
    //             'msg' => 'Error al cargar el producto'))
    //         );
    //     }
    // }

    function Read(){
        try {
            $sql='SELECT id, fecha, orden, idUsuario, idBodega, porcentajeDescuento, porcentajeIva
                FROM distribucion
                where id=:id';
            $param= array(':id'=>$this->id);
            $data= DATA::Ejecutar($sql,$param);     
            if(count($data)){
                $this->id = $data[0]['id'];
                $this->fecha = $data[0]['fecha'];
                $this->orden = $data[0]['orden'];
                $this->idUsuario = $data[0]['idUsuario'];
                $this->idBodega = $data[0]['idBodega'];
                $this->porcentajeDescuento = $data[0]['porcentajeDescuento'];
                $this->porcentajeIva = $data[0]['porcentajeIva'];
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
            $sql="INSERT INTO distribucion  (id, idBodega, idUsuario, porcentajeDescuento, porcentajeIva) 
                VALUES (:id, :idBodega, :idUsuario, :porcentajeDescuento, :porcentajeIva);";
            $param= array(':id'=>$this->id ,
                ':idBodega'=>$this->idBodega, 
                ':idUsuario'=>$_SESSION['userSession']->id,
                ':porcentajeDescuento'=>$this->porcentajeDescuento,
                ':porcentajeIva'=>$this->porcentajeIva,
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
            $created=true;
            $sql="UPDATE distribucion
                SET idEstado=1, fechaAceptacion= NOW()
                WHERE id=:id";
            $param= array(':id'=> $this->id);
            $data = DATA::Ejecutar($sql,$param,false);
            // if(!$data)
            //     // $created=false;
            foreach ($this->lista as $item) {
                $sql="CALL spUpdateSaldosPromedioInsumoBodegaEntrada(:nidproducto, :nidbodega, :ncantidad, :ncosto)";
                $param= array(':nidproducto'=> $item->idProducto, 
                    ':nidbodega'=> $this->idBodega,
                    ':ncantidad'=> $item->cantidad,
                    ':ncosto'=> $item->valor);
                $data = DATA::Ejecutar($sql,$param,false);
                if(!$data)
                    $created= false;
                
            }
            if($created)
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
                SET fecha=:fecha, idBodega=:idBodega, orden=:orden, idUsuario=:idUsuario
                WHERE id=:id";
            $param= array(':id'=>$this->id, ':fecha'=>$this->fecha, ':idBodega'=>$this->idBodega, ':orden'=>$this->orden, ':idUsuario'=>$this->idUsuario);
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
            $sql="SELECT id, fecha, idBodega, descripcion
                FROM distribucion
                WHERE idBodega= :idBodega";
            $param= array(':idBodega'=>$this->idBodega);
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