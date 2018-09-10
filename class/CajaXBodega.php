<?php
date_default_timezone_set('America/Costa_Rica');

if(isset($_POST["action"])){
    $opt= $_POST["action"];
    unset($_POST['action']);
    // Classes
    require_once("Conexion.php");
    require_once("Usuario.php");
    require_once("ClienteFE.php");
    require_once("encdes.php");
    // Session
    if (!isset($_SESSION))
        session_start();
    // Instance
    $cajaXBodega= new CajaXBodega();
    switch($opt){
        case "ReadAll":
            echo json_encode($cajaXBodega->ReadAll());
            break;
        case "Read":
            echo json_encode($cajaXBodega->Read());
            break;
        case "Create":
            echo json_encode($cajaXBodega->Create());
            break;
        case "ValidarCierreCaja":
            echo json_encode($cajaXBodega->ValidarCierreCaja());
            break;
        case "cerrarCaja":
            echo json_encode($cajaXBodega->cerrarCaja());
            break;
        case "Delete":
            echo json_encode($cajaXBodega->Delete());
            break;   
        case "ValidarEstado":
            echo json_encode($cajaXBodega->ValidarEstado());
            break; 
    }
    
}

class CajaXBodega{
    //Factura
    public $id="";
    public $idBodega="";
    public $idUsuarioSupervisor="";
    public $idUsuarioCajero="";
    public $estado="";
    public $montoApertura=null;
    public $montoCierre=null;
    public $totalVentasEfectivo=null; 
    public $totalVentasTarjeta=null;

    function __construct(){
        // identificador único
        if(isset($_POST["id"])){
            $this->id= $_POST["id"];
        }

        if(isset($_POST["obj"])){
            $obj= json_decode($_POST["obj"],true);
            //Necesarias para la factura (Segun M Hacienda)
            require_once("UUID.php");
            $this->id= $obj["id"] ?? UUID::v4();
            $this->idBodega= $obj["idBodega"] ?? 0;
            $this->idUsuarioSupervisor= $obj["idUsuarioSupervisor"] ?? '';
            $this->idUsuarioCajero= $obj["idUsuarioCajero"] ?? $_SESSION["userSession"]->id;
            $this->estado= $obj["estado"] ?? '';
            $this->montoApertura= $obj["montoApertura"] ?? 0;          
            $this->montoCierre= $obj["montoCierre"] ?? 0;
            $this->totalVentasEfectivo= $obj["totalVentasEfectivo"] ?? 0;
            $this->totalVentasTarjeta= $obj["totalVentasTarjeta"] ?? 0;

        }
    }

