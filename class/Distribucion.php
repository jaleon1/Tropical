<?php
error_reporting(E_ALL);
ini_set('display_errors', 0);

if(isset($_POST["action"])){
    $opt= $_POST["action"];
    unset($_POST['action']);
    // Classes
    require_once("Conexion.php");
    require_once("Usuario.php");
    require_once("ProductosXDistribucion.php");
    require_once('Factura.php');
    require_once('Receptor.php');
    require_once('facturacionElectronica.php');
    require_once('InventarioInsumoXBodega.php');
    require_once("Bodega.php");
    require_once("ClienteFE.php");
    require_once("encdes.php");
    require_once("InventarioProducto.php");
    require_once("InventarioInsumoXBodega.php");
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
            $distribucion->idBodega= $_SESSION["userSession"]->idBodega;
            $distribucion->orden= $_POST["orden"];
            echo json_encode($distribucion->ReadbyOrden());
            break;
        case "Create":
            if(!$distribucion->esInterna){
                if($distribucion->datosReceptor == null){
                    echo json_encode("NORECEPTOR");
                    return false;
                }
                if($distribucion->datosEntidad == null){
                    echo json_encode("NOCONTRIB");
                    return false;
                }
            }
            echo json_encode($distribucion->Create());
            break;
        case "Update":
            $distribucion->Update();
            break;
        case "Delete":
            $distribucion->orden= $_POST["orden"];
            $distribucion->Delete();
            break;  
        case "Aceptar":
            $distribucion->Aceptar();
            break;   
        case "ReadAllbyRange":
            echo json_encode($distribucion->ReadAllbyRange());
            break;
        case "ReadCancelada":
            echo json_encode($distribucion->ReadCancelada());
            break;
    }
}

class Distribucion{
    public $id=null;
    public $fecha='';
    public $idBodega=null;
    public $bodega=null;
    public $orden='';
    public $idUsuario=null;
    public $porcentajeDescuento=0;
    public $porcentajeIva=null;
    public $esInterna=true;
    public $lista= [];
    // para comprobante externo.
    public $detalleFactura= []; 
    public $datosReceptor = [];
    public $datosEntidad = [];
    public $fechaInicial='';
    public $fechaFinal='';

