<?php
namespace App\Model;

use App\Lib\Response;

class PersonaModel
{

    private $db;
    private $table = 'personas';
    private $table_id = 'idpersona';
    private $response;
    
    public function __CONSTRUCT($db)
    {
        $this->db = $db;
        $this->response = new Response();
    }
    
    public function getAll()
    {

    

        $sql = "SELECT * FROM $this->table, personas_por_tipo WHERE personas.idpersona = personas_por_tipo.idpersona";        
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
    
    
    public function getAll2()
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
        $stmt = $this->db->prepare("INSERT INTO $this->table(idtipo, ciudad, idbarrio, pais, primer_nombre, segundo_nombre,primer_apellido, segundo_apellido, apellido_casada, 
            fecha_nacimiento, estado_civil, sexo, mail, nro_documento)
        VALUES (:idtipo, :ciudad, :idbarrio, :pais, :primer_nombre, :segundo_nombre, :primer_apellido, :segundo_apellido, :apellido_casada, :fecha_nacimiento, :estado_civil, :sexo, :mail, :nro_documento)");
        $stmt->bindParam(':idtipo', $idtipo);
        $stmt->bindParam(':ciudad', $ciudad);
        $stmt->bindParam(':idbarrio', $idbarrio);
        $stmt->bindParam(':pais', $pais);
        $stmt->bindParam(':primer_nombre', $primer_nombre);
        $stmt->bindParam(':segundo_nombre', $segundo_nombre);
        $stmt->bindParam(':primer_apellido', $primer_apellido);
        $stmt->bindParam(':segundo_apellido', $segundo_apellido);
        $stmt->bindParam(':apellido_casada', $apellido_casada);
        $stmt->bindParam(':fecha_nacimiento', $fecha_nacimiento);
        $stmt->bindParam(':estado_civil', $estado_civil);
        $stmt->bindParam(':sexo', $sexo);
        $stmt->bindParam(':mail', $mail);
        $stmt->bindParam(':nro_documento', $nro_documento);


        $idtipo =$data['tipo_persona'];
        $ciudad =$data['ciudad'];
        $idbarrio =$data['barrio'];
        $pais =$data['pais'];
        $primer_nombre =$data['primer_mombre'];
        $segundo_nombre =$data['segundo_nombre'];
        $primer_apellido =$data['primer_apellido'];
        $segundo_apellido =$data['segundo_apellido'];
        $apellido_casada =$data['apellido_casada'];
        $fecha_nacimiento =$data['fecha_nacimiento'];
        $estado_civil =$data['estado_civil'];
        $sexo =$data['sexo'];
        $mail =$data['mail'];
        $nro_documento =$data['nro_documento'];


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
    
    public function getCedula($id)
    {
        $sql = "SELECT idpersona FROM $this->table WHERE nro_documento = '$id'";
        $stmt  = $this->db->prepare($sql); 

        $stmt->execute();

        return $stmt->fetch();
    }    
}