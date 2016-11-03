/*==============================================================*/
/* DBMS name:      PostgreSQL 9.x                               */
/* Created on:     3/11/2016 7:31:27 p. m.                      */
/*==============================================================*/

/*==============================================================*/
/* Domain: D_BOOLEAN                                            */
/*==============================================================*/
create domain D_BOOLEAN as BOOL;

/*==============================================================*/
/* Domain: D_CADENA_CORTA                                       */
/*==============================================================*/
create domain D_CADENA_CORTA as varchar(15);

/*==============================================================*/
/* Domain: D_CANTIDAD                                           */
/*==============================================================*/
create domain D_CANTIDAD as integer;

/*==============================================================*/
/* Domain: D_CODIGO_NORMAL                                      */
/*==============================================================*/
create domain D_CODIGO_NORMAL as integer;

/*==============================================================*/
/* Domain: D_DESCRIPCION                                        */
/*==============================================================*/
create domain D_DESCRIPCION as varchar(25);

/*==============================================================*/
/* Domain: D_DIRECCION                                          */
/*==============================================================*/
create domain D_DIRECCION as varchar(40);

/*==============================================================*/
/* Domain: D_FECHA                                              */
/*==============================================================*/
create domain D_FECHA as date;

/*==============================================================*/
/* Domain: D_FECHA_MOVIMIENTO                                   */
/*==============================================================*/
create domain D_FECHA_MOVIMIENTO as timestamp;

/*==============================================================*/
/* Domain: D_IVA                                                */
/*==============================================================*/
create domain D_IVA as numeric(2);

/*==============================================================*/
/* Domain: D_NOMBRE                                             */
/*==============================================================*/
create domain D_NOMBRE as varchar(40);

/*==============================================================*/
/* Domain: D_NRO_CORTO                                          */
/*==============================================================*/
create domain D_NRO_CORTO as numeric(2);

/*==============================================================*/
/* Domain: D_PRECIO                                             */
/*==============================================================*/
create domain D_PRECIO as decimal(15,2);

/*==============================================================*/
/* Domain: D_TIPO                                               */
/*==============================================================*/
create domain D_TIPO as varchar(1);

/*==============================================================*/
/* Table: AJUSTES                                               */
/*==============================================================*/
create table AJUSTES (
   IDAJUSTE             SERIAL               not null,
   FECHA                D_FECHA_MOVIMIENTO   not null,
   IDUSUARIO            D_CADENA_CORTA       not null,
   FECHAREGISTRO        D_FECHA_MOVIMIENTO   not null,
   FECHAMODIFICACION    D_FECHA_MOVIMIENTO   not null,
   constraint PK_AJUSTES primary key (IDAJUSTE)
);

/*==============================================================*/
/* Table: AJUSTESDETALLES                                       */
/*==============================================================*/
create table AJUSTESDETALLES (
   IDAJUSTE             D_CODIGO_NORMAL      not null,
   IDDEPOSITO           D_CODIGO_NORMAL      not null,
   IDPRODUCTO           D_CODIGO_NORMAL      not null,
   CANTIDAD             D_CANTIDAD           not null,
   TIPOAJUSTE           D_TIPO               not null,
   constraint PK_AJUSTESDETALLES primary key (IDAJUSTE, IDDEPOSITO, IDPRODUCTO)
);

/*==============================================================*/
/* Table: AUDITORIA                                             */
/*==============================================================*/
create table AUDITORIA (
   IDAUDITORIA          SERIAL               not null,
   TABLA                D_DESCRIPCION        not null,
   ID_TABLA             D_CODIGO_NORMAL      not null,
   ACCION               D_CADENA_CORTA       not null,
   USUARIO              D_CADENA_CORTA       not null,
   FECHA                D_FECHA_MOVIMIENTO   not null,
   DATOS_JSON           varchar(100)         not null,
   constraint PK_AUDITORIA primary key (IDAUDITORIA)
);

/*==============================================================*/
/* Table: BARRIOS                                               */
/*==============================================================*/
create table BARRIOS (
   IDBARRIO             SERIAL               not null,
   CIUDAD               INT4                 null,
   NOMBRE               D_NOMBRE             not null,
   constraint PK_BARRIOS primary key (IDBARRIO)
);

/*==============================================================*/
/* Table: CAJAS                                                 */
/*==============================================================*/
create table CAJAS (
   IDCAJA               SERIAL               not null,
   NOMBRE               VARCHAR(100)         not null,
   constraint PK_CAJAS primary key (IDCAJA)
);

/*==============================================================*/
/* Table: CATEGORIAS                                            */
/*==============================================================*/
create table CATEGORIAS (
   IDCATEGORIA          SERIAL               not null,
   CAT_PADRE            D_CODIGO_NORMAL      null,
   NOMBRE               D_DESCRIPCION        not null,
   constraint PK_CATEGORIAS primary key (IDCATEGORIA)
);

