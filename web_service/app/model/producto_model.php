<?php
namespace App\Model;

use App\Lib\Response;

class ProductoModel
{

    private $db;
    private $table = 'productos';
    private $table_id = 'idproducto';
    private $response;
    
    public function __CONSTRUCT($db)
    {
        $this->db = $db;
        $this->response = new Response();
    }
    
    public function getAll()
    {

    

        $sql = "select p.idproducto, p.nombre, p.descripcion as producto_descripcion, p.codigo_barras, i.descripcion as iva_descripcion, c.nombre as categoria_nombre, p.precio_compra, p.precio_venta, p.precio_minimo, p.margen_ganancia
from productos as p, productos_iva as i, categorias as c
where  p.idiva = i.idiva 
and c.idcategoria = p.categoria";        
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
        $stmt = $this->db->prepare("INSERT INTO $this->table(nombre, descripcion, codigo_barras, idiva, categoria, precio_compra, precio_venta, precio_minimo, margen_ganancia)
                                                     VALUES (:nombre, :descripcion, :codigo_barras, :idiva, :categoria, :precio_compra, :precio_venta, :precio_minimo, :margen_ganancia)");
        $stmt->bindParam(':nombre', $nombre);
        $stmt->bindParam(':descripcion', $descripcion);
        $stmt->bindParam(':codigo_barras', $codigo_barras);
        $stmt->bindParam(':idiva', $idiva);
        $stmt->bindParam(':categoria', $categoria);
        $stmt->bindParam(':precio_compra', $precio_compra);
        $stmt->bindParam(':precio_venta', $precio_venta);
        $stmt->bindParam(':precio_minimo', $precio_minimo);
        $stmt->bindParam(':margen_ganancia', $margen_ganancia);


        $nombre =$data['nombre'];
        $descripcion =$data['descripcion'];
        $codigo_barras =$data['codigo_barras'];
        $idiva =$data['idiva'];
        $categoria =$data['categoria'];
        $precio_compra =$data['precio_compra'];
        $precio_venta =$data['precio_venta'];
        $precio_minimo =$data['precio_minimo'];
        $margen_ganancia =$data['margen_ganancia'];


        $stmt->execute();
        
        return $this->response->SetResponse(true);
    }
    
    public function update($data, $id)
    {
        $stmt = $this->db->prepare("UPDATE $this->table SET nombre =  :nombre, descripcion =  :descripcion,codigo_barras= :codigo_barras, idiva=:idiva,categoria= :categoria,precio_compra= :precio_compra,precio_venta= :precio_venta,precio_minimo= :precio_minimo,margen_ganancia= :margen_ganancia WHERE $this->table_id = :clave");   
        
        $stmt->bindParam(':clave', $clave);
        $stmt->bindParam(':nombre', $nombre);
        $stmt->bindParam(':descripcion', $descripcion);
        $stmt->bindParam(':codigo_barras', $codigo_barras);
        $stmt->bindParam(':idiva', $idiva);
        $stmt->bindParam(':categoria', $categoria);
        $stmt->bindParam(':precio_compra', $precio_compra);
        $stmt->bindParam(':precio_venta', $precio_venta);
        $stmt->bindParam(':precio_minimo', $precio_minimo);
        $stmt->bindParam(':margen_ganancia', $margen_ganancia);

        $clave =$id;
        $nombre =$data['nombre'];
        $descripcion =$data['descripcion'];
        $codigo_barras =$data['codigo_barras'];
        $idiva =$data['idiva'];
        $categoria =$data['categoria'];
        $precio_compra =$data['precio_compra'];
        $precio_venta =$data['precio_venta'];
        $precio_minimo =$data['precio_minimo'];
        $margen_ganancia =$data['margen_ganancia'];
        

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
        $sql = "SELECT p.idproducto, p.nombre, p.descripcion as producto_descripcion, p.codigo_barras, i.descripcion as iva_descripcion, i.idiva as idiva, c.nombre as categoria_nombre, p.precio_compra, p.precio_venta, p.precio_minimo, p.margen_ganancia"
                . " FROM productos as p, productos_iva as i, categorias as c "
                . "WHERE idproducto = $id and p.idiva = i.idiva and c.idcategoria = p.categoria";
        $stmt  = $this->db->prepare($sql);

        $stmt->execute();

        return $stmt->fetch();
    }
      
}