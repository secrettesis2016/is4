/*function validar(obj){
    var uploadFile = document.getElementById('idimagen').files[0];
    if (!window.FileReader) {
        alert('El navegador no soporta la lectura de archivos');
        return;
    }

    if (!(/\.(jpg|png|gif)$/i).test(uploadFile.name)) {
        alert('El archivo a adjuntar no es una imagen');
    }
    else {
        var img = new Image();
        img.onload = function () {
             if (uploadFile.size > 9999999999)
            {
                alert('Ha exedido el peso')
            }
            else {
                insertNoticia();         
            }
        };
        img.src = URL.createObjectURL(uploadFile);
    }                 
}
function moverImagen(){

}*/

function cargar(){
    getIva();
    getCategoria();
    getProductos();
}

function cargarEditar(id){
            $.ajax({
                url:   'http://52.67.57.33/_junior/web_service/public/index.php/producto/get/' + id,
                type:  'get',
                beforeSend: function () {

                },
                error: function (response){
                    $('#alerta').show();
                },
                success:  function (response) {
                    $('#idproductoedit').val(response.idproducto);
                    $('#idnombreedit').val(response.nombre);
                    $('#iddescripcionedit').val(response.producto_descripcion);
                    $('#idcodigobarrasedit').val(response.codigo_barras);
                    $('#idivaedit').append("<option value='" + response.idiva + "' selected>"+response.iva_descripcion+"</option>");
                    $('#idsubcategoriaedit').append("<option value='" + response.categoria + "' selected>"+response.categoria_nombre+"</option>");
                    $('#idpreciocompraedit').val(response.precio_compra);
                    $('#idprecioventaedit').val(response.precio_venta);
                    $('#idpreciominimoedit').val(response.precio_minimo);
                }
            });
}



function cargarEliminar(id){
            $.ajax({
                url:   'http://52.67.57.33/_junior/web_service/public/index.php/producto/get/' + id,
                type:  'get',
                beforeSend: function () {

                },
                error: function (response){
                    $('#alerta').show();
                },
                success:  function (response) {
                    $('#idproductodelete').val(response.idproducto);
                    $('#idnombredelete').val(response.nombre);
                    $('#iddescripciondelete').val(response.producto_descripcion);
                    $('#idivadelete').append("<option value='" + response.idiva + "' selected>"+response.iva_descripcion+"</option>");
                    $('#idsubcategoriadelete').append("<option value='" + response.categoria + "' selected>"+response.categoria_nombre+"</option>");
                    $('#idpreciocompradelete').val(response.precio_compra);
                    $('#idprecioventadelete').val(response.precio_venta);
                    $('#idpreciominimodelete').val(response.precio_minimo);
                }
            });
}


function deleteProducto(){
            var id = document.getElementById("idproductodelete").value;
            $.ajax({
                url:   'http://52.67.57.33/_junior/web_service/public/index.php/producto/delete/' + id,
                type:  'delete',
                beforeSend: function () {
                    $('#datatable').children().empty();
                    $('#antes').show();
                },
                error: function (response){
                    $('#alerta').show();
                },
                success:  function (response) {
                    getProductos();
                }
            });
}

/*
function updateNoticia(){
        var noticia = document.getElementById("idnoticiaedit").value;
        var imagen = document.getElementById("idimagenedit").value;
        var titulo = document.getElementById("idtituloedit").value;
        var fecha = document.getElementById("idfechaedit").value;
        var hora = document.getElementById("idhoraedit").value;
        var descripcion = document.getElementById("iddescripcionedit").value;
        var parametros = {
                "titulo" : titulo,
                "imagen": imagen,
                "fecha": fecha,
                "hora": hora,
                "descripcion": descripcion
        };
        $.ajax({
                data: parametros,
                url:   'http://localhost/aluvi/web_service/public/index.php/noticia/update/' + noticia,
                type:  'put',
                beforeSend: function () {
                    $('#datatable').children().empty();
                    $('#antes').show();
                },
                error: function(response) {
                    $('#alerta').show();
                    $('#antes').hide(); 
                    getNoticias();
                },
                success:  function (response) {
                    getNoticias();
                }
        });    
}
function cambiarfoto(){
    document.getElementById('idfoto').src = document.getElementById('idimagenedit').value;
}
function cargarFotoInsert(){
    document.getElementById('idfotoinsert').src = document.getElementById('idimagen').value;
}*/
function getProductos(){
            $.ajax({
                url:   'http://52.67.57.33/_junior/web_service/public/index.php/producto/getAll',
                type:  'get',
                beforeSend: function () {
                    $("#antes").html("<img src='images/espera.gif'/>");                        
                    $("#nocarga").append('<div class="alert alert-danger" id="alerta" style="display:none"><a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a><strong>Error!</strong>Favor, verifique su conexión a internet</div>');
                },
                error: function (response){
                    $("#antes").hide();
                    $('#alerta').show();
                },
                success:  function (response) {
                        if (isNaN(response.total.total)) {
                            $('#antes').hide(); 
                            $('#vacio').html('No se encontro ningun registro.');
                        }else{
                            $('#antes').hide(); 
                            var longitud = response.data.length;
                            for (var i = 0; i < longitud; i++) {
                                $('#datatable tbody').append('<tr><td>' + response.data[i].idproducto  + 
                                '</td><td>' + response.data[i].nombre +    
                                '</td><td>' + response.data[i].producto_descripcion +       
                                '</td><td>' + response.data[i].codigo_barras +    
                                '</td><td>' + response.data[i].iva_descripcion +
                                '</td><td>' + response.data[i].categoria_nombre +
                                '</td><td>' + response.data[i].precio_compra +
                                '</td><td>' + response.data[i].precio_venta +
                                '</td><td>' + response.data[i].precio_minimo +
                                '</td><td>' + response.data[i].margen_ganancia +
                                '</td><td><button id="' + response.data[i].idproducto +'" type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal" onclick="cargarEditar(this.id);">Editar</button><input type="button" data-toggle="modal" data-target="#myModal1" class="btn btn-danger" value="Eliminar" id="' + response.data[i].idproducto +'" onclick="cargarEliminar(this.id);" /></td></tr>');
                            }
                        }
                }
            });
}