/*==============================================================*/
/* Table: CIUDADES                                              */
/*==============================================================*/
create table CIUDADES (
   CIUDAD               SERIAL               not null,
   NOMBRE               D_NOMBRE             not null,
   constraint PK_CIUDADES primary key (CIUDAD)
);

/*==============================================================*/
/* Table: COBROS_DETALLES                                       */
/*==============================================================*/
create table COBROS_DETALLES (
   IDCOBRO              D_CODIGO_NORMAL      not null,
   IDVENTA              D_CODIGO_NORMAL      not null,
   CUOTA                D_NRO_CORTO          not null,
   TIPOCOBRO            D_TIPO               not null,
   MONTO                D_PRECIO             not null,
   NRODOCUMENTO         D_CADENA_CORTA       null,
   constraint PK_COBROS_DETALLES primary key (IDCOBRO, IDVENTA, CUOTA)
);

/*==============================================================*/
/* Table: COBROS_VENTAS                                         */
/*==============================================================*/
create table COBROS_VENTAS (
   IDCOBRO              SERIAL               not null,
   IDCLIENTE            INT4                 null,
   IDHABILITACION       INT4                 null,
   NRORECIBO            D_CADENA_CORTA       null,
   FECHACOBRO           D_FECHA              not null,
   TOTALCOBRO           D_PRECIO             not null,
   FECHA_INSERT         D_FECHA_MOVIMIENTO   not null,
   FECHA_UPDATE         D_FECHA_MOVIMIENTO   not null,
   USUARIO_UPDATE       varchar(15)          null,
   constraint PK_COBROS_VENTAS primary key (IDCOBRO)
);

/*==============================================================*/
/* Table: COMPRAS                                               */
/*==============================================================*/
create table COMPRAS (
   IDCOMPRA             SERIAL               not null,
   NROFACTURA           D_CADENA_CORTA       not null,
   FECHACOMPRA          D_FECHA_MOVIMIENTO   not null,
   CONDICION            D_TIPO               not null,
   TOTALCUOTAS          D_NRO_CORTO          not null,
   FECHACUOTA           D_FECHA              not null,
   TOTAL                D_PRECIO             not null,
   TOTAL_IVA            D_PRECIO             not null,
   IDPERSONA            INT4                 null,
   FECHAREGISTRO        D_FECHA_MOVIMIENTO   not null,
   FECHA_UPDATE         D_FECHA_MOVIMIENTO   not null,
   FECHA_INSERT         TIMESTAMP            null,
   USUARIO_UPDATE       TIMESTAMP            null,
   constraint PK_COMPRAS primary key (IDCOMPRA)
);

/*==============================================================*/
/* Table: COMPRAS_CUOTAS                                        */
/*==============================================================*/
create table COMPRAS_CUOTAS (
   IDCOMPRA             D_CODIGO_NORMAL      not null,
   CUOTA                D_NRO_CORTO          not null,
   VENCIMIENTO          D_FECHA              not null,
   MONTO                D_PRECIO             not null,
   SALDO                D_PRECIO             not null,
   ESTADO               D_TIPO               not null,
   constraint PK_COMPRAS_CUOTAS primary key (IDCOMPRA, CUOTA)
);

/*==============================================================*/
/* Table: COMPRAS_DETALLES                                      */
/*==============================================================*/
create table COMPRAS_DETALLES (
   IDCOMPRA             D_CODIGO_NORMAL      not null,
   IDDEPOSITO           D_CODIGO_NORMAL      not null,
   IDPRODUCTO           D_CODIGO_NORMAL      not null,
   IDIVA                integer              null,
   CANTIDAD             D_CANTIDAD           not null,
   PRECIOUNITARIO       D_PRECIO             not null,
   TOTALITEM            D_PRECIO             not null,
   TOTALIVA             D_PRECIO             not null,
   constraint PK_COMPRAS_DETALLES primary key (IDCOMPRA, IDDEPOSITO, IDPRODUCTO)
);

/*==============================================================*/
/* Table: COMPRAS_DEVOLUCIONES                                  */
/*==============================================================*/
create table COMPRAS_DEVOLUCIONES (
   IDCOMPRADEVOLUCION   SERIAL               not null,
   IDCOMPRA             D_CODIGO_NORMAL      null,
   IDPERSONA            INT4                 null,
   FECHA                D_FECHA_MOVIMIENTO   not null,
   USUARIO_INSERT       D_CADENA_CORTA       not null,
   FECHA_INSERT         D_FECHA_MOVIMIENTO   not null,
   USUARIO_UPDATE       varchar(15)          not null,
   FECHA_UPDATE         D_FECHA_MOVIMIENTO   null,
   constraint PK_COMPRAS_DEVOLUCIONES primary key (IDCOMPRADEVOLUCION)
);

