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
    $producto= new Producto();
    switch($opt){
        case "ReadAll":
            echo json_encode($producto->ReadAll());
            break;
        case "Read":
            echo json_encode($producto->Read());
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
    }
}

class Producto{
    public $id=null;
    public $codigo='';
    public $nombre='';
    public $txtcolor='';
    public $bgcolor='';
    public $nombreabreviado='';
    public $descripcion='';
    public $saldocantidad='';
    public $saldocosto='';
    public $costopromedio='';
    public $precioventa='';
    public $esventa=0;

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
            $this->txtcolor= $obj["txtcolor"] ?? '';
            $this->bgcolor= $obj["bgcolor"] ?? '';
            $this->nombreabreviado= $obj["nombreabreviado"] ?? '';
            $this->descripcion= $obj["descripcion"] ?? '';
            $this->saldocantidad= $obj["saldocantidad"] ?? '';
            $this->saldocosto= $obj["saldocosto"] ?? '';
            $this->costopromedio= $obj["costopromedio"] ?? '';
            $this->precioventa= $obj["precioventa"] ?? '';
            $this->esventa= $obj["esventa"] ?? 0;
        }
    }

    function ReadAll(){
        try {
            $sql='SELECT id, codigo, nombre, txtcolor, bgcolor, nombreabreviado, descripcion, saldocantidad, saldocosto, costopromedio, precioventa, esventa
                FROM     producto       
                ORDER BY codigo asc';
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
  
    function ReadAllPrdVenta(){
        try {
            $sql='SELECT id, codigo, nombre, txtcolor, bgcolor, nombreabreviado, descripcion, saldocantidad, saldocosto, costopromedio, precioventa, esventa
                FROM     producto       
                WHERE esventa=1
                ORDER BY codigo asc';
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
            $sql='SELECT id, codigo, nombre, txtcolor, bgcolor, nombreabreviado, descripcion, saldocantidad, saldocosto, costopromedio, precioventa,esventa
                FROM producto  
                where id=:id';
            $param= array(':id'=>$this->id);
            $data= DATA::Ejecutar($sql,$param);
            return $data;
        }     
        catch(Exception $e) {
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar el producto'))
            );
        }
    }

    function ReadArticulo(){
        try {
            $sql='SELECT id, nombre, codigo, descripcion, saldocosto, costopromedio, precioventa, esventa
                FROM producto  
                where id=:id and esventa=0';
            $param= array(':id'=>$this->id);
            $data= DATA::Ejecutar($sql,$param);
            return $data;
        }     
        catch(Exception $e) {
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar el producto'))
            );
        }
    }

    function ReadArticuloByCode(){
        try {
            $sql='SELECT id, nombre, codigo, descripcion, saldocosto, costopromedio, precioventa, esventa
                FROM producto  
                where codigo=:codigo and esventa=0';
            $param= array(':codigo'=>$this->codigo);
            $data= DATA::Ejecutar($sql,$param);
            return $data;
        }     
        catch(Exception $e) {
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar el producto'))
            );
        }
    }

    function Create(){
        try {
            // $this->txtcolor = "010203";
            // $this->bgcolor = "040506";
            $sql="INSERT INTO tropical.producto   (id, nombre, codigo, txtcolor, bgcolor, nombreabreviado, descripcion, saldocantidad, saldocosto, costopromedio, precioventa, esventa) 
            VALUES (uuid(), :nombre, :codigo ,:txtcolor, :bgcolor, :nombreabreviado, :descripcion, :saldocantidad, :saldocosto, :costopromedio ,:precioventa, :esventa);";
            //
            $param= array(':nombre'=>$this->nombre, 
            ':codigo'=>$this->codigo,
            ':txtcolor'=>$this->txtcolor,
            ':bgcolor'=>$this->bgcolor,
            ':nombreabreviado'=>$this->nombreabreviado,
            ':descripcion'=>$this->descripcion,
            ':saldocantidad'=>$this->saldocantidad,
            ':saldocosto'=>$this->saldocosto,
            ':costopromedio'=>$this->costopromedio,
            ':precioventa'=>$this->precioventa, 
            ':esventa'=>$this->esventa);

            $data = DATA::Ejecutar($sql,$param, false);
            if($data)
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
            $sql="UPDATE producto 
                SET codigo=:codigo, nombre=:nombre, txtcolor=:txtcolor, bgcolor=:bgcolor, nombreabreviado=:nombreabreviado, descripcion=:descripcion, saldocantidad=:saldocantidad, saldocosto=:saldocosto, costopromedio=:costopromedio, precioventa=:precioventa, esventa=:esventa
                WHERE id=:id";
            $param= array(':id'=>$this->id, ':codigo'=>$this->codigo, ':nombre'=>$this->nombre, ':txtcolor'=>$this->txtcolor,':bgcolor'=>$this->bgcolor,':nombreabreviado'=>$this->nombreabreviado,':descripcion'=>$this->descripcion,':saldocantidad'=>$this->saldocantidad,':saldocosto'=>$this->saldocosto,':costopromedio'=>$this->costopromedio,':precioventa'=>$this->precioventa, ':esventa'=>$this->esventa);
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
    
    // function UpdateCantidad(){
    //     try {
    //         /*

    //         INSERTAR CANTIDAD PRODUCTO BODEGA PRINCIPAL

    //         $param= array(':id'=>$_POST["idproducto"]);
    //         $sql="SELECT cantidad FROM productosxbodega WHERE idproducto=:id";
    //         $data=DATA::Ejecutar($sql,$param);
    //         $cantidad = $data[0][0] + $_POST["cantidad"];
            
    //         $sql="UPDATE producto SET cantidad=:cantidad WHERE id=:id";
    //         $param= array(':id'=>$_POST["idproducto"], ':cantidad'=>$cantidad);
    //         $data = DATA::Ejecutar($sql,$param,false);
    //         */
            
    //         $sql="UPDATE productotemporal SET estado=1 WHERE id=:id";
    //         $param= array(':id'=>$_POST["id"]);
    //         $data = DATA::Ejecutar($sql,$param,false);

    //         if($data)
    //             return true;
    //         else throw new Exception('Error al guardar.', 123);
    //     }     
    //     catch(Exception $e) {
    //         header('HTTP/1.0 400 Bad error');
    //         die(json_encode(array(
    //             'code' => $e->getCode() ,
    //             'msg' => $e->getMessage()))
    //         );
    //     }
    // }

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
            $sql='DELETE FROM producto  
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
            $sql="SELECT id, nombre, codigo, descripcion, saldocosto, costopromedio, precioventa, esventa
                FROM producto 
                WHERE codigo= :codigo";
            $param= array(':codigo'=>$this->codigo);

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

    public static function UpdateSaldoPromedioSalida($id, $ncantidad){
        try {
            $sql="CALL spUpdateSaldosPromedioProductoSalida(:mid, :ncantidad);";
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

}



?>