    function __construct(){
        // identificador único
        if(isset($_POST["id"])){
            $this->id= $_POST["id"];
        }
        if(isset($_POST["obj"])){
            $obj= json_decode($_POST["obj"],true);
            unset($_POST['obj']);
            require_once("UUID.php");
            $this->id= $obj["id"] ?? UUID::v4();
            $this->idBodega= $obj["idBodega"];
            $this->orden= $obj["orden"] ?? '';
            // $this->porcentajeDescuento= $obj["porcentajeDescuento"] ?? 0;
            $this->porcentajeIva= $obj["porcentajeIva"] ?? '13';
            //$this->idUsuario= $obj["idUsuario"] ?? null;
            // comprobante electronico para bodega externa.
            $this->fechaCreacion= $obj["fechaCreacion"] ?? null;  //  fecha de creacion en base de datos.
            //$this->idEntidad= $obj["idEntidad"] ?? $_SESSION["userSession"]->idEntidad;            
            $this->consecutivo= $this->orden;
            $this->local= '001';//$obj["local"] ?? $_SESSION["userSession"]->local;
            $this->terminal= '00001'; //$obj["terminal"] ?? $_SESSION["userSession"]->terminal;
            $this->idCondicionVenta= 1;
            $this->idSituacionComprobante= 1;
            $this->idEstadoComprobante= 1;
            $this->plazoCredito= 0;
            $this->idMedioPago= 1;
            // c. Resumen de la factura/Total de la Factura 
            // definir si es servicio o mercancia (producto).
            $this->idCodigoMoneda= 55; // CRC
            $this->tipoCambio= 595.00; // tipo de cambio dinamico con BCCR
            $this->totalServGravados= $obj['totalServGravados'];
            $this->totalServExentos= $obj['totalServExentos'];
            $this->totalMercanciasGravadas= $obj['totalMercanciasGravadas'];
            $this->totalMercanciasExentas= $obj['totalMercanciasExentas'];
            $this->totalGravado= $obj['totalGravado'];
            $this->totalExento= $obj['totalExento'];
            $this->totalVenta= $obj["totalVenta"];
            $this->totalDescuentos= $obj["totalDescuentos"];
            $this->totalVentaneta= $obj["totalVentaneta"];
            $this->totalImpuesto= $obj["totalImpuesto"];
            $this->totalComprobante= $obj["totalComprobante"];
            // $this->montoEfectivo= $obj["montoEfectivo"]; //Jason: Lo comente temporalmente
            // $this->montoTarjeta= $obj["montoTarjeta"];   //Jason: Lo comente temporalmente
            // d. Informacion de referencia
            $this->idDocumento = 1; // Documento de Referencia.            
            $this->fechaEmision= $obj["fechaEmision"] ?? null; // emision del comprobante electronico.
            //
            $this->idReceptor = $obj['idReceptor'] ?? Receptor::default()->id; // si es null, utiliza el Receptor por defecto.            
            $this->idUsuario=  $_SESSION["userSession"]->id;
            $this->fechaInicial= $obj["fechaInicial"] ?? null;
            $this->fechaFinal= $obj["fechaFinal"] ?? null;
            // si la bodega es externa, tiene que estar el ClienteFE (receptor) registrado.
            $central = new Bodega();
            $central->readCentral();
            $this->idEmisor =  $central->id;
            $externa = new Bodega();
            $externa->ReadbyId($obj["idBodega"]); // bodega receptor.
            if($externa->tipo != $central->tipo){
                $this->esInterna= false;
                // receptor
                $receptor = new ClienteFE();
                $receptor->idBodega = $this->idReceptor;
                $this->datosReceptor = $receptor->read();
                // emisor - Central.
                $entidad = new ClienteFE();
                $entidad->idBodega = $central->id;
                $this->datosEntidad = $entidad->read();
            }
            //
            // lista.
            if(isset($obj["lista"] )){
                require_once("ProductosXDistribucion.php");
                require_once("productoXFactura.php");
                //
                foreach ($obj["lista"] as $itemlist) {
                    $item= new ProductosXDistribucion();
                    $item->idDistribucion= $this->id;
                    $item->idProducto= $itemlist['idProducto'];                    
                    $item->cantidad= $itemlist['cantidad'];
                    $item->valor= $itemlist['valor'];
                    array_push ($this->lista, $item);
                    // b. Detalle de la mercancía o servicio prestado
                    $item= new ProductoXFactura();
                    $item->idFactura = $this->id;
                    //$item->idPrecio= $itemlist['idPrecio'];
                    $item->numeroLinea= $itemlist['numeroLinea'];
                    $item->idTipoCodigo= $itemlist['idTipoCodigo']?? 1;
                    $item->codigo= $itemlist['codigo'] ?? 999;
                    $item->cantidad= $itemlist['cantidad'] ?? 1;
                    $item->idUnidadMedida= $itemlist['idUnidadMedida'] ?? 78;
                    $item->detalle= $itemlist['detalle'];
                    $item->precioUnitario= $itemlist['precioUnitario'];                    
                    $item->montoTotal= $itemlist['montoTotal'];
                    $item->montoDescuento= $itemlist['montoDescuento'];
                    $item->naturalezaDescuento= $itemlist['naturalezaDescuento']??'No aplican descuentos'; // en Tropical no se manejan descuentos
                    $item->subTotal= $itemlist['subTotal'];
                    $item->idExoneracionImpuesto= $itemlist['idExoneracionImpuesto'] ?? null;
                    $item->codigoImpuesto= $itemlist['codigoImpuesto'] ?? 1; // impuesto ventas = 1
                    $item->tarifaImpuesto= $itemlist['tarifaImpuesto'];
                    $item->montoImpuesto= $itemlist['montoImpuesto'];                    
                    $item->montoTotalLinea= $itemlist['montoTotalLinea']; // subtotal + impuesto.
                    array_push ($this->detalleFactura, $item);
                }
            }
        }
    }