/*==============================================================*/
/* Table: COMPRAS_DEVOLUCIONES_DET                              */
/*==============================================================*/
create table COMPRAS_DEVOLUCIONES_DET (
   IDCOMPRADEVOLUCION   D_CODIGO_NORMAL      not null,
   IDDEPOSITO           D_CODIGO_NORMAL      not null,
   IDPRODUCTO           D_CODIGO_NORMAL      not null,
   IDCOMPRA             D_CODIGO_NORMAL      not null,
   CANTIDAD             D_CANTIDAD           not null,
   constraint PK_COMPRAS_DEVOLUCIONES_DET primary key (IDCOMPRADEVOLUCION, IDDEPOSITO, IDPRODUCTO, IDCOMPRA)
);

/*==============================================================*/
/* Table: COMPRAS_PAGOS                                         */
/*==============================================================*/
create table COMPRAS_PAGOS (
   IDPAGO               SERIAL               not null,
   IDPERSONA            INT4                 null,
   IDHABILITACION       INT4                 null,
   NRORECIBO            D_CADENA_CORTA       not null,
   FECHAPAGO            D_FECHA              not null,
   TOTALPAGO            D_PRECIO             not null,
   USUARIO_INSERT       D_CADENA_CORTA       not null,
   FECHAREGISTRO        D_FECHA_MOVIMIENTO   not null,
   FECHA_UPDATE         D_FECHA_MOVIMIENTO   not null,
   FECHA_INSERT         TIMESTAMP            null,
   USUARIO_UPDATE       TIMESTAMP            null,
   constraint PK_COMPRAS_PAGOS primary key (IDPAGO)
);

/*==============================================================*/
/* Table: COMPRAS_PAGOS_DETALLES                                */
/*==============================================================*/
create table COMPRAS_PAGOS_DETALLES (
   IDPAGO               D_CODIGO_NORMAL      not null,
   IDCOMPRA             D_CODIGO_NORMAL      not null,
   CUOTA                D_NRO_CORTO          not null,
   TIPOPAGO             D_TIPO               not null,
   MONTO                D_PRECIO             not null,
   NRODOCUMENTO         D_CADENA_CORTA       null,
   constraint PK_COMPRAS_PAGOS_DETALLES primary key (IDPAGO, IDCOMPRA, CUOTA)
);

/*==============================================================*/
/* Table: DEPOSITOS                                             */
/*==============================================================*/
create table DEPOSITOS (
   IDDEPOSITO           SERIAL not null,
   NOMBRE               D_NOMBRE             not null,
   UBICACION            D_DESCRIPCION        null,
   constraint PK_DEPOSITOS primary key (IDDEPOSITO)
);

/*==============================================================*/
/* Table: DIRECCIONES                                           */
/*==============================================================*/
create table DIRECCIONES (
   IDDIRECCION          SERIAL               not null,
   IDTIPODIRECCIONTELEFONO INT4                 null,
   IDPERSONA            INT4                 null,
   CALLE                D_DIRECCION          not null,
   constraint PK_DIRECCIONES primary key (IDDIRECCION)
);

/*==============================================================*/
/* Table: HABILITACIONES                                        */
/*==============================================================*/
create table HABILITACIONES (
   IDHABILITACION       SERIAL               not null,
   IDCAJA               INT4                 null,
   FECHA_APERTURA       DATE                 not null,
   FECHA_CIERRE         DATE                 null,
   ESTADO               D_TIPO               not null,
   constraint PK_HABILITACIONES primary key (IDHABILITACION)
);

/*==============================================================*/
/* Table: PAISES                                                */
/*==============================================================*/
create table PAISES (
   PAIS                 SERIAL               not null,
   NOMBRE               D_NOMBRE             not null,
   constraint PK_PAISES primary key (PAIS)
);

/*==============================================================*/
/* Table: PERSONAS                                              */
/*==============================================================*/
create table PERSONAS (
   IDPERSONA            SERIAL               not null,
   IDTIPO               INT4                 null,
   CIUDAD               INT4                 null,
   IDBARRIO             INT4                 null,
   PAIS                 INT4                 null,
   PRIMER_NOMBRE        D_NOMBRE             not null,
   SEGUNDO_NOMBRE       D_NOMBRE             null,
   PRIMER_APELLIDO      D_NOMBRE             not null,
   SEGUNDO_APELLIDO     D_NOMBRE             null,
   APELLIDO_CASADA      D_NOMBRE             null,
   FECHA_NACIMIENTO     D_FECHA              not null,
   ESTADO_CIVIL         D_TIPO               null,
   SEXO                 D_TIPO               null,
   MAIL                 D_DESCRIPCION        not null,
   constraint PK_PERSONAS primary key (IDPERSONA)
);

/*==============================================================*/
/* Table: PERSONAS_POR_TIPO                                     */
/*==============================================================*/
create table PERSONAS_POR_TIPO (
   IDTIPO               SERIAL               not null,
   IDPERSONA            INT4                 null,
   IDTIPOPERSONA        INT4                 null,
   constraint PK_PERSONAS_POR_TIPO primary key (IDTIPO)
);

