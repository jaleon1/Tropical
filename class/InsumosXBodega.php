<?php
if(isset($_POST["action"])){
    

    $opt= $_POST["action"];
    unset($_POST['action']);
    // Classes
    require_once("Conexion.php");
    require_once("Usuario.php");
    require_once("InventarioInsumoXBodega.php");
    // Session
    if (!isset($_SESSION))
        session_start();
    // Instance
    $productosxbodega= new InsumosXBodega();
    switch($opt){
        case "ReadAll": // todos los insumos de una bodega específica
            echo json_encode($productosxbodega->ReadAll());
            break;
        case "ReadAllbyRange":
            echo json_encode($productosxbodega->ReadAllbyRange());
            break;
        case "ReadCompleto": // todas las bodegas
            echo json_encode($productosxbodega->ReadCompleto());
            break;
        case "Read":
            echo json_encode($productosxbodega->Read());
            break;
        // case "Create":
        //     $productosxbodega->Create();
        //     break;
        // case "Add":
        //     $productosxbodega->Add();
        //     break;
        case "Update":
            $productosxbodega->Update();
            break;
        case "Delete":
            echo json_encode($productosxbodega->Delete());
            break;   
        case "ReadByCode":
            $productosxbodega->codigo = $_POST['codigo'];
            echo json_encode($productosxbodega->ReadByCode());
            break;
        case "ReadCierreInventario":
            echo json_encode($productosxbodega->ReadCierreInventario());
            break;
    }
}

class InsumosXBodega{
    public $id=null;
    public $idBodega='';
    public $saldoCantidad='0'; 
    public $saldoCosto=0;
    public $costoPromedio='0';
    public $lista=array();
    public $fechaInicial='';
    public $fechaFinal='';
    public $inventario=array();

    function __construct(){
        // identificador único
        if(isset($_POST["id"])){
            $this->id= $_POST["id"] ?? null;
        }
        if(isset($_POST["idBodega"])){
            $this->idBodega= $_POST["idBodega"];
        }
        else $this->idBodega= $_SESSION["userSession"]->idBodega; // si no está seteada el idBodega, toma el de la sesion.
        //
        if(isset($_POST["obj"])){
            $obj= json_decode($_POST["obj"],true);
            $this->id= $obj["id"] ?? null;
            $this->idBodega= $obj["idBodega"] ?? null;
            $this->idProducto= $obj["idProducto"] ?? null;
            $this->saldoCantidad= $obj["saldoCantidad"] ?? 0;      
            $this->saldoCosto= $obj["saldoCosto"] ?? 0;
            $this->costoPromedio= $obj["costoPromedio"] ?? 0;
            $this->fechaInicial= $obj["fechaInicial"] ?? '';
            $this->fechaFinal= $obj["fechaFinal"] ?? '';
            if(isset($obj["arrInventario"])){
                foreach ($obj["arrInventario"] as $i) {
                    $inventarioTemp =  new InventarioInsumoXBodega();
                    $inventarioTemp->tipo= $i['tipo'];
                    $inventarioTemp->cantidad= $i['cantidad'];
                    array_push ($this->inventario, $inventarioTemp);
                }
            }
            unset($_POST['obj']);
            // En caso de ser una lista de articulos para agregar O lista de productos por distribuir.
            if(isset($obj["lista"] )){
                //require_once("Producto.php");
                foreach ($obj["lista"] as $item) {
                    $prodTemp =  new InsumosXBodega();
                    $prodTemp->id= $item['id'];
                    $prodTemp->idBodega= $this->idBodega;
                    $prodTemp->saldoCantidad= $this->saldoCantidad;
                    $prodTemp->saldoCosto= $this->saldoCosto;
                    $prodTemp->costoPromedio= $this->costoPromedio;
                    array_push ($this->lista, $prodTemp);
                }
                unset($_POST['lista']);
            }
        }
    }