    function ReadAll(){
        try {
            // $sql='SELECT id, idBodega, idUsuarioSupervisor, idUsuarioCajero, estado, montoApertura, 
            // montoCierre,totalVentasEfectivo, totalVentasTarjeta, fechaApertura, fechaCierre
            // FROM tropical.cajasXBodega
            // ORDER BY fechaApertura DESC;';

            $sql='SELECT ca.id, ca.idBodega, bo.nombre as nombreBodega, ca.idUsuarioSupervisor, us2.nombre as supervisor, ca.idUsuarioCajero, us.nombre as cajero, ca.estado, ca.montoApertura, 
            ca.montoCierre,ca.totalVentasEfectivo, ca.totalVentasTarjeta, ca.fechaApertura, ca.fechaCierre
            FROM tropical.cajasXBodega ca
            INNER JOIN bodega bo on ca.idBodega = bo.id
            INNER JOIN usuario us on ca.idUsuarioCajero = us.id
            INNER JOIN usuario us2 on ca.idUsuarioSupervisor = us2.id
            ORDER BY fechaApertura DESC;';
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
            // $sql='SELECT p.id, p.idUsuario, p.fecha, p.subTotal, iva, porcentajeIva, descuento, porcentajeDescuento, total, c.id as idcategoria,c.idUsuario as nombrecategoria
            //     FROM factura  p LEFT JOIN categoriasXProducto cp on cp.idProducto = p.id
            //         LEFT join categoria c on c.id = cp.idcategoria
            //     where p.id=:id';
            // $param= array(':id'=>$this->id);
            // $data= DATA::Ejecutar($sql,$param);     
            // foreach ($data as $key => $value){
            //     require_once("Categoria.php");
            //     $cat= new Categoria(); // categorias del factura
            //     if($key==0){
            //         $this->id = $value['id'];
            //         $this->idUsuario = $value['idUsuario'];
            //         $this->fecha = $value['fecha'];
            //         $this->subTotal = $value['subTotal'];
            //         $this->iva = $value['iva'];
            //         $this->porcentajeIva = $value['porcentajeIva'];
            //         $this->descuento = $value['descuento'];
            //         $this->porcentajeDescuento = $value['porcentajeDescuento'];
            //         $this->total = $value['total'];
            //         //categoria
            //         if($value['idcategoria']!=null){
            //             $cat->id = $value['idcategoria'];
            //             $cat->idusuario = $value['nombrecategoria'];
            //             array_push ($this->listaProducto, $cat);
            //         }
            //     }
            //     else {
            //         $cat->id = $value['idcategoria'];
            //         $cat->idusuario = $value['nombrecategoria'];
            //         array_push ($this->listaProducto, $cat);
            //     }
            // }
            // return $this;
        }     
        catch(Exception $e) {
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar el factura'))
            );
        }
    }

    function Create(){
        try {
            $this->idUsuarioAdmin = "1ed3a48c-3e44-11e8-9ddb-54ee75873a60"; /*** Debería ser un rol ***/
            $this->montoApertura = 0;
            $sql="INSERT INTO cajasXBodega  (id, idBodega, idUsuarioSupervisor, idusuarioCajero, estado, montoApertura, fechaApertura)
            VALUES (UUID(), :idBodega, :idUsuarioSupervisor, :idusuarioCajero, '1', :montoApertura, CURRENT_TIMESTAMP());"; 
       
            $param= array(':idBodega'=>$_SESSION["userSession"]->idBodega, ':idUsuarioSupervisor'=>$this->idUsuarioSupervisor, 
                            ':idusuarioCajero'=>$_SESSION["userSession"]->id, ':montoApertura'=>$this->montoApertura);
            $data = DATA::Ejecutar($sql,$param, false);
            if($data){
                return "aperturaCreada";
            }
            else return false;
        }     
        catch(Exception $e) {
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }

    function ValidarCierreCaja(){
        try{
            $sql = "SELECT ca.id, ca.idUsuarioSupervisor, ca.idusuarioCajero, ca.estado, bo.nombre
            FROM cajasXBodega ca
            INNER JOIN bodega bo on ca.idBodega = bo.id 
            WHERE idusuarioCajero = :idusuarioCajero and
            estado = 1;";            
            $param= array(':idusuarioCajero'=>$_SESSION["userSession"]->id);
            $data= DATA::Ejecutar($sql, $param);
            if($data){
                $sql = "Select sum(totalComprobante) as efectivo
                FROM factura
                where idMedioPago = 1 and
                fechaCreacion Between 	(
                                        SELECT ca.fechaApertura
                                        FROM cajasXBodega ca
                                        WHERE idusuarioCajero = :idusuarioCajero and
                                        estado = 1
                                        )
                and CURRENT_TIMESTAMP();";            
                $param= array(':idusuarioCajero'=>$_SESSION["userSession"]->id);
                $this->totalVentasEfectivo= DATA::Ejecutar($sql, $param);
                if($this->totalVentasEfectivo){
                    $sql = "Select sum(totalComprobante) as tarjeta
                    FROM factura
                    where idMedioPago = 2 and
                    fechaCreacion Between 	(
                                            SELECT ca.fechaApertura
                                            FROM cajasXBodega ca
                                            WHERE idusuarioCajero = :idusuarioCajero and
                                            estado = 1
                                            )
                    and CURRENT_TIMESTAMP()";            
                    $param= array(':idusuarioCajero'=>$_SESSION["userSession"]->id);
                    $this->totalVentasTarjeta= DATA::Ejecutar($sql, $param);
                    if($this->totalVentasEfectivo){
                        return $this;
                    }
                }
            }
            else return "cajaAbierta"; //false cuando existe el usuario con caja abierta
        }
        catch(Exception $e){
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }

    function cerrarCaja(){
        try {
            $sql="UPDATE tropical.cajasXBodega as ca,
            (	SELECT ca.fechaApertura
                FROM cajasXBodega ca
                WHERE idusuarioCajero = :idusuarioCajero and
                estado = 1
            ) as apertura
            
             
            SET fechaCierre= CURRENT_TIMESTAMP(), 
                estado='0',
                montoCierre = :montoCierre,
                totalVentasEfectivo = 	( 	Select sum(totalComprobante)
                                            FROM factura
                                            where idMedioPago = 1 and
                                            fechaCreacion Between apertura.fechaApertura 
                                            and CURRENT_TIMESTAMP()
                                        ),
                totalVentasTarjeta = 	(
                                            Select sum(totalComprobante)
                                            FROM factura
                                            where idMedioPago = 2 and
                                            fechaCreacion Between apertura.fechaApertura 
                                            and CURRENT_TIMESTAMP()
                                        )
            WHERE idusuarioCajero = :idusuarioCajero and
            estado ='1';";

            $param= array(':idusuarioCajero'=>$_SESSION["userSession"]->id, 'montoCierre'=>$this->montoCierre);
            $data = DATA::Ejecutar($sql,$param,false);
            if($data){
                return true;
            }
        }     
        catch(Exception $e) {
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }   

    function ValidarEstado(){
        try{
            // Inicia sesión de API.
            $cliente= new ClienteFE();
            $cliente->ReadProfile();
            //
            $this->idusuarioCajero="1ed3a48c-3e44-11e8-9ddb-54ee75873a60";
            $sql = "SELECT ca.id, ca.idUsuarioSupervisor, ca.idusuarioCajero, ca.estado, bo.nombre
            FROM cajasXBodega ca
            INNER JOIN bodega bo on ca.idBodega = bo.id 
            WHERE idusuarioCajero = :idusuarioCajero and
            estado = 1;";            
            $param= array(':idusuarioCajero'=>$this->idusuarioCajero);
            $data= DATA::Ejecutar($sql, $param);
            if(!$data){
                // $this->Create();
                return "cajaCerrada";
            }
            else return "cajaAbierta"; //false cuando existe el usuario con caja abierta
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
            // $sql='DELETE FROM factura  
            //     WHERE id= :id';
            // $param= array(':id'=>$this->id);
            // $data= DATA::Ejecutar($sql, $param, false);
            // if($data){
            //     $sessiondata['status']=0; 
            //     return $sessiondata;
            // }
            // else throw new Exception('Error al eliminar.', 978);
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