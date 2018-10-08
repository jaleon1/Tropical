<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

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
    $ordenCompra= new OrdenCompra();
    switch($opt){
        case "ReadAll":
            echo json_encode($ordenCompra->ReadAll());
            break;
        case "Read":
            echo json_encode($ordenCompra->Read());
            break;
        case "ReadbyOrden":
            echo json_encode($ordenCompra->ReadbyOrden());
            break;
        case "Create":
            $ordenCompra->Create();
            break;
        case "Update":
            $ordenCompra->Update();
            break;
        case "Delete":
            $ordenCompra->Delete();
            break;   
    }
}

class OrdenCompra{
    public $id=null;
    public $fecha='';
    public $idProveedor=null;
    public $orden='';
    public $idUsuario=null;
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
            $this->idProveedor= $obj["idProveedor"] ?? null;
            $this->orden= $obj["orden"] ?? '';            
            //$this->idUsuario= $obj["idUsuario"] ?? null;
            // lista.
            if(isset($obj["lista"] )){
                require_once("InsumosXOrdenCompra.php");
                //
                foreach ($obj["lista"] as $itemlist) {
                    $item= new InsumosXOrdenCompra();
                    $item->idOrdenCompra= $this->id;
                    $item->ordenCompra= $this->orden;
                    $item->idInsumo= $itemlist['idInsumo'];
                    $item->esVenta= $itemlist['esVenta'];
                    $item->costoUnitario= $itemlist['costoUnitario'];
                    $item->cantidadBueno= $itemlist['cantidadBueno'];
                    $item->cantidadMalo= $itemlist['cantidadMalo'];
                    $item->valorBueno= $itemlist['valorBueno'];
                    $item->valorMalo= $itemlist['valorMalo'];
                    array_push ($this->lista, $item);
                }
            }
        }
    }

    function ReadAll(){
        try {
            $sql='SELECT o.id, o.fecha, o.orden, u.nombre as usuario
                FROM     ordenCompra o INNER JOIN usuario  u on u.id=o.idUsuario
                ORDER BY fecha asc';
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
            $sql='SELECT id, fecha, idProveedor, orden, idUsuario, (SELECT nombre FROM usuario WHERE id=idUsuario) AS usuario
                FROM ordenCompra  
                where id=:id';
            $param= array(':id'=>$this->id);
            $data= DATA::Ejecutar($sql,$param);
            return $data;
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar el ordenCompra'))
            );
        }
    }

    function ReadbyOrden(){
        try {
            $sql='SELECT ixo.id,
                oc.orden as codigo,
                COALESCE(i.codigo, p.codigo) as insumo,
                ((ixo.cantidadBueno + ixo.cantidadMalo) * ixo.costoUnitario)AS subtotal,
                costoUnitario,
                cantidadBueno,
                cantidadMalo,
                valorBueno,
                valorMalo
            FROM insumosXOrdenCompra ixo
                left join ordenCompra oc on oc.id = ixo.idOrdenCompra
                left join insumo i on i.id = ixo.idInsumo
                left join producto p on p.id = ixo.idInsumo
            where idOrdenCompra=:idOrdenCompra';
            $param= array(':idOrdenCompra'=>$this->id);
            $data= DATA::Ejecutar($sql,$param);
            return $data;
            // $data = InsumosXOrdenCompra::Read($this->id);
            // return $data;
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar el ordenCompra'))
            );
        }
    }

    function Create(){
        try {
            $sql="INSERT INTO ordenCompra   (id, idProveedor, orden, idUsuario) VALUES (:id, :idProveedor, :orden, :idUsuario);";
            $param= array(':id'=>$this->id ,':idProveedor'=>$this->idProveedor, ':orden'=>$this->orden, ':idUsuario'=>$_SESSION['userSession']->id);
            $data = DATA::Ejecutar($sql,$param,false);
            if($data)
            {
                //save array obj
                if(InsumosXOrdenCompra::Create($this->lista)){
                    return true;
                }
                else throw new Exception('Error al guardar los roles.', 03);
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

    // function CreateInventarioInsumo($obj){
    //     try {
    //         $created = true;
    //         require_once("Insumo.php");
    //         foreach ($obj as $item) {          
                
    //             $sql="SELECT saldoCantidad, saldoCosto, costoPromedio FROM insumo WHERE id=:idInsumo;";
    //             $param= array(':idInsumo'=>$item->idInsumo);
    //             $valor=DATA::Ejecutar($sql,$param); 
                
    //             $sql="SELECT fecha FROM ordenCompra WHERE id=:idOrdenCompra;";
    //             $param= array(':idOrdenCompra'=>$item->idOrdenCompra);
    //             $fecha=DATA::Ejecutar($sql,$param);
                
    //             $sql="INSERT INTO inventarioInsumo   (id, idOrdenCompra, idInsumo, entrada, saldo, costoAdquisicion, valorEntrada, valorSaldo, costoPromedio, fecha)
    //                 VALUES (uuid(), :idOrdenCompra, :idInsumo, :entrada, :saldo, :costoAdquisicion, :valorEntrada, :valorSaldo, :costoPromedio, :fecha);";
    //             $param= array(':idOrdenCompra'=>$item->idOrdenCompra, 
    //                 ':idInsumo'=>$item->idInsumo,
    //                 ':entrada'=>$item->cantidadBueno,
    //                 ':saldo'=>$valor[0]['saldoCantidad'], 
    //                 ':costoAdquisicion'=>$item->costoUnitario, 
    //                 ':valorEntrada'=>$item->valorBueno,
    //                 ':valorSaldo'=>$valor[0]['saldoCosto'],
    //                 ':costoPromedio'=>$valor[0]['costoPromedio'],
    //                 ':fecha'=>$fecha[0]['fecha']
    //             );
    //             DATA::Ejecutar($sql,$param,false);                
    //         }
    //         return $created;
    //     }     
    //     catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
    //         return false;
    //     }
    // }

    function Update(){
        try {
            $sql="UPDATE ordenCompra 
                SET fecha=:fecha, idProveedor=:idProveedor, orden=:orden, idUsuario=:idUsuario
                WHERE id=:id";
            $param= array(':id'=>$this->id, ':fecha'=>$this->fecha, ':idProveedor'=>$this->idProveedor, ':orden'=>$this->orden, ':idUsuario'=>$this->idUsuario);
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
            $sql='DELETE FROM ordenCompra  
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
            $sql="SELECT id, fecha, idProveedor, descripcion
                FROM ordenCompra
                WHERE idProveedor= :idProveedor";
            $param= array(':idProveedor'=>$this->idProveedor);
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