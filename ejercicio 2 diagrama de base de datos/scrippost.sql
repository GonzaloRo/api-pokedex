/*==============================================================*/
/* DBMS name:      PostgreSQL 8                                */
                        
/*==============================================================*/


/*==============================================================*/
/* Table: DETALLEORDEN                                          */
/*==============================================================*/
create table DETALLEORDEN (
   ID_PRODUCTO          INT4                 not null,
   ID_ORDEN             INT4                 not null,
   CANTIDAD             FLOAT8               not null,
   TOTALPORPRODUC       FLOAT8               not null,
   constraint PK_DETALLEORDEN primary key (ID_ORDEN)
);

/*==============================================================*/
/* Index: DETALLEORDEN_PK                                       */
/*==============================================================*/
create unique index DETALLEORDEN_PK on DETALLEORDEN (
ID_ORDEN
);

/*==============================================================*/
/* Index: SOLICITADOEN_FK                                       */
/*==============================================================*/
create  index SOLICITADOEN_FK on DETALLEORDEN (
ID_PRODUCTO
);

/*==============================================================*/
/* Table: ORDEN                                                 */
/*==============================================================*/
create table ORDEN (
   ID_ORDEN             INT4                 not null,
   NOMBRE_USUARIO       CHAR(100)            not null,
   TOTAL                FLOAT8               null,
   HORAPEDIDO           CHAR(9)              null,
   constraint PK_ORDEN primary key (ID_ORDEN)
);

/*==============================================================*/
/* Index: ORDEN_PK                                              */
/*==============================================================*/
create unique index ORDEN_PK on ORDEN (
ID_ORDEN
);

/*==============================================================*/
/* Table: PRODUCTO                                              */
/*==============================================================*/
create table PRODUCTO (
   ID_PRODUCTO          INT4                 not null,
   ID_TIENDA            INT4                 not null,
   NOMBRE_PRODUCTO      CHAR(20)             not null,
   IMAGEN               CHAR(60)             not null,
   PRECIO               FLOAT8               not null,
   STOCK                FLOAT8               not null,
   constraint PK_PRODUCTO primary key (ID_PRODUCTO)
);

/*==============================================================*/
/* Index: PRODUCTO_PK                                           */
/*==============================================================*/
create unique index PRODUCTO_PK on PRODUCTO (
ID_PRODUCTO
);

/*==============================================================*/
/* Index: VENDE_FK                                              */
/*==============================================================*/
create  index VENDE_FK on PRODUCTO (
ID_TIENDA
);

/*==============================================================*/
/* Table: SERVICIO                                              */
/*==============================================================*/
create table SERVICIO (
   ID_SERVICIO          INT4                 not null,
   TIPOSERVIC           CHAR(25)             not null,
   constraint PK_SERVICIO primary key (ID_SERVICIO)
);

/*==============================================================*/
/* Index: SERVICIO_PK                                           */
/*==============================================================*/
create unique index SERVICIO_PK on SERVICIO (
ID_SERVICIO
);

/*==============================================================*/
/* Table: TIENDA                                                */
/*==============================================================*/
create table TIENDA (
   ID_TIENDA            INT4                 not null,
   ID_SERVICIO          INT4                 not null,
   NOMBREDUENO          CHAR(100)            not null,
   TELEFONO             CHAR(8)              not null,
   CORREOELEC           CHAR(40)             not null,
   NOMBRE               CHAR(40)             not null,
   constraint PK_TIENDA primary key (ID_TIENDA)
);

/*==============================================================*/
/* Index: TIENDA_PK                                             */
/*==============================================================*/
create unique index TIENDA_PK on TIENDA (
ID_TIENDA
);

/*==============================================================*/
/* Index: BRINDA_FK                                             */
/*==============================================================*/
create  index BRINDA_FK on TIENDA (
ID_SERVICIO
);

alter table DETALLEORDEN
   add constraint FK_DETALLEO_POSEE_ORDEN foreign key (ID_ORDEN)
      references ORDEN (ID_ORDEN)
      on delete restrict on update restrict;

alter table DETALLEORDEN
   add constraint FK_DETALLEO_SOLICITAD_PRODUCTO foreign key (ID_PRODUCTO)
      references PRODUCTO (ID_PRODUCTO)
      on delete restrict on update restrict;

alter table PRODUCTO
   add constraint FK_PRODUCTO_VENDE_TIENDA foreign key (ID_TIENDA)
      references TIENDA (ID_TIENDA)
      on delete restrict on update restrict;

alter table TIENDA
   add constraint FK_TIENDA_BRINDA_SERVICIO foreign key (ID_SERVICIO)
      references SERVICIO (ID_SERVICIO)
      on delete restrict on update restrict;