/*==============================================================*/
/* Table: PRODUCTOS                                             */
/*==============================================================*/
create table PRODUCTOS (
   IDPRODUCTO           SERIAL not null,
   NOMBRE               D_NOMBRE             not null,
   DESCRIPCION          D_DESCRIPCION        null,
   CODIGO_BARRAS        VARCHAR(100)         null,
   IDIVA                D_CODIGO_NORMAL      not null,
   CATEGORIAS           D_CODIGO_NORMAL      not null,
   PRECIO_COMPRA        D_PRECIO             not null,
   PRECIO_VENTA         D_PRECIO             not null,
   PRECIO_MINIMO        D_PRECIO             not null,
   MARGEN_GANANCIA      D_PRECIO             not null,
   constraint PK_PRODUCTOS primary key (IDPRODUCTO)
);

/*==============================================================*/
/* Table: PRODUCTOSXDEPOSITOS                                   */
/*==============================================================*/
create table PRODUCTOSXDEPOSITOS (
   IDDEPOSITO           D_CODIGO_NORMAL      not null,
   IDPRODUCTO           D_CODIGO_NORMAL      not null,
   DEP_IDDEPOSITO       INT4                 null,
   EXISTENCIA           D_CANTIDAD           not null,
   constraint PK_PRODUCTOSXDEPOSITOS primary key (IDDEPOSITO, IDPRODUCTO)
);

/*==============================================================*/
/* Table: PRODUCTOS_IVA                                         */
/*==============================================================*/
create table PRODUCTOS_IVA (
   IDIVA                SERIAL not null,
   DESCRIPCION          D_DESCRIPCION        null,
   IVA                  D_IVA                not null,
   constraint PK_PRODUCTOS_IVA primary key (IDIVA)
);

/*==============================================================*/
/* Table: RECURSOS                                              */
/*==============================================================*/
create table RECURSOS (
   RECUROS              SERIAL               not null,
   URL                  VARCHAR(200)         not null,
   CREAR                D_BOOLEAN            not null,
   VISUALIZAR           D_BOOLEAN            not null,
   EDITAR               D_BOOLEAN            not null,
   BORRAR               D_BOOLEAN            not null,
   constraint PK_RECURSOS primary key (RECUROS)
);

/*==============================================================*/
/* Table: ROLES                                                 */
/*==============================================================*/
create table ROLES (
   ROL                  SERIAL               not null,
   NOMBRE               D_NOMBRE             not null,
   DESCRIPCION          D_DESCRIPCION        null,
   constraint PK_ROLES primary key (ROL)
);

/*==============================================================*/
/* Table: ROLES_POR_USUARIOS                                    */
/*==============================================================*/
create table ROLES_POR_USUARIOS (
   ROL_POR_USUARIO      SERIAL               not null,
   IDUSUARIO            D_CADENA_CORTA       not null,
   ROL                  INT4                 not null,
   constraint PK_ROLES_POR_USUARIOS primary key (ROL_POR_USUARIO)
);

/*==============================================================*/
/* Table: ROLES_X_RECURSO                                       */
/*==============================================================*/
create table ROLES_X_RECURSO (
   ROL_RECURSO          SERIAL               not null,
   RECUROS              INT4                 null,
   ROL                  INT4                 null,
   constraint PK_ROLES_X_RECURSO primary key (ROL_RECURSO)
);

/*==============================================================*/
/* Table: TELEFONOS                                             */
/*==============================================================*/
create table TELEFONOS (
   IDTELEFONO           SERIAL               not null,
   IDTIPODIRECCIONTELEFONO INT4                 null,
   IDPERSONA            INT4                 null,
   NUMERO               D_DESCRIPCION        not null,
   constraint PK_TELEFONOS primary key (IDTELEFONO)
);

/*==============================================================*/
/* Table: TIPOS_DE_DOCUMENTOS                                   */
/*==============================================================*/
create table TIPOS_DE_DOCUMENTOS (
   IDTIPO               SERIAL               not null,
   NOMBRE               D_DESCRIPCION        not null,
   constraint PK_TIPOS_DE_DOCUMENTOS primary key (IDTIPO)
);

/*==============================================================*/
/* Table: TIPOS_DE_PERSONAS                                     */
/*==============================================================*/
create table TIPOS_DE_PERSONAS (
   IDTIPOPERSONA        SERIAL               not null,
   NOMBRE               D_NOMBRE             not null,
   constraint PK_TIPOS_DE_PERSONAS primary key (IDTIPOPERSONA)
);

/*==============================================================*/
/* Table: TIPO_DIRECCIONES_TELEFONOS                            */
/*==============================================================*/
create table TIPO_DIRECCIONES_TELEFONOS (
   IDTIPODIRECCIONTELEFONO SERIAL               not null,
   NOMBRE               TIMESTAMP            not null,
   constraint PK_TIPO_DIRECCIONES_TELEFONOS primary key (IDTIPODIRECCIONTELEFONO)
);

