<?php
require_once("Conexion.php");
//require_once("Log.php");
//require_once('Globals.php');
//
if (!isset($_SESSION))
    session_start();

if(isset($_POST["action"])){
    $opt= $_POST["action"];
    unset($_POST['action']);
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
            $productotemporal->Delete();
            break;   
    }
}

class ProductoTemporal{
    public $id=null;
    public $idproducto='';
    public $idusuario='';
    public $cantidad=0;
    public $estado=0;

    public $insumo=[];
    public $cantidadinsumo=[];

    public $insumos= array();

    function __construct(){
        // identificador único
        if(isset($_POST["id"])){
            $this->id= $_POST["id"];
        }
        if(isset($_POST["obj"])){
            $obj= json_decode($_POST["obj"],true);
            $this->id= $obj["id"] ?? null;
            $this->idproducto= $obj["idproducto"] ?? '';
            $this->idusuario= $obj["idusuario"] ?? '';
            $this->cantidad= $obj["cantidad"] ?? 0;            
            $this->estado= $obj["estado"] ?? 0;
            $this->insumo=$obj["insumo"];
            $this->cantidadinsumo=$obj["cantidadinsumo"];
            // if (isset($obj["insumos"] )) {
            //     require_once("CategoriasXProducto.php");
                
            // }
        }
    }

    function ReadAll(){
        try {
            $sql='SELECT id, idproducto, (select nombre from producto where id=idproducto) as producto, idusuario, (select nombre from usuario where id=idusuario) as usuario, cantidad, estado
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
    
    // function Read(){
    //     try {
    //         $sql='SELECT pt.id, pt.idproducto, pt.cantidad, pt.estado, ip.idinsumo as insumo, ip.cantidad as cantidadinsumo 
    //         FROM productotemporal pt INNER JOIN insumoxproducto ip on pt.id = ip.idproductotemporal where pt.id=:id';
    //         $param= array(':id'=>$this->id);
    //         $data= DATA::Ejecutar($sql,$param);     
    //         foreach ($data as $key => $value){
    //             if($key==0){
    //                 $this->id = $value['id'];
    //                 $this->idproducto = $value['idproducto'];
    //                 $this->cantidad = $value['cantidad'];
    //                 $this->estado = $value['estado'];
    //                 $this->insumo = $value['insumo'];
    //                 $this->cantidadinsumo = $value['cantidadinsumo'];
    //                 //rol
    //                 if($value['idrol']!=null){
    //                     $rol->id = $value['idrol'];
    //                     $rol->nombre = $value['nombrerol'];
    //                     array_push ($this->listarol, $rol);
    //                 }
    //             }
    //             else {
    //                 $rol->id = $value['idrol'];
    //                 $rol->nombre = $value['nombrerol'];
    //                 array_push ($this->listarol, $rol);
    //             }
    //         }
    //         return $this;
    //     }     
    //     catch(Exception $e) {
    //         header('HTTP/1.0 400 Bad error');
    //         die(json_encode(array(
    //             'code' => $e->getCode() ,
    //             'msg' => 'Error al cargar el usuario'))
    //         );
    //     }
    // }

    function Read(){
        try {
            $sql='SELECT id, idproducto, idusuario, cantidad, estado
                FROM productotemporal  
                where id=:id';
            $param= array(':id'=>$this->id);
            $data= DATA::Ejecutar($sql,$param);
            return $data;
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
            $sql="INSERT INTO productotemporal   (id, idproducto, idusuario, cantidad, estado, fecha) VALUES (uuid(),:idproducto, :idusuario, :cantidad, :estado, now());";
            //
            $param= array(':idproducto'=>$this->idproducto, ':idusuario'=>$this->idusuario, ':cantidad'=>$this->cantidad, ':estado'=>$this->estado);
            $data = DATA::Ejecutar($sql,$param, false);

            //Consultar el Maximo ID insertado
            $maxid="SELECT id FROM productotemporal ORDER BY fecha DESC LIMIT 0,1";
            //Captura el id del formulario
            $idproductotemporal =DATA::Ejecutar($maxid);

            for ($i=0; $i <count($this->insumo) ; $i++) {
                $sql="INSERT INTO insumoxproducto   (id, idinsumo, idproductotemporal,cantidad)
                VALUES (uuid(),:idinsumo, :idproductotemporal,:cantidad)";
                //
                $param= array(':idinsumo'=>$this->insumo[$i], ':idproductotemporal'=>$idproductotemporal[0][0], ':cantidad'=>$this->cantidadinsumo[$i]);
                $data2 = DATA::Ejecutar($sql,$param,false);
            }

            if($data and $data2)
            {
                //get id.
                //save array obj
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
            $sql="UPDATE productotemporal 
                SET idproducto=:idproducto, idusuario=:idusuario, cantidad=:cantidad, estado=:estado
                WHERE id=:id";
            $param= array(':id'=>$this->id, ':idproducto'=>$this->idproducto, ':idusuario'=>$this->idusuario, ':cantidad'=>$this->cantidad, ':estado'=>$this->estado);
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