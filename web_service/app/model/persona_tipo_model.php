<?php
namespace App\Model;

use App\Lib\Response;

class PersonaTipoModel
{

    private $db;
    private $table = 'personas_por_tipo';
    private $table_id = 'idtipo';
    private $response;
    
    public function __CONSTRUCT($db)
    {
        $this->db = $db;
        $this->response = new Response();
    }
    
    public function getAll()
    {

    

        $sql = "SELECT * FROM $this->table";        
        $stmt  = $this->db->prepare($sql);
        $stmt->execute();
        $data = $stmt->fetchAll();

        $sql2 ="SELECT COUNT(*) as total FROM $this->table";
        $stmt = $this->db->prepare($sql2);
        $stmt->execute();
        $total = $stmt->fetch();

        return [
            'data'  => $data,
            'total' => $total
        ];
    
    }
    
    
    
    
    public function insert($data)
    {
        $stmt = $this->db->prepare("INSERT INTO $this->table(idpersona, idtipopersona, estado) VALUES (:idpersona, :idtipopersona, :estado);
");
        $stmt->bindParam(':idpersona', $idpersona);
        $stmt->bindParam(':idtipopersona', $idtipopersona);
        $stmt->bindParam(':estado', $estado);

        $idpersona =$data['idpersona'];
        $idtipopersona =$data['idtipopersona'];
        $estado =$data['estado'];

        $stmt->execute();
        
        return $this->response->SetResponse(true);
    }
    
    public function update($data, $id)
    {
        $stmt = $this->db->prepare("UPDATE $this->table SET categoria = :categoria, unidad = :unidad, persona = :persona, descripcion = :descripcion, nombre_producto = :nombre_producto, precio = :precio, estado = :estado WHERE $this->table_id = :producto");   
   
        $stmt->bindParam(':producto', $producto);
        $stmt->bindParam(':categoria', $categoria);
        $stmt->bindParam(':unidad', $unidad);
        $stmt->bindParam(':persona', $persona);
        $stmt->bindParam(':descripcion', $descripcion);
        $stmt->bindParam(':nombre_producto', $nombre_producto);
        $stmt->bindParam(':precio', $precio);
        $stmt->bindParam(':estado', $estado);


        $producto =$id;
        $categoria =$data['categoria'];
        $unidad =$data['unidad'];
        $persona =$data['persona'];
        $descripcion =$data['descripcion'];
        $nombre_producto =$data['nombre_producto'];
        $precio =$data['precio'];
        $estado =$data['estado'];
        

        $stmt->execute();


        return $this->response->SetResponse(true);
    }
    
    public function delete($id)
    {
        $sql = "DELETE FROM $this->table WHERE $this->table_id = $id";
        $stmt = $this->db->prepare($sql);

        $stmt->execute();
        
        return $this->response->SetResponse(true);
    }
    
    public function get($id)
    {
        $sql = "SELECT * FROM $this->table WHERE $this->table_id = $id";
        $stmt  = $this->db->prepare($sql);

        $stmt->execute();

        return $stmt->fetch();
    }
    
    
}