/*==============================================================*/
/* Table: TRANSFERENCIAS                                        */
/*==============================================================*/
create table TRANSFERENCIAS (
   IDTRANSFERENCIA      SERIAL               not null,
   FECHA                D_FECHA_MOVIMIENTO   not null,
   IDUSUARIO            D_CADENA_CORTA       not null,
   FECHAREGISTRO        D_FECHA_MOVIMIENTO   not null,
   FECHAMODIFICACION    D_FECHA_MOVIMIENTO   not null,
   constraint PK_TRANSFERENCIAS primary key (IDTRANSFERENCIA)
);

/*==============================================================*/
/* Table: TRANSFERENCIAS_DETALLES                               */
/*==============================================================*/
create table TRANSFERENCIAS_DETALLES (
   IDTRANSFERENCIA      D_CODIGO_NORMAL      not null,
   ITEM                 D_CODIGO_NORMAL      not null,
   IDORIGEN             D_CODIGO_NORMAL      not null,
   IDDESTINO            D_CODIGO_NORMAL      not null,
   IDPRODUCTO           D_CODIGO_NORMAL      not null,
   CANTIDAD             D_CANTIDAD           not null,
   constraint PK_TRANSFERENCIAS_DETALLES primary key (IDTRANSFERENCIA, ITEM)
);

/*==============================================================*/
/* Table: USUARIOS                                              */
/*==============================================================*/
create table USUARIOS (
   IDUSUARIO            D_CADENA_CORTA       not null,
   IDPERSONA            INT4                 null,
   CLAVE                D_DIRECCION          not null,
   ESTADO               D_TIPO               not null,
   FECHA_CREACION       D_FECHA              null,
   FECHA_ULTIMO_LOGUEO  D_FECHA_MOVIMIENTO   null,
   FECHA_BAJA           D_FECHA              null,
   constraint PK_USUARIOS primary key (IDUSUARIO)
);

/*==============================================================*/
/* Table: VENTAS                                                */
/*==============================================================*/
create table VENTAS (
   IDVENTA              SERIAL               not null,
   NROFACTURA           D_CADENA_CORTA       not null,
   FECHAVENTA           D_FECHA_MOVIMIENTO   not null,
   CONDICION            D_TIPO               not null,
   TOTALCUOTAS          D_NRO_CORTO          not null,
   FECHACUOTA           D_FECHA              not null,
   TOTAL                D_PRECIO             not null,
   TOTAL_IVA            D_PRECIO             not null,
   IDPROVEEDOR          INT4                 null,
   FECHA_INSERT         D_FECHA_MOVIMIENTO   not null,
   FECHA_UPDATE         D_FECHA_MOVIMIENTO   not null,
   USUARIO_UPDATE       TIMESTAMP            null,
   constraint PK_VENTAS primary key (IDVENTA)
);

/*==============================================================*/
/* Table: VENTAS_CUOTAS                                         */
/*==============================================================*/
create table VENTAS_CUOTAS (
   IDVENTA              D_CODIGO_NORMAL      not null,
   CUOTA                D_NRO_CORTO          not null,
   VENCIMIENTO          D_FECHA              not null,
   MONTO                D_PRECIO             not null,
   SALDO                D_PRECIO             not null,
   ESTADO               D_TIPO               not null,
   constraint PK_VENTAS_CUOTAS primary key (IDVENTA, CUOTA)
);

/*==============================================================*/
/* Table: VENTAS_DETALLES                                       */
/*==============================================================*/
create table VENTAS_DETALLES (
   IDVENTA              D_CODIGO_NORMAL      not null,
   IDDEPOSITO           D_CODIGO_NORMAL      not null,
   IDPRODUCTO           D_CODIGO_NORMAL      not null,
   CANTIDAD             D_CANTIDAD           not null,
   IDIVA                D_CODIGO_NORMAL      not null,
   PRECIOUNITARIO       D_PRECIO             not null,
   TOTALITEM            D_PRECIO             not null,
   TOTALIVA             D_PRECIO             not null,
   constraint PK_VENTAS_DETALLES primary key (IDVENTA, IDDEPOSITO, IDPRODUCTO)
);

/*==============================================================*/
/* Table: VENTAS_DEVOLUCIONES                                   */
/*==============================================================*/
create table VENTAS_DEVOLUCIONES (
   IDVENTASDEVOLUCION   SERIAL               not null,
   IDVENTA              D_CODIGO_NORMAL      not null,
   IDPERSONA            INT4                 null,
   FECHA                D_FECHA_MOVIMIENTO   not null,
   USUARIO_INSERT       D_CADENA_CORTA       not null,
   FECHA_INSERT         D_FECHA_MOVIMIENTO   not null,
   FECHA_UPDATE         D_FECHA_MOVIMIENTO   not null,
   USUARIO_UPDATE       D_CADENA_CORTA       null,
   constraint PK_VENTAS_DEVOLUCIONES primary key (IDVENTASDEVOLUCION)
);