function getIva(){
            $.ajax({
                url:   'http://52.67.57.33/_junior/web_service/public/index.php/iva/getAll',
                type:  'get',
                beforeSend: function () {
                },
                error: function (response){
                },
                success:  function (response) {
                        if (isNaN(response.total.total)) {
                            $('#antes').hide(); 
                            $('#vacio').html('No se encontro ningun registro.');
                        }else{
                            $('#antes').hide(); 
                            var longitud = response.data.length;
                            for (var i = 0; i < longitud; i++) {
                                $('#idiva').append('<option value="'+ response.data[i].idiva  +'">' + response.data[i].descripcion  + '</option>');                                
                                $('#idivaedit').append('<option value="'+ response.data[i].idiva  +'">' + response.data[i].descripcion  + '</option>');

                            }
                        }
                }
            });
}

function getCategoria(){
            $.ajax({
                url:   'http://52.67.57.33/_junior/web_service/public/index.php/categoria/getAll',
                type:  'get',
                beforeSend: function () {
                },
                error: function (response){
                },
                success:  function (response) {
                        if (isNaN(response.total.total)) {
                        }else{
                            $('#antes').hide(); 
                            var longitud = response.data.length;
                            for (var i = 0; i < longitud; i++) {
                                if(response.data[i].cat_padre == null){
                                    $('#idcategoria').append('<option value="'+ response.data[i].idcategoria  +'">' + response.data[i].nombre  + '</option>');
                                    $('#idcategoriaedit').append('<option value="'+ response.data[i].idcategoria  +'">' + response.data[i].nombre  + '</option>');
                                }
                            }
                        }
                }
            });
}