    function ReadAll(){
        try {
            // $sql='SELECT id, fecha, idBodega, orden, idUsuario
            //     FROM     distribucion       
            //     ORDER BY fecha asc';
            $sql= 'SELECT d.id, fecha, orden, u.userName, b.nombre as bodega, e.nombre as estado, 
                    (sum(cantidad*valor) + sum(cantidad*valor)*0.13) as total, idEstadoComprobante
                FROM tropical.distribucion d
                    INNER JOIN usuario u on u.id=d.idUsuario
                    INNER JOIN bodega b on b.id=d.idBodega
                    INNER JOIN estado e on e.id=d.idEstado
                    INNER JOIN productosXDistribucion p on p.idDistribucion=d.id
                GROUP BY orden
                ORDER BY fecha desc';
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

    function ReadAllbyRange(){
        try {
            // $sql='SELECT id, fecha, idBodega, orden, idUsuario
            //     FROM     distribucion       
            //     ORDER BY fecha asc';
            $sql= 'SELECT d.id, fecha, orden, u.userName, b.nombre as bodega, e.nombre as estado, d.idEstadocomprobante, d.claveNC,
                    (sum(cantidad*valor) + sum(cantidad*valor)*0.13) as total, idEstadoComprobante, t.nombre as tipoBodega
                FROM tropical.distribucion d
                    INNER JOIN usuario u on u.id=d.idUsuario
                    INNER JOIN bodega b on b.id=d.idBodega
                    INNER JOIN tipoBodega t on t.id=b.idTipoBodega 
                    INNER JOIN estado e on e.id=d.idEstado
                    INNER JOIN productosXDistribucion p on p.idDistribucion=d.id
                WHERE fecha Between :fechaInicial and :fechaFinal
                GROUP BY orden
                ORDER BY fecha desc';
            $param= array(':fechaInicial'=>$this->fechaInicial, ':fechaFinal'=>$this->fechaFinal);            
            $data= DATA::Ejecutar($sql, $param);
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
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar el distribucion'))
            );
        }
    }

    function Read(){
        try {
            $sql='SELECT d.id, d.fecha, d.orden, clave, d.idUsuario, d.idBodega, b.nombre as bodega, d.porcentajeDescuento, d.porcentajeIva,  (sum(cantidad*valor) + sum(cantidad*valor)*0.13) as total
                FROM distribucion d
                INNER JOIN bodega b on b.id=d.idBodega
                INNER JOIN productosXDistribucion p on p.idDistribucion=d.id
                where d.id=:id';
            $param= array(':id'=>$this->id);
            $data= DATA::Ejecutar($sql,$param);     
            if(count($data)){
                $this->id = $data[0]['id'];
                $this->fecha = $data[0]['fecha'];
                $this->orden = $data[0]['orden'];
                $this->clave = $data[0]['clave'];
                $this->idUsuario = $data[0]['idUsuario'];
                $this->idBodega = $data[0]['idBodega'];
                $this->bodega = $data[0]['bodega'];
                $this->porcentajeDescuento = $data[0]['porcentajeDescuento'];
                $this->porcentajeIva = $data[0]['porcentajeIva'];
                $this->total = $data[0]['total'];
                // productos x distribucion.
                $this->lista= ProductosXDistribucion::Read($this->id);
                //
                return $this;
            }
            else return null;
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar el distribucion'))
            );
        }
    }