/*==============================================================*/
/* Table: VENTAS_DEVOLUCIONES_DET                               */
/*==============================================================*/
create table VENTAS_DEVOLUCIONES_DET (
   IDVENTASDEVOLUCION   D_CODIGO_NORMAL      not null,
   IDVENTA              D_CODIGO_NORMAL      not null,
   IDDEPOSITO           D_CODIGO_NORMAL      not null,
   IDPRODUCTO           D_CODIGO_NORMAL      not null,
   CANTIDAD             D_CANTIDAD           not null,
   constraint PK_VENTAS_DEVOLUCIONES_DET primary key (IDVENTASDEVOLUCION, IDVENTA, IDDEPOSITO, IDPRODUCTO)
);

/*==============================================================*/
/* Table: VENTAS_DOCUMENTOS                                     */
/*==============================================================*/
create table VENTAS_DOCUMENTOS (
   IDVENTADOCUMENTO     SERIAL not null,
   IDCAJERO             INT4                 null,
   TIMBRADO             D_CADENA_CORTA       not null,
   VENCIMIENTO          D_FECHA              not null,
   DESDE                D_CODIGO_NORMAL      not null,
   HASTA                D_CODIGO_NORMAL      not null,
   ACTUAL               D_CODIGO_NORMAL      not null,
   constraint PK_VENTAS_DOCUMENTOS primary key (IDVENTADOCUMENTO)
);

alter table AJUSTESDETALLES
   add constraint FK_AJUSTESD_REFERENCE_AJUSTES foreign key (IDAJUSTE)
      references AJUSTES (IDAJUSTE)
      on delete cascade on update restrict;

alter table AJUSTESDETALLES
   add constraint FK_AJUSTESD_REFERENCE_PRODUCTO foreign key (IDDEPOSITO, IDPRODUCTO)
      references PRODUCTOSXDEPOSITOS (IDDEPOSITO, IDPRODUCTO)
      on delete restrict on update restrict;

alter table BARRIOS
   add constraint FK_BARRIOS_REFERENCE_CIUDADES foreign key (CIUDAD)
      references CIUDADES (CIUDAD)
      on delete restrict on update restrict;

alter table CATEGORIAS
   add constraint FK_CATEGORI_REFERENCE_CATEGORI foreign key (CAT_PADRE)
      references CATEGORIAS (IDCATEGORIA)
      on delete restrict on update restrict;

alter table COBROS_DETALLES
   add constraint FK_COBROS_D_REFERENCE_COBROS_V foreign key (IDCOBRO)
      references COBROS_VENTAS (IDCOBRO)
      on delete cascade on update restrict;

alter table COBROS_DETALLES
   add constraint FK_COBROS_D_REFERENCE_VENTAS_C foreign key (IDVENTA, CUOTA)
      references VENTAS_CUOTAS (IDVENTA, CUOTA)
      on delete restrict on update restrict;

alter table COBROS_VENTAS
   add constraint FK_COBROS_V_REFERENCE_PERSONAS foreign key (IDCLIENTE)
      references PERSONAS (IDPERSONA)
      on delete restrict on update restrict;

alter table COBROS_VENTAS
   add constraint FK_COBROS_V_REFERENCE_HABILITA foreign key (IDHABILITACION)
      references HABILITACIONES (IDHABILITACION)
      on delete restrict on update restrict;

alter table COMPRAS
   add constraint FK_COMPRAS_REFERENCE_PERSONAS foreign key (IDPERSONA)
      references PERSONAS (IDPERSONA)
      on delete restrict on update restrict;

alter table COMPRAS_CUOTAS
   add constraint FK_COMPRAS__REFERENCE_CUOTAS foreign key (IDCOMPRA)
      references COMPRAS (IDCOMPRA)
      on delete cascade on update restrict;

alter table COMPRAS_DETALLES
   add constraint FK_COMPRAS__REFERENCE_PRODUCTO foreign key (IDIVA)
      references PRODUCTOS_IVA (IDIVA)
      on delete restrict on update restrict;

alter table COMPRAS_DETALLES
   add constraint FK_COMPRAS__REFERENCE_COMPRAS1 foreign key (IDCOMPRA)
      references COMPRAS (IDCOMPRA)
      on delete cascade on update restrict;

alter table COMPRAS_DETALLES
   add constraint FK_COMPRAS__REFERENCE_PRODUCTO3 foreign key (IDDEPOSITO, IDPRODUCTO)
      references PRODUCTOSXDEPOSITOS (IDDEPOSITO, IDPRODUCTO)
      on delete restrict on update restrict;

alter table COMPRAS_DEVOLUCIONES
   add constraint FK_COMPRAS__REFERENCE_COMPRAS foreign key (IDCOMPRA)
      references COMPRAS (IDCOMPRA)
      on delete restrict on update restrict;

alter table COMPRAS_DEVOLUCIONES
   add constraint FK_COMPRAS__REFERENCE_PERSONAS foreign key (IDPERSONA)
      references PERSONAS (IDPERSONA)
      on delete restrict on update restrict;

