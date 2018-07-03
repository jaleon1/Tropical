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
    $factura= new Factura();
    switch($opt){
        case "ReadAll":
            echo json_encode($factura->ReadAll());
            break;
        case "Read":
            echo json_encode($factura->Read());
            break;
        case "Create":
            $factura->Create();
            break;
        case "Update":
            $factura->Update();
            break;
        case "Delete":
            echo json_encode($factura->Delete());
            break;   
    }
}

class Factura{
    public $id=null;
    public $idUsuario=null;
    public $fecha=null;
    //
    public $subTotal=0;    
    public $iva=0;
    public $porcentajeIva=0;
    public $descuento=0;
    public $porcentajeDescuento=0;
    public $total=0;
    //
    public $tipoPago='';
    public $pagaCon=0;
    public $vuelto=0;
    //
    // public $listaproducto= array();
    
    function __construct(){
        // identificador único
        if(isset($_POST["id"])){
            $this->id= $_POST["id"];
        }
        if(isset($_POST["obj"])){
            $obj= json_decode($_POST["obj"],true);
            require_once("UUID.php");
            $this->id= $obj["id"] ?? UUID::v4();
            $this->idUsuario= $obj["idUsuario"] ?? '';
            $this->idcliente= $obj["idcliente"] ?? '';
            $this->fecha= $obj["fecha"] ?? '';
            $this->producto= $obj["producto"] ?? 0;          
            $this->impventas= $obj["impuesto"] ?? '';
            $this->descuento= $obj["descuento"] ?? '';            
            // $this->subTotal= $obj["subTotal"] ?? ''; 
            // $this->iva= $obj["iva"] ?? 0;            
            // $this->porcentajeIva= $obj["porcentajeIva"] ?? 0;
            // $this->porcentajeDescuento= $obj["porcentajeDescuento"] ?? 0;            
            // $this->total= $obj["total"] ?? null;
            // Categorias del factura.
            // if(isset($obj["listaproducto"] )){
            //     require_once("ProductosXFactura.php");
            //     //
            //     foreach ($obj["listaproducto"] as $idprod) {
            //         $prodfact= new ProductosXFactura();
            //         $prodfact->idcategoria= $idprod;
            //         $prodfact->idProducto= $this->id;
            //         array_push ($this->listaproducto, $prodfact);
            //     }
            // }
        }
    }

    function ReadAll(){
        try {
            $sql='SELECT id, idUsuario, fecha, descuento, iva, porcentajeIva , porcentajeDescuento
                FROM     factura       
                ORDER BY idUsuario asc';
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
            $sql='SELECT p.id, p.idUsuario, p.fecha, p.subTotal, iva, porcentajeIva, descuento, porcentajeDescuento, total, c.id as idcategoria,c.idUsuario as nombrecategoria
                FROM factura  p LEFT JOIN categoriasXProducto cp on cp.idProducto = p.id
                    LEFT join categoria c on c.id = cp.idcategoria
                where p.id=:id';
            $param= array(':id'=>$this->id);
            $data= DATA::Ejecutar($sql,$param);     
            foreach ($data as $key => $value){
                require_once("Categoria.php");
                $cat= new Categoria(); // categorias del factura
                if($key==0){
                    $this->id = $value['id'];
                    $this->idUsuario = $value['idUsuario'];
                    $this->fecha = $value['fecha'];
                    $this->subTotal = $value['subTotal'];
                    $this->iva = $value['iva'];
                    $this->porcentajeIva = $value['porcentajeIva'];
                    $this->descuento = $value['descuento'];
                    $this->porcentajeDescuento = $value['porcentajeDescuento'];
                    $this->total = $value['total'];
                    //categoria
                    if($value['idcategoria']!=null){
                        $cat->id = $value['idcategoria'];
                        $cat->idUsuario = $value['nombrecategoria'];
                        array_push ($this->listaproducto, $cat);
                    }
                }
                else {
                    $cat->id = $value['idcategoria'];
                    $cat->idUsuario = $value['nombrecategoria'];
                    array_push ($this->listaproducto, $cat);
                }
            }
            return $this;
        }     
        catch(Exception $e) {
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar el factura'))
            );
        }
    }