    function ReadCancelada(){
        try {
            $sql='SELECT d.id, fecha, orden, u.userName, b.nombre as bodega, e.nombre as estado, d.idEstadocomprobante, d.claveNC,
                (sum(cantidad*valor) + sum(cantidad*valor)*0.13) as total, idEstadoComprobante, t.nombre as tipoBodega
            FROM tropical.distribucion d
                INNER JOIN usuario u on u.id=d.idUsuario
                INNER JOIN bodega b on b.id=d.idBodega
                INNER JOIN tipoBodega t on t.id=b.idTipoBodega 
                INNER JOIN estado e on e.id=d.idEstado
                INNER JOIN productosXDistribucion p on p.idDistribucion=d.id
            WHERE fecha Between :fechaInicial 
            AND :fechaFinal
            AND d.claveNC IS NULL
            AND t.nombre="Externa"
            GROUP BY orden
            ORDER BY fecha desc';

            $param= array(':fechaInicial'=>$this->fechaInicial, ':fechaFinal'=>$this->fechaFinal);
            $data = DATA::Ejecutar($sql,$param);
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
                    // si es una bodega interna, acepta la distribución. Si es externa, crea el comprobante electrónico.
                    $sql="SELECT t.nombre
                        FROM tropical.bodega b
                        INNER JOIN tipoBodega t on t.id = b.idTipoBodega
                        WHERE b.id=:idBodega and t.nombre= 'Interna' ";
                    $param= array(':idBodega'=>$this->idBodega);
                    $data = DATA::Ejecutar($sql,$param);
                    if(count($data)){
                        $this->Read();
                        $this->Aceptar();
                        // retorna orden autogenerada.
                        return $this;
                    }
                    else{ // es externa. Crea comprobante.
                        
                        $objFactura = $this->Read();
                        $objFactura->consecutivo= $this->orden;
                        FacturacionElectronica::$distr= true;
                        FacturacionElectronica::iniciar($objFactura);
                        // retorna orden autogenerada.
                        return $this;
                    }
                }
                else throw new Exception('Error al guardar los productos.', 03);
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

    function Aceptar(){
        try {
            $created=true;
            if(!isset($this->orden))
                $this->Read();
            foreach ($this->lista as $item) {
                if(InventarioInsumoXBodega::entrada($item->idProducto, $this->idBodega, 'Distribución#'.$this->orden, $item->cantidad, $item->precioVenta)){
                     // set idEstado = true.
                     $sql="UPDATE distribucion
                     SET idEstado=1, fechaAceptacion= NOW()
                     WHERE id=:id";
                 $param= array(':id'=> $this->id);
                 $data = DATA::Ejecutar($sql,$param,false);
                 if(!$data)
                     $created= false;
                }
                else $created= false;
            }
            if($created)
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
            // recorre insumos y reversa.
            $sql='SELECT idProducto, cantidad, valor, idBodega 
                FROM productosXDistribucion x INNER JOIN distribucion d on d.id = x.idDistribucion
                WHERE idDistribucion= :id';
            $param= array(':id'=>$this->id);
            $data= DATA::Ejecutar($sql, $param);
            if($data){
                // ROLLBACK.
                foreach ($data as $key => $value){
                    InventarioProducto::entrada( $value['idProducto'], $this->id, $value['cantidad'], $value['valor']);
                    // busca el id del insumo en la agencia.
                    $sql='SELECT id
                        FROM insumosXBodega  
                        WHERE idProducto= :idProducto and idBodega =:idBodega';
                    $param= array(':idProducto'=>$value['idProducto'], ':idBodega'=>$value['idBodega']);
                    $insumo= DATA::Ejecutar($sql, $param);
                    if($data){
                        // porcion del insumo de la agencia.
                        // busca si es artículo o producto (TOPPING - SABOR).
                        $sql='SELECT esVenta
                        FROM insumosXBodega x INNER JOIN producto p 
                        WHERE p.id= :idProducto';
                        $param= array(':idProducto'=>$value['idProducto']);
                        $porcion= DATA::Ejecutar($sql, $param);
                        //
                        if ($porcion[0]['esVenta']==0){        // artículo.
                            $porcion= 1;
                        }
                        else if ($porcion[0]['esVenta']==1){   // botella de sabor.
                            $porcion= 20;
                        }
                        else if ($porcion[0]['esVenta']==2){   // topping.
                            $porcion= 40;
                        }
                        InventarioInsumoXBodega::salida($insumo[0]['id'], $value['idBodega'], 'Reversa Distribucion: '. $this->orden, floatval($value['cantidad']*$porcion));
                    }                    
                }
            }
            $sql='UPDATE distribucion  
                set razon =:razon, idEstado=2
                WHERE id= :id';
            $param= array(':id'=>$this->id, ':razon'=> 'Reversa Orden Distribucion: ' . $this->orden);
            $data= DATA::Ejecutar($sql, $param, false);
            if($data)
                return true; 
            else throw new Exception('Error al eliminar la orden de compra. Los insumos SI fueron eliminados.', 978);
        }
        catch(Exception $e) { 
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
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

    public static function setClave($documento, $idDistr, $clave, $consecutivoFE=null){
        try {
            $sql='';
            $param= [];
            switch($documento){
                case 1: //fe
                case 4: //te
                case 8: //contingencia
                    $sql="UPDATE distribucion
                        SET clave=:clave, consecutivoFE=:consecutivoFE
                        WHERE id=:idDistr";
                    $param= array(':idDistr'=>$idDistr, ':clave'=>$clave, ':consecutivoFE'=>$consecutivoFE);
                break;
                case 3: // NC
                    $sql="UPDATE distribucion
                        SET claveNC=:claveNC
                        WHERE id=:idDistr";
                    $param= array(':idDistr'=>$idDistr, ':claveNC'=>$clave);
                break;
            }
            //
            $data = DATA::Ejecutar($sql,$param, false);
            if($data)
                return true;
            else throw new Exception('Error al guardar el histórico Distr.', 555);
        }     
        catch(Exception $e) {
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            // debe notificar que no se esta actualizando el historico de comprobantes.
        }
    }

    public static function updateEstado($documento, $idDistr, $idEstadoComprobante, $fechaEmision){
        try {
            $sql='';
            $param= [];
            switch($documento){
                case 1: //fe
                case 4: //te
                case 8: //contingencia                
                    $sql="UPDATE distribucion
                        SET idEstadoComprobante=:idEstadoComprobante, fechaEmision=:fechaEmision
                        WHERE id=:idDistr";
                    $param= array(':idDistr'=>$idDistr, ':idEstadoComprobante'=>$idEstadoComprobante, ':fechaEmision'=>$fechaEmision);
                break;
                case 3: // NC
                    $sql="UPDATE distribucion
                        SET idEstadoNC=:idEstadoNC, fechaEmisionNC=:fechaEmisionNC
                        WHERE id=:idDistr";
                    $param= array(':idDistr'=>$idDistr, ':idEstadoNC'=>$idEstadoComprobante, ':fechaEmisionNC'=>$fechaEmision);
                break;
            }
            //
            $data = DATA::Ejecutar($sql,$param, false);
            if($data)
                return true;
            else throw new Exception('Error al guardar el histórico distr.', 556);
        }     
        catch(Exception $e) {
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            // debe notificar que no se esta actualizando el historico de comprobantes.
        }
    }

    public static function updateIdEstadoComprobante($idDistr, $documento, $idEstadoComprobante){
        try {
            $sql='';
            $param= [];
            switch($documento){
                case 1: //fe
                case 4: //te
                case 8: //contingencia                
                    $sql="UPDATE distribucion
                        SET idEstadoComprobante=:idEstadoComprobante
                        WHERE id=:idDistr";
                    $param= array(':idDistr'=>$idDistr, ':idEstadoComprobante'=>$idEstadoComprobante);
                break;
                case 3: // NC
                    $sql="UPDATE distribucion
                        SET idEstadoNC=:idEstadoNC
                        WHERE id=:idDistr";
                    $param= array(':idDistr'=>$idDistr, ':idEstadoNC'=>$idEstadoComprobante);
                break;
            }
            //
            $data = DATA::Ejecutar($sql,$param, false);
            if($data)
                return true;
            else throw new Exception('Error al actualizar el estado del comprobante.', 0456);            
        }     
        catch(Exception $e) {
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            // debe notificar que no se esta actualizando el historico de comprobantes.
        }
    }
}


/*$sql="SELECT id
                            FROM clienteFE
                            WHERE idBodega = :idBodega";
                        $param= array(':idBodega'=>$this->idBodega);
                        $data = DATA::Ejecutar($sql,$param);
                        
                        if($data){                            
                            $this->idReceptor=$data[0]["id"];
                            $sql="SELECT id
                                FROM receptor
                                WHERE id = :id";
                            $param= array(':id'=>$this->idReceptor);
                            $data = DATA::Ejecutar($sql,$param);
                            if($data){
                                $this->idReceptor=$data[0]["id"];                            
                            }else{
                                //Trae los datos de ClienteFE para crear el Receptor
                                $sql="SELECT id, nombre, idTipoIdentificacion, identificacion, 
                                nombreComercial, idProvincia, idCanton, idDistrito, idBarrio, 
                                otrasSenas, idCodigoPaisTel, numTelefono, correoElectronico 
                                FROM tropical.clienteFE
                                WHERE id = :id";
                                $param= array(':id'=>$this->idReceptor);
                                $data = DATA::Ejecutar($sql,$param);

                                $receptor = new stdClass();
                                $receptor->id = $data[0]["id"];
                                $receptor->nombre = $data[0]["nombre"];
                                $receptor->idTipoIdentificacion = $data[0]["idTipoIdentificacion"];
                                $receptor->identificacion = $data[0]["identificacion"];
                                $receptor->nombreComercial = $data[0]["nombreComercial"];
                                $receptor->idProvincia = $data[0]["idProvincia"];
                                $receptor->idCanton = $data[0]["idCanton"];
                                $receptor->idDistrito = $data[0]["idDistrito"];
                                $receptor->idBarrio = $data[0]["idBarrio"];
                                $receptor->otrasSenas = $data[0]["otrasSenas"];
                                $receptor->idCodigoPaisTel = $data[0]["idCodigoPaisTel"];
                                $receptor->numTelefono = $data[0]["numTelefono"];
                                $receptor->correoElectronico = $data[0]["correoElectronico"];

                                $sql="INSERT INTO receptor (id, nombre, idTipoIdentificacion, identificacion, identificacionExtranjero, 
                                    nombreComercial, idProvincia, idCanton, idDistrito, idBarrio, 
                                    otrasSenas, idCodigoPaisTel, numTelefono, correoElectronico)
                                    VALUES (:id, :nombre, :idTipoIdentificacion, :identificacion, null, 
                                    :nombreComercial, :idProvincia, :idCanton, :idDistrito, :idBarrio, :otrasSenas, 
                                    :idCodigoPaisTel, :numTelefono, :correoElectronico)";
                                $param= array(
                                    ':id'=>$receptor->id, 
                                    ':nombre'=>$receptor->nombre, 
                                    ':idTipoIdentificacion'=>$receptor->idTipoIdentificacion,
                                    ':identificacion'=>$receptor->identificacion,
                                    ':nombreComercial'=>$receptor->nombreComercial,
                                    ':idProvincia'=>$receptor->idProvincia,
                                    ':idCanton'=>$receptor->idCanton,
                                    ':idDistrito'=>$receptor->idDistrito,
                                    ':idBarrio'=>$receptor->idBarrio,
                                    ':otrasSenas'=>$receptor->otrasSenas,
                                    ':idCodigoPaisTel'=>$receptor->idCodigoPaisTel,
                                    ':numTelefono'=>$receptor->numTelefono,
                                    ':correoElectronico'=>$receptor->correoElectronico
                                );
                                $data = DATA::Ejecutar($sql,$param);
                            }

                        }
                        $this->crearFactura();
                        
                        
                        
    function crearFactura(){
        try {
            $sql="INSERT INTO factura   (id, idBodega, local, terminal, idCondicionVenta, idSituacionComprobante, idEstadoComprobante, plazoCredito, 
                idMedioPago, idCodigoMoneda, tipoCambio, totalServGravados, totalServExentos, totalMercanciasGravadas, totalMercanciasExentas, totalGravado, totalExento, idDocumento, 
                totalVenta, totalDescuentos, totalVentaneta, totalImpuesto, totalComprobante, idReceptor, idEmisor, idUsuario)
            VALUES  (:uuid, :idBodega, :local, :terminal, :idCondicionVenta, :idSituacionComprobante, :idEstadoComprobante, :plazoCredito,
                :idMedioPago, :idCodigoMoneda, :tipoCambio, :totalServGravados, :totalServExentos, :totalMercanciasGravadas, :totalMercanciasExentas, :totalGravado, :totalExento, :idDocumento, 
                :totalVenta, :totalDescuentos, :totalVentaneta, :totalImpuesto, :totalComprobante, :idReceptor, :idEmisor, :idUsuario)";
            $param= array(':uuid'=>$this->id,
                ':idBodega'=>$this->idBodega,
                ':local'=>$this->local,
                ':terminal'=>$this->terminal,
                ':idCondicionVenta'=>$this->idCondicionVenta,
                ':idSituacionComprobante'=>$this->idSituacionComprobante,
                ':idEstadoComprobante'=>$this->idEstadoComprobante,
                ':plazoCredito'=> $this->plazoCredito,                    
                ':idMedioPago'=>$this->idMedioPago,
                ':idCodigoMoneda'=>$this->idCodigoMoneda,
                ':tipoCambio'=>$this->tipoCambio,
                ':totalServGravados'=> $this->totalServGravados,
                ':totalServExentos'=> $this->totalServExentos,
                ':totalMercanciasGravadas'=> $this->totalMercanciasGravadas,
                ':totalMercanciasExentas'=> $this->totalMercanciasExentas,
                ':totalGravado'=> $this->totalGravado,
                ':totalExento'=> $this->totalExento,
                ':idDocumento'=> $this->idDocumento,
                ':totalVenta'=>$this->totalVenta,
                ':totalDescuentos'=>$this->totalDescuentos,
                ':totalVentaneta'=>$this->totalVentaneta,
                ':totalImpuesto'=>$this->totalImpuesto,
                ':totalComprobante'=>$this->totalComprobante,
                ':idReceptor'=>$this->idReceptor,
                ':idEmisor'=>$this->idEmisor,
                ':idUsuario'=>$this->idUsuario);
            $data = DATA::Ejecutar($sql,$param, false);
            if($data)
            {
                //save array obj
                if(ProductoXFactura::Create($this->detalleFactura)){
                    // $this->actualizaInventario($this->detalleOrden);
                    // orden de factura para mostrar en despacho.
                    // OrdenXFactura::$id=$this->id;
                    // OrdenXFactura::Create($this->detalleOrden);
                    // envio de comprobantes en tiempo real.
                    // $this->enviarDocumentoElectronico();         
                    return $this;
                }
                else throw new Exception('[ERROR] al guardar los productos.', 03);
            }
            else throw new Exception('[ERROR] al guardar.', 02);
        }     
        catch(Exception $e) {
            error_log("[ERROR]: ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }

    }
    */
?>