function getSubCategoria(){
            var x = document.getElementById('idcategoria').value;
            $.ajax({
                url:   'http://52.67.57.33/_junior/web_service/public/index.php/categoria/getAll',
                type:  'get',
                beforeSend: function () {
                },
                error: function (response){
                },
                success:  function (response) {
                        if (isNaN(response.total.total)) {
                            $('#antes').hide(); 
                            $('#vacio').html('No se encontro ningun registro.');
                        }else{
                            $('#antes').hide(); 
                            var longitud = response.data.length;
                            for (var i = 0; i < longitud; i++) {
                                if(response.data[i].cat_padre == x){
                                    $('#idsubcategoria').append('<option value="'+ response.data[i].idcategoria  +'">' + response.data[i].nombre  + '</option>');
                                }
                            }
                        }
                }
            });
}
function getSubCategoriaEdit(){
            var x = document.getElementById('idcategoriaedit').value;
            $.ajax({
                url:   'http://52.67.57.33/_junior/web_service/public/index.php/categoria/getAll',
                type:  'get',
                beforeSend: function () {
                },
                error: function (response){
                },
                success:  function (response) {
                        if (isNaN(response.total.total)) {
                            $('#antes').hide(); 
                            $('#vacio').html('No se encontro ningun registro.');
                        }else{
                            $('#antes').hide(); 
                            var longitud = response.data.length;
                            for (var i = 0; i < longitud; i++) {
                                if(response.data[i].cat_padre == x){
                                    $('#idsubcategoriaedit').append('<option value="'+ response.data[i].idcategoria  +'">' + response.data[i].nombre  + '</option>');
                                }
                            }
                        }
                }
            });
}
/*
function tabla(){
      $(document).ready(function() {
        var handleDataTableButtons = function() {
          if ($("#datatable-buttons").length) {
            $("#datatable-buttons").DataTable({
              dom: "Bfrtip",
              buttons: [
                {
                  extend: "copy",
                  className: "btn-sm"
                },
                {
                  extend: "csv",
                  className: "btn-sm"
                },
                {
                  extend: "excel",
                  className: "btn-sm"
                },
                {
                  extend: "pdfHtml5",
                  className: "btn-sm"
                },
                {
                  extend: "print",
                  className: "btn-sm"
                },
              ],
              responsive: true
            });
          }
        };

        TableManageButtons = function() {
          "use strict";
          return {
            init: function() {
              handleDataTableButtons();
            }
          };
        }();

        $('#datatable').dataTable();

        $('#datatable-keytable').DataTable({
          keys: true
        });

        $('#datatable-responsive').DataTable();

        $('#datatable-scroller').DataTable({
          ajax: "js/datatables/json/scroller-demo.json",
          deferRender: true,
          scrollY: 380,
          scrollCollapse: true,
          scroller: true
        });

        $('#datatable-fixed-header').DataTable({
          fixedHeader: true
        });

        var $datatable = $('#datatable-checkbox');

        $datatable.dataTable({
          'order': [[ 1, 'asc' ]],
          'columnDefs': [
            { orderable: false, targets: [0] }
          ]
        });
        $datatable.on('draw.dt', function() {
          $('input').iCheck({
            checkboxClass: 'icheckbox_flat-green'
          });
        });

        TableManageButtons.init();
      });
}*/
function insertProducto(){
        var nombre = document.getElementById("idnombre").value;
        var descripcion = document.getElementById("iddescripcion").value;
        var codigo_barras = document.getElementById("idcodigobarras").value;        
        var idiva = document.getElementById("idiva").value;
        var categoria = document.getElementById("idsubcategoria").value;
        var precio_compra = document.getElementById("idpreciocompra").value;
        var precio_venta = document.getElementById("idprecioventa").value;
        var precio_minimo = document.getElementById("idpreciominimo").value;
        var margen_ganancia = precio_venta - precio_compra;
        
        var parametros = {
                "nombre" : nombre,
                "descripcion": descripcion,
                "codigo_barras": codigo_barras,
                "idiva": idiva,
                "categoria": categoria,
                "precio_compra": precio_compra,
                "precio_venta": precio_venta,
                "precio_minimo": precio_minimo, 
                "margen_ganancia": margen_ganancia           
        };
        $.ajax({
                data: parametros,
                url:   'http://52.67.57.33/_junior/web_service/public/index.php/producto/insert',
                type:  'post',
                beforeSend: function () {
                    $('#datatable').children().empty();
                    $('#antes').show();                    
                },
                error: function(response) {
                },
                success:  function (response) {
                    getProductos();
                }
        });
}

function updateProducto(){
        var id = document.getElementById("idproductoedit").value;
        var nombre = document.getElementById("idnombreedit").value;
        var descripcion = document.getElementById("iddescripcionedit").value;
        var codigo_barras = document.getElementById("idcodigobarrasedit").value;        
        var idiva = document.getElementById("idivaedit").value;
        var categoria = document.getElementById("idsubcategoriaedit").value;
        var precio_compra = document.getElementById("idpreciocompraedit").value;
        var precio_venta = document.getElementById("idprecioventaedit").value;
        var precio_minimo = document.getElementById("idpreciominimoedit").value;
        var margen_ganancia = precio_venta - precio_compra;
        
        var parametros = {
                "nombre" : nombre,
                "descripcion": descripcion,
                "codigo_barras": codigo_barras,
                "idiva": idiva,
                "categoria": categoria,
                "precio_compra": precio_compra,
                "precio_venta": precio_venta,
                "precio_minimo": precio_minimo, 
                "margen_ganancia": margen_ganancia           
        };
        $.ajax({
                data: parametros,
                url:   'http://52.67.57.33/_junior/web_service/public/index.php/producto/update/' + id,
                type:  'put',
                beforeSend: function () {
                    $('#datatable').children().empty();
                    $('#antes').show();                    
                },
                error: function(response) {
                    alert('error al editar');
                    getProductos();
                },
                success:  function (response) {
                    alert('editado');
                    getProductos();
                }
        });
}

//limpiar/*
/*
function limpiaInsert(){
    $('#idnoticia').val("");
    $('#idtitulo').val("");
    $('#idimagen').val("");
    document.getElementById('idfoto').src = "images/foto_vacio.png";
    $('#idfecha').val("");
    $('#idhora').val("");                    
    $('#iddescripcion').val(""); 
}
function limpiarEdit(){
    $('#idnoticiaedit').val("");
    $('#idtituloedit').val("");
    $('#idimagenedit').val("");
    document.getElementById('idfotoedit').src = "images/foto_vacio.png";
    $('#idfechaedit').val("");
    $('#idhoraedit').val("");                    
    $('#iddescripcionedit').val("");
}
function limpiarDelete(){
    $('#idnoticiadelete').val("");
    $('#idtitulodelete').val("");
    $('#idimagendelete').val("");
    document.getElementById('idfotoeliminar').src = "images/foto_vacio.png";
    $('#idfechadelete').val("");
    $('#idhoradelete').val("");                    
    $('#iddescripciondelete').val("");     
}*/