alter table COMPRAS_DEVOLUCIONES_DET
   add constraint FK_COMPRAS__REFERENCE_COMPRAS5 foreign key (IDCOMPRADEVOLUCION)
      references COMPRAS_DEVOLUCIONES (IDCOMPRADEVOLUCION)
      on delete cascade on update restrict;

alter table COMPRAS_DEVOLUCIONES_DET
   add constraint FK_COMPRAS__REFERENCE_COMPRAS_ foreign key (IDCOMPRA, IDDEPOSITO, IDPRODUCTO)
      references COMPRAS_DETALLES (IDCOMPRA, IDDEPOSITO, IDPRODUCTO)
      on delete restrict on update restrict;

alter table COMPRAS_PAGOS
   add constraint FK_COMPRAS__REFERENCE_PERSONAS foreign key (IDPERSONA)
      references PERSONAS (IDPERSONA)
      on delete restrict on update restrict;

alter table COMPRAS_PAGOS
   add constraint FK_COMPRAS__REFERENCE_HABILITA foreign key (IDHABILITACION)
      references HABILITACIONES (IDHABILITACION)
      on delete restrict on update restrict;

alter table COMPRAS_PAGOS_DETALLES
   add constraint FK_COMPRAS__REFERENCE_COMPRAS3 foreign key (IDPAGO)
      references COMPRAS_PAGOS (IDPAGO)
      on delete cascade on update restrict;

alter table COMPRAS_PAGOS_DETALLES
   add constraint FK_COMPRAS__REFERENCE_COMPRAS_ foreign key (IDCOMPRA, CUOTA)
      references COMPRAS_CUOTAS (IDCOMPRA, CUOTA)
      on delete restrict on update restrict;

alter table DIRECCIONES
   add constraint FK_DIRECCIO_REFERENCE_TIPO_DIR foreign key (IDTIPODIRECCIONTELEFONO)
      references TIPO_DIRECCIONES_TELEFONOS (IDTIPODIRECCIONTELEFONO)
      on delete restrict on update restrict;

alter table DIRECCIONES
   add constraint FK_DIRECCIO_REFERENCE_PERSONAS foreign key (IDPERSONA)
      references PERSONAS (IDPERSONA)
      on delete restrict on update restrict;

alter table HABILITACIONES
   add constraint FK_HABILITA_REFERENCE_CAJAS foreign key (IDCAJA)
      references CAJAS (IDCAJA)
      on delete restrict on update restrict;

alter table PERSONAS
   add constraint FK_PERSONAS_REFERENCE_TIPOS_DE foreign key (IDTIPO)
      references TIPOS_DE_DOCUMENTOS (IDTIPO)
      on delete restrict on update restrict;

alter table PERSONAS
   add constraint FK_PERSONAS_REFERENCE_CIUDADES foreign key (CIUDAD)
      references CIUDADES (CIUDAD)
      on delete restrict on update restrict;

alter table PERSONAS
   add constraint FK_PERSONAS_REFERENCE_BARRIOS foreign key (IDBARRIO)
      references BARRIOS (IDBARRIO)
      on delete restrict on update restrict;

alter table PERSONAS
   add constraint FK_PERSONAS_REFERENCE_PAISES foreign key (PAIS)
      references PAISES (PAIS)
      on delete restrict on update restrict;

alter table PERSONAS_POR_TIPO
   add constraint FK_PERSONAS_REFERENCE_PERSONAS foreign key (IDPERSONA)
      references PERSONAS (IDPERSONA)
      on delete restrict on update restrict;

alter table PERSONAS_POR_TIPO
   add constraint FK_PERSONAS_REFERENCE_TIPOS_DE foreign key (IDTIPOPERSONA)
      references TIPOS_DE_PERSONAS (IDTIPOPERSONA)
      on delete restrict on update restrict;

alter table PRODUCTOS
   add constraint FK_PRODUCTO_REFERENCE_PRODUCTO2 foreign key (IDIVA)
      references PRODUCTOS_IVA (IDIVA)
      on delete restrict on update restrict;

alter table PRODUCTOS
   add constraint FK_PRODUCTO_REFERENCE_CATEGORI foreign key (CATEGORIAS)
      references CATEGORIAS (IDCATEGORIA)
      on delete restrict on update restrict;

alter table PRODUCTOSXDEPOSITOS
   add constraint FK_PRODUCTO_REFERENCE_DEPOSITO foreign key (DEP_IDDEPOSITO)
      references DEPOSITOS (IDDEPOSITO)
      on delete cascade on update restrict;

alter table PRODUCTOSXDEPOSITOS
   add constraint FK_PRODUCTO_REFERENCE_PRODUCTO1 foreign key (IDPRODUCTO)
      references PRODUCTOS (IDPRODUCTO)
      on delete cascade on update restrict;