/////////////////////////////////////////////
// function Insert(){
//     try {
//         $sql="INSERT INTO factura   (id, usuario, fecha, impventas, cliente, descuento)
//             VALUES (uuid(), :usuario, :fecha, :impventas, :cliente, :descuento)"; 
//         $param= array(':usuario'=>$this->usuario,':cliente'=>$this->cliente, ':fecha'=>$this->fecha, 'impventas'=>$this->impventas, 'descuento'=>$this->descuento);
//         $data = DATA::Ejecutar($sql,$param,false);
//         if($data)
//         {
//             foreach ($this->producto as $insprod) {
//                 $sql="INSERT INTO productosxfactura   (idfactura, idProducto, precio, cantidad)
//                     VALUES (:idfactura, :idProducto, :precio, :cantidad)";              
//                 //
//                 $param= array(':idfactura'=>"ad23718a-5fec-11e8-af02-c85b76da12f5",':idProducto'=>$insprod[0], ':precio'=>$insprod[3], ':cantidad'=>$insprod[4]);
//                 $data = DATA::Ejecutar($sql,$param,false);
//                 if($data)
//                 {
//                     // return true;
//                 }
//                 else throw new Exception('Error al guardar.', 02);
//             }
//         }
//         else throw new Exception('Error al guardar.', 02);
//     }     
//     catch(Exception $e) {
//         header('HTTP/1.0 400 Bad error');
//         die(json_encode(array(
//             'code' => $e->getCode() ,
//             'msg' => $e->getMessage()))
//         );
//     }
// }
/////////////////////////////////////////////
    function Create(){
        try {
            // $sql="INSERT INTO factura   (id, idUsuario, fecha, subTotal, iva, porcentajeIva, descuento, porcentajeDescuento, total)
            //     VALUES (:uuid, :idUsuario, :fecha, :subTotal, :iva, :porcentajeIva, :descuento, :porcentajeDescuento, :total)";
            //
            $sql="INSERT INTO factura   (id, idUsuario, idcliente, fecha, impventas, descuento)
            VALUES (:uuid, :idUsuario, :idcliente, :fecha, :impventas, :descuento)"; 
        
            // $param= array(':usuario'=>$this->idUsuario,':cliente'=>$this->cliente, ':fecha'=>$this->fecha, 'impventas'=>$this->impventas, 'descuento'=>$this->descuento);
       
            $param= array(':uuid'=>$this->id, ':idUsuario'=>$this->idUsuario, ':idcliente'=>$this->idcliente, ':fecha'=>$this->fecha, 
            ':impventas'=>$this->impventas, ':descuento'=>$this->descuento);
            $data = DATA::Ejecutar($sql,$param, false);
            if($data)
            {
                foreach ($this->producto as $insprod) {
                    $sql="INSERT INTO productosxfactura   (idfactura, idProducto, precio, cantidad)
                        VALUES (:idfactura, :idProducto, :precio, :cantidad)";              
                    //
                    $param= array(':idfactura'=>$this->id,':idProducto'=>$insprod[0], ':precio'=>$insprod[3], ':cantidad'=>$insprod[4]);
                    $data = DATA::Ejecutar($sql,$param,false);
                    if($data)
                    {
                        // return true;
                    }
                    else throw new Exception('Error al guardar.', 02);
                }
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
            $sql="UPDATE factura 
                SET idUsuario=:idUsuario, fecha=:fecha, subTotal= :subTotal, iva=:iva, porcentajeIva=:porcentajeIva, descuento=:descuento, porcentajeDescuento=:porcentajeDescuento, total=:total
                WHERE id=:id";
            $param= array(':id'=>$this->id, ':idUsuario'=>$this->idUsuario, ':fecha'=>$this->fecha, ':subTotal'=>$this->subTotal, ':iva'=>$this->iva, ':porcentajeIva'=>$this->porcentajeIva , 
                ':descuento'=>$this->descuento, ':porcentajeDescuento'=>$this->porcentajeDescuento, ':total'=>$this->total);
            $data = DATA::Ejecutar($sql,$param,false);
            if($data){
                //update array obj
                if($this->listaproducto!=null)
                    if(ProductosXFactura::Update($this->listaproducto))
                        return true;            
                    else throw new Exception('Error al guardar las categorias.', 03);
                else {
                    // no tiene categorias
                    if(ProductosXFactura::Delete($this->id))
                        return true;
                    else throw new Exception('Error al guardar las categorias.', 04);
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
            $sql="SELECT idProducto
                FROM categoriasXProducto x
                WHERE x.idProducto= :id";
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
            $sql='DELETE FROM factura  
                WHERE id= :id';
            $param= array(':id'=>$this->id);
            $data= DATA::Ejecutar($sql, $param, false);
            if($data){
                $sessiondata['status']=0; 
                return $sessiondata;
            }
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