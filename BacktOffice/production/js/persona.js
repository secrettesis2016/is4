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
   // getIva();
    //getCategoria();
    getTiposDocumentos();
    getPaises();
    getCiudades();
    getTipoPersona();
    getPersonas();
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
                    $('#iddescripcionedit').val(response.descripcion);
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
                url:   'http://52.67.57.33/_junior/web_service/public/index.php/persona/get/' + id,
                type:  'get',
                beforeSend: function () {

                },
                error: function (response){
                    $('#alerta').show();
                },
                success:  function (response) {
                    $('#idpersonadelete').val(response.idpersona);
                }
            });
}


function deletePersona(){
            var id = document.getElementById("idpersonadelete").value;
            $.ajax({
                url:   'http://52.67.57.33/_junior/web_service/public/index.php/persona/delete/' + id,
                type:  'delete',
                beforeSend: function () {
                    $('#datatable').children().empty();
                    $('#antes').show();
                },
                error: function (response){
                    $('#alerta').show();
                },
                success:  function (response) {
                    alert('Persona Eliminada');
                    getPersonas();
                }
            });
}

function deletePersonaPorTipo(){
            var id = document.getElementById("idpersonadelete").value;
            $.ajax({
                url:   'http://52.67.57.33/_junior/web_service/public/index.php/persona_tipo/delete/' + id,
                type:  'delete',
                beforeSend: function () {
                    $('#datatable').children().empty();
                    $('#antes').show();
                },
                error: function (response){
                    $('#alerta').show();
                },
                success:  function (response) {
                    deletePersona();
                    getPersonas();
                    alert('Relacion Eliminada')
                }
            });
}


function validar(){
    
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
                url:   'http:/localhost/aluvi/web_service/public/index.php/noticia/update/' + noticia,
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
function getPersonas(){
            $.ajax({
                url:   'http://52.67.57.33/_junior/web_service/public/index.php/persona/getAll',
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
                                var estado;
                                if(response.data[i].estado == 'A'){
                                    estado = 'Activo';
                                }else{
                                    estado = 'Inactivo';
                                }
                                if(response.data[i].estado == ''){
                                    estado = 'Definir';
                                }
                                $('#datatable tbody').append('<tr><td>' + response.data[i].idpersona  + 
                                '</td><td>' + response.data[i].primer_nombre +  " " +  response.data[i].segundo_nombre + ", "  + response.data[i].primer_apellido + ' ' + response.data[i].segundo_apellido + 
                                '</td><td>' + response.data[i].fecha_nacimiento +       
                                '</td><td>' + response.data[i].mail +    
                                '</td><td>' + response.data[i].nro_documento +
                                '</td><td>' + estado +
                                '</td><td><button id="' + response.data[i].idpersona +'" type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal" onclick="cargarEditar(this.id);">Editar</button><input type="button" data-toggle="modal" data-target="#myModal1" class="btn btn-danger" value="Eliminar" id="' + response.data[i].idpersona +'" onclick="cargarEliminar(this.id);" /></td></tr>');
                            }
                        }
                }
            });
}

function getPersonas2(){
            $.ajax({
                url:   'http://52.67.57.33/_junior/web_service/public/index.php/persona/getAll2',
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
                                var estado;
                                if(response.data[i].estado == 'A'){
                                    estado = 'Activo';
                                }else{
                                    estado = 'Inactivo';
                                }
                                $('#datatable tbody').append('<tr><td>' + response.data[i].idpersona  + 
                                '</td><td>' + response.data[i].primer_nombre +  " " +  response.data[i].segundo_nombre + ", "  + response.data[i].primer_apellido + ' ' + response.data[i].segundo_apellido + 
                                '</td><td>' + response.data[i].fecha_nacimiento +       
                                '</td><td>' + response.data[i].mail +    
                                '</td><td>' + response.data[i].nro_documento +
                                '</td><td>' + 'Requiere estado' + 
                                '</td><td><button id="' + response.data[i].idpersona +'" type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal" onclick="cargarEditar(this.id);">Editar</button><input type="button" data-toggle="modal" data-target="#myModal1" class="btn btn-danger" value="Eliminar" id="' + response.data[i].idpersona +'" onclick="cargarEliminar(this.id);" /></td></tr>');
                            }
                        }
                }
            });
}

function getPaises(){
            $.ajax({
                url:   'http://52.67.57.33/_junior/web_service/public/index.php/pais/getAll',
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
                                $('#idpais').append('<option value="'+ response.data[i].pais  +'">' + response.data[i].nombre  + '</option>');
                            }
                        }
                }
            });
}