alter table ROLES_POR_USUARIOS
   add constraint FK_ROLES_PO_REFERENCE_USUARIOS foreign key (IDUSUARIO)
      references USUARIOS (IDUSUARIO)
      on delete restrict on update restrict;

alter table ROLES_POR_USUARIOS
   add constraint FK_ROLES_PO_REFERENCE_ROLES foreign key (ROL)
      references ROLES (ROL)
      on delete restrict on update restrict;

alter table ROLES_X_RECURSO
   add constraint FK_ROLES_X__REFERENCE_RECURSOS foreign key (RECUROS)
      references RECURSOS (RECUROS)
      on delete restrict on update restrict;

alter table ROLES_X_RECURSO
   add constraint FK_ROLES_X__REFERENCE_ROLES foreign key (ROL)
      references ROLES (ROL)
      on delete restrict on update restrict;

alter table TELEFONOS
   add constraint FK_TELEFONO_REFERENCE_TIPO_DIR foreign key (IDTIPODIRECCIONTELEFONO)
      references TIPO_DIRECCIONES_TELEFONOS (IDTIPODIRECCIONTELEFONO)
      on delete restrict on update restrict;

alter table TELEFONOS
   add constraint FK_TELEFONO_REFERENCE_PERSONAS foreign key (IDPERSONA)
      references PERSONAS (IDPERSONA)
      on delete restrict on update restrict;

alter table TRANSFERENCIAS_DETALLES
   add constraint FK_TRANSFER_REFERENCE_TRANSFER foreign key (IDTRANSFERENCIA)
      references TRANSFERENCIAS (IDTRANSFERENCIA)
      on delete restrict on update restrict;

alter table TRANSFERENCIAS_DETALLES
   add constraint FK_TRANSFER_REFERENCE_PRODUCTO3 foreign key (IDORIGEN, IDPRODUCTO)
      references PRODUCTOSXDEPOSITOS (IDDEPOSITO, IDPRODUCTO)
      on delete restrict on update restrict;

alter table TRANSFERENCIAS_DETALLES
   add constraint FK_TRANSFER_REFERENCE_PRODUCTO foreign key (IDDESTINO, IDPRODUCTO)
      references PRODUCTOSXDEPOSITOS (IDDEPOSITO, IDPRODUCTO)
      on delete restrict on update restrict;

alter table USUARIOS
   add constraint FK_USUARIOS_REFERENCE_PERSONAS foreign key (IDPERSONA)
      references PERSONAS (IDPERSONA)
      on delete restrict on update restrict;

alter table VENTAS
   add constraint FK_VENTAS_REFERENCE_PERSONAS foreign key (IDPROVEEDOR)
      references PERSONAS (IDPERSONA)
      on delete restrict on update restrict;

alter table VENTAS_CUOTAS
   add constraint FK_VENTAS_C_REFERENCE_VENTAS foreign key (IDVENTA)
      references VENTAS (IDVENTA)
      on delete cascade on update restrict;

alter table VENTAS_DETALLES
   add constraint FK_VENT_D_REF_PRODU foreign key (IDDEPOSITO, IDPRODUCTO)
      references PRODUCTOSXDEPOSITOS (IDDEPOSITO, IDPRODUCTO)
      on delete restrict on update restrict;

alter table VENTAS_DETALLES
   add constraint FK_VENT_D_REFER_PRODU foreign key (IDIVA)
      references PRODUCTOS_IVA (IDIVA)
      on delete restrict on update restrict;

alter table VENTAS_DETALLES
   add constraint FK_VENTAS_D_REFERENCE_VENTAS1 foreign key (IDVENTA)
      references VENTAS (IDVENTA)
      on delete cascade on update restrict;

alter table VENTAS_DEVOLUCIONES
   add constraint FK_VENTAS_D_REFERENCE_VENTAS2 foreign key (IDVENTA)
      references VENTAS (IDVENTA)
      on delete restrict on update restrict;

alter table VENTAS_DEVOLUCIONES
   add constraint FK_VENTAS_D_REFERENCE_PERSONAS foreign key (IDPERSONA)
      references PERSONAS (IDPERSONA)
      on delete restrict on update restrict;

alter table VENTAS_DEVOLUCIONES_DET
   add constraint FK_VENT_D_REF_VENT_D foreign key (IDVENTASDEVOLUCION)
      references VENTAS_DEVOLUCIONES (IDVENTASDEVOLUCION)
      on delete cascade on update restrict;

alter table VENTAS_DEVOLUCIONES_DET
   add constraint FK_VEN_D_REFE_VENT_D foreign key (IDVENTA, IDDEPOSITO, IDPRODUCTO)
      references VENTAS_DETALLES (IDVENTA, IDDEPOSITO, IDPRODUCTO)
      on delete restrict on update restrict;

alter table VENTAS_DOCUMENTOS
   add constraint FK_VENTAS_D_REFERENCE_PERSONAS foreign key (IDCAJERO)
      references PERSONAS (IDPERSONA)
      on delete restrict on update restrict;

