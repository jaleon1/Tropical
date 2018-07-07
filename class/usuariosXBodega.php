<?php 
require_once("Conexion.php");

class usuariosXBodega{
    public $idBodega;
    public $idUsuario;
    public $nombre;
    public $descripcion;
    public $ubicacion;
    //
    public static function Read($idUsuario){
        try{
            $sql='SELECT ub.idBodega, b.nombre, b.descripcion, b.ubicacion
                FROM usuariosXBodega ub INNER JOIN bodega b on b.id=ub.idBodega
                where ub.idUsuario=:idUsuario';
            $param= array(':idUsuario'=>$idUsuario);
            $data= DATA::Ejecutar($sql,$param);
            $lista = [];
            foreach ($data as $key => $value){
                $bodega = new usuariosXBodega();
                $bodega->idBodega = $value['idBodega'];
                $bodega->nombre = $value['nombre'];
                $bodega->descripcion = $value['descripcion'];
                $bodega->ubicacion = $value['ubicacion'];        
                array_push ($lista, $bodega);
            }
            return $lista;
        }
        catch(Exception $e) {
            return false;
        }
    }

    public static function Create($obj){
        try {
            $created = true;
            foreach ($obj as $item) {
                $sql="INSERT INTO usuariosXBodega   (idBodega, idUsuario)
                VALUES (:idBodega, :idUsuario)";
                //
                $param= array(':idBodega'=>$item->idBodega, ':idUsuario'=>$item->idUsuario);
                $data = DATA::Ejecutar($sql,$param,false);
                if(!$data)
                    $created= false;
            }
            return $created;
        }     
        catch(Exception $e) {
            return false;
        }
    }

    public static function Update($obj){
        try {
            $updated = true;
            // elimina todos los objetos relacionados
            $updated= self::Delete($obj[0]->idUsuario);
            // crea los nuevos objetos
            $updated= self::Create($obj);
            return $updated;
        }     
        catch(Exception $e) {
            return false;
        }
    }

    public static function Delete($_idusuario){
        try {                 
            $sql='DELETE FROM usuariosXBodega  
                WHERE idUsuario= :idUsuario';
            $param= array(':idUsuario'=> $_idusuario);
            $data= DATA::Ejecutar($sql, $param, false);
            if($data)
                return true;
            else false;
        }
        catch(Exception $e) {
            return false;
        }
    }
}
?>