function getPaises(){
            $.ajax({
                url:   'http://52.67.57.33/_junior/web_service/public/index.php/pais/getAll',
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
                                $('#idpais').append('<option value="'+ response.data[i].pais  +'">' + response.data[i].nombre  + '</option>');
                            }
                        }
                }
            });
}


function getCiudades(){
            $.ajax({
                url:   'http://52.67.57.33/_junior/web_service/public/index.php/ciudad/getAll',
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
                                    $('#idciudad').append('<option value="'+ response.data[i].ciudad  +'">' + response.data[i].nombre  + '</option>');
                            }
                        }
                }
            });
}

function getBarrios(){
            var x = document.getElementById('idciudad').value;
            
            $.ajax({
                url:   'http://52.67.57.33/_junior/web_service/public/index.php/barrio/getAll',
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
                                if(response.data[i].ciudad == x){
                                    $('#idbarrio').append('<option value="'+ response.data[i].idbarrio  +'">' + response.data[i].nombre  + '</option>');
                                }
                            }
                        }
                }
            });
}


function getPersona(){
            var x = document.getElementById('idnrodocumento').value;
            
            $.ajax({
                url:   'http://52.67.57.33/_junior/web_service/public/index.php/persona/cedula/' + x,
                type:  'get',
                beforeSend: function () {
                },
                error: function (response){
                },
                success:  function (response) {
                    document.getElementById('idpersonaguardada').value = response.idpersona;
                }
            });
}

function getTipoPersona(){
            
            $.ajax({
                url:   'http://52.67.57.33/_junior/web_service/public/index.php/tipo_persona/getAll',
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
                                    $('#idtipopersona').append('<option value="'+ response.data[i].idtipopersona  +'">' + response.data[i].nombre  + '</option>');
                            }
                        }
                }
            });
}

function getTiposDocumentos(){
            $.ajax({
                url:   'http://52.67.57.33/_junior/web_service/public/index.php/tipo_documento/getAll',
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
                                    $('#idtipo').append('<option value="'+ response.data[i].idtipo  +'">' + response.data[i].nombre  + '</option>');
                            }
                        }
                }
            });
}

function insertPersona(){
        var tipo_persona = document.getElementById("idtipo").value;
        var ciudad = document.getElementById("idciudad").value;
        var barrio = document.getElementById("idbarrio").value;        
        var pais = document.getElementById("idpais").value;;
        var primer_mombre = document.getElementById("idprimernombre").value;
        var segundo_nombre = document.getElementById("idsegundonombre").value;
        var primer_apellido = document.getElementById("idprimerapellido").value;
        var segundo_apellido = document.getElementById("idsegundoapellido").value;
        var apellido_casada = document.getElementById("idapellidocadafa").value;
        var fecha_nacimiento = document.getElementById("idfechanacimiento").value;
        var estado_civil = document.getElementById("idestadocivil").value;
        var sexo = document.getElementById("idsexo").value;
        var mail = document.getElementById("idmail").value;
        var nro_documento = document.getElementById("idnrodocumento").value;
        var parametros = {
                "tipo_persona" : tipo_persona,
                "ciudad": ciudad,
                "barrio": barrio,
                "pais": pais,
                "primer_mombre": primer_mombre,
                "segundo_nombre": segundo_nombre,
                "primer_apellido": primer_apellido,
                "segundo_apellido": segundo_apellido, 
                "apellido_casada": apellido_casada,
                "fecha_nacimiento": fecha_nacimiento,
                "estado_civil": estado_civil,
                "sexo": sexo,
                "mail": mail,
                "nro_documento": nro_documento,

        };
        $.ajax({
                data: parametros,
                url:   'http://52.67.57.33/_junior/web_service/public/index.php/persona/insert',
                type:  'post',
                beforeSend: function () {
                    $('#datatable').children().empty();
                    $('#antes').show();                  
                },
                error: function(response) {
                },
                success:  function (response) {
                    $('#antes').hide();                  
                    getPersonas2();
                    getPersona();
                }
        });
}

function insertTipoPersona(){
        var idpersona = document.getElementById("idpersonaguardada").value;
        var idtipopersona = document.getElementById("idtipopersona").value;
        var estado = document.getElementById("idestado").value;        
        var parametros = {
                "idpersona" : idpersona,
                "idtipopersona": idtipopersona,
                "estado": estado
        };
        $.ajax({
                data: parametros,
                url:   'http://52.67.57.33/_junior/web_service/public/index.php/persona_tipo/insert',
                type:  'post',
                beforeSend: function () {
                    $('#datatable').children().empty();
                    $('#antes').show();                    
                },
                error: function(response) {
                },
                success:  function (response) {
                    alert('insertado');
                    $('#antes').show();                    
                    getPersonas();
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
                },
                success:  function (response) {
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