drop database if exists tienda;
create database tienda;
use tienda;
drop database if exists cliente;
create table cliente(
    cod_cliente int auto_increment primary key,
    nombre varchar(10) not null,
    ape1 varchar(10) not null,
    ape2 varchar(10),
    edad int
);
drop database if exists factura;
create table factura(
    cod_factura int primary key,
    fecha_factura date not null,
    importe numeric(5,2),
    cod_cliente int,
    foreign key (cod_cliente) references cliente(cod_cliente)
);
insert into cliente values(15,'facro','Peter',null,30);
insert into cliente (nombre,ape1,edad)values('facro','Peter',30);
insert into factura values(1435,'2022-03-12',58.50, 15);

drop database if exists articulo;
create table articulo(
    cod_articulo int primary key,
    descripcion varchar(25) not null,
    precio numeric(5,2)
);

drop database if exists art_fac;
create table art_fac(
    cod_fac int,
    cod_art int,
    cantidad int,
    primary key(cod_fac, cod_art),
    foreign key (cod_fac) references factura(cod_factura),
    foreign key (cod_art) references articulo(cod_articulo)
);
insert into articulo values(125,'8 GB Memoria Ram',50.00);
insert into articulo values(126,'Placa base ASUS',99.00);
insert into articulo values(127,'Procesadir Intel i7',185.00);
insert into art_fac values(1435,125,5);
insert into art_fac values(1435,126,2);
insert into art_fac values(1435,127,1);