    function ReadAll(){
        try {
            $sql='SELECT p.id, b.nombre as agencia, p.codigo, p.nombre, p.descripcion, ib.saldoCantidad, ib.saldoCosto, ib.costoPromedio
                FROM insumosXBodega ib INNER JOIN producto p on p.id = ib.idProducto
                INNER JOIN bodega b on b.id = ib.idBodega
                WHERE    idBodega= :idBodega';
            $param= array(':idBodega'=>$this->idBodega);
            $data= DATA::Ejecutar($sql,$param);
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
            $sql='SELECT i.id, b.nombre as agencia, idOrdenCompra AS ordenEntrada, idOrdenSalida AS ordenSalida,            
                    idInsumo, (
                        SELECT codigo 
                        FROM producto p 
                        INNER JOIN insumosXBodega x on x.idProducto = p.id
                        WHERE x.id = i.idInsumo
                    ) AS insumo,
                    entrada,
                    salida,
                    saldo,
                    costoAdquisicion,
                    valorEntrada,
                    valorSalida,
                    valorSaldo,
                    costoPromedio,
                    fecha
                FROM  inventarioBodega i INNER JOIN bodega b on b.id = i.idBodega
                WHERE fecha Between :fechaInicial and :fechaFinal       
                ORDER BY fecha desc';
            $param= array(':fechaInicial'=>$this->fechaInicial, ':fechaFinal'=>$this->fechaFinal);            
            $data= DATA::Ejecutar($sql, $param);
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

    function ReadCierreInventario()
    {
        try {
            $sql = 'SELECT i.id,  ( SELECT codigo 
                            FROM producto p 
                            INNER JOIN insumosXBodega x on x.idProducto = p.id
                            WHERE x.id = i.idInsumo
                        ) AS insumo,
                        ifnull( sum( entrada ), 0) as entrada,
                        ifnull( sum( salida ), 0) as salida,
                        ifnull( sum( entrada ), 0) - ifnull( sum( salida ), 0) as saldo,
                        max( fecha ) as fecha
                    FROM  inventarioBodega i 
                    WHERE fecha <=  :fechaFinal and idBodega = :idbodega
                    group by insumo
                    ORDER BY  fecha desc';
            $param= array(':fechaFinal'=>$this->fechaFinal, ':idbodega'=>  $_SESSION["userSession"]->idBodega);            
            $data = DATA::Ejecutar($sql, $param);
            return $data;
        } catch (Exception $e) {
            error_log("[ERROR]  (" . $e->getCode() . "): " . $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode(),
                'msg' => 'Error al cargar la lista'
            )));
        }
    }

    function ReadCompleto(){
        try {
            $sql='SELECT ib.id, b.nombre as agencia, p.codigo, p.nombre, p.descripcion, ib.saldoCantidad, ib.saldoCosto, ib.costoPromedio
                FROM insumosXBodega ib INNER JOIN producto p on p.id = ib.idProducto
                    INNER JOIN bodega b on b.id = ib.idBodega';
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

    function Read(){
        try {
            $sql='SELECT pb.id, pb.idBodega, b.nombre as agencia, pb.idProducto, pb.saldoCantidad, pb.saldoCosto, pb.costoPromedio, p.nombre as producto, p.descripcion, p.codigo
                FROM insumosXBodega pb 
                INNER JOIN producto p on p.id=pb.idProducto
                INNER JOIN bodega b on b.id = pb.idBodega
                where pb.id=:id';
            $param= array(':id'=>$this->id);
            $data= DATA::Ejecutar($sql,$param);
            return $data;
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar el productosxbodega'))
            );
        }
    }

    // Nunca Crea Insumos, se alimenta de la distribución.
    // function create(){
    //     try {
    //         $sql="INSERT INTO insumosXBodega (id, idBodega, tamano, precioVenta) 
    //             VALUES (uuid(), :idBodega, :tamano, :precioVenta);";
    //         //
    //         $this->tamano=0;
    //         $param= array(':idBodega'=>$this->idBodega, ':tamano'=>$this->tamano, ':precioVenta'=>$this->precioVenta );
    //         $data = DATA::Ejecutar($sql,$param, false);
    //         $this->tamano=1;
    //         $param= array(':idBodega'=>$this->idBodega, ':tamano'=>$this->tamano, ':precioVenta'=>$this->precioVenta );
    //         $data = DATA::Ejecutar($sql, $param, false);
    //         if($data)
    //         {
    //             return true;
    //         }
    //         else throw new Exception('Error al guardar.', 02);
    //     }     
    //     catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
    //         header('HTTP/1.0 400 Bad error');
    //         die(json_encode(array(
    //             'code' => $e->getCode() ,
    //             'msg' => $e->getMessage()))
    //         );
    //     }
    // }

    function Update(){
        try {
            // calculo del saldo costo.
            $this->saldoCosto = floatval($this->saldoCantidad) * floatval($this->costoPromedio);
            //
            $sql="UPDATE insumosXBodega 
                SET saldoCantidad=:saldoCantidad, saldoCosto=:saldoCosto, costoPromedio=:costoPromedio
                WHERE id=:id";
            $param= array(':id'=>$this->id, ':saldoCantidad'=>$this->saldoCantidad, ':saldoCosto'=>$this->saldoCosto, ':costoPromedio'=>$this->costoPromedio);
            $data = DATA::Ejecutar($sql,$param,false);
            if($data){
                // recorre el arreglo de inventario y guarda el historico.
                // busca la bodega del insumo modificado.
                $resultado=true;
                $sql="SELECT idBodega
                    FROM insumosXBodega
                    WHERE id=:id";
                $param= array(':id'=>$this->id);
                $idBodega = DATA::Ejecutar($sql,$param);
                //
                foreach ($this->inventario as $item) {
                    if($item->tipo=='entrada'){
                        $sql="INSERT INTO inventarioBodega  (id, idBodega, idOrdenCompra, idInsumo, entrada, saldo, costoAdquisicion, valorEntrada, valorSaldo, costoPromedio)
                            VALUES (uuid(), :idBodega, :idOrdenCompra, :idInsumo, :entrada, :saldo, :costoAdquisicion, :valorEntrada, :valorSaldo, :costoPromedio);";
                        $param= array(
                            ':idBodega'=>$idBodega[0]['idBodega'],
                            'idOrdenCompra' => 'Entrada Manual: ' . $_SESSION["userSession"]->username,
                            ':idInsumo'=>$this->id,
                            ':entrada'=>$item->cantidad,
                            ':saldo'=>$this->saldoCantidad, 
                            ':costoAdquisicion'=> $this->costoPromedio,
                            ':valorEntrada'=> floatval($this->costoPromedio * floatval($item->cantidad)),
                            ':valorSaldo'=> $this->saldoCosto,
                            ':costoPromedio'=>$this->costoPromedio
                        );
                        $data = DATA::Ejecutar($sql, $param, false);
                        if(!$data)
                            $resultado=false;
                    } else{ // salida.
                        $sql="INSERT INTO inventarioBodega  (id, idBodega, idOrdenSalida, idInsumo, salida, saldo, valorSalida, valorSaldo)
                            VALUES (uuid(), :idBodega, :idOrdenSalida, :idInsumo, :salida, :saldo, :valorSalida, :valorSaldo );";
                        $param= array(
                            ':idBodega'=>$idBodega[0]['idBodega'],
                            'idOrdenSalida' => 'Salida Manual: ' . $_SESSION["userSession"]->username,
                            ':idInsumo'=>$this->id,
                            ':salida'=>$item->cantidad,
                            ':saldo'=>$this->saldoCantidad, 
                            ':valorSalida'=> floatval($this->costoPromedio * floatval($item->cantidad)),
                            ':valorSaldo'=> $this->saldoCosto
                        );
                        $data = DATA::Ejecutar($sql, $param, false);
                        if(!$data)
                            $resultado=false;
                    }
                }
                return $resultado;
            }                
            else throw new Exception('Error al guardar.', 123);
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
            $sql='DELETE FROM insumosXBodega  
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

    function RestarBodega($idprob, $cantidad){
        try {
            $sql="UPDATE productosXBodega 
                SET cantidad= cantidad - :cantidad
                WHERE id= :id   ";
            //
            $param= array(':id'=>$idprob, ':cantidad'=> $cantidad);
            $data = DATA::Ejecutar($sql,$param, false);
            if(!$data)
                throw new Exception('Error al guardar.', 02);
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }

    function ActualizaPrecios(){
        try{     
            $created = true;
            foreach ($this->lista as $item) {
                $sql="UPDATE insumosXBodega
                    SET precioVenta=:precioVenta
                    WHERE id= :id";
                $param= array(':id'=>$item->id, ':precioVenta'=>$item->precioVenta);
                $data= DATA::Ejecutar($sql,$param, false);
                if(!$data)
                    $created= false;                
            }
            if(!$created)
                throw new Exception('Error al actualizar precios, REVISAR manualmente.', 666);
            else return true;
            // 
        }
        catch(Exception $e){
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }

    function ReadByCode(){
        try{
            $sql="SELECT i.id, idProducto, p.nombre, p.codigo, p.descripcion, i.saldoCosto, i.costoPromedio, i.saldoCantidad
                FROM insumosXBodega i inner join producto p on p.id = i.idProducto
                WHERE codigo like :codigo and idBodega = :idBodega";
            $param= array(':codigo'=>'%'.$this->codigo.'%', 'idBodega'=>$this->idBodega);
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
