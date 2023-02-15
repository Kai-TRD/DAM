/*********Script de Inicialización de la Base de Datos **************/
drop database if exists tienda;
create database tienda;
use tienda;

/*Tabla con la información necesaria para clientes*/
create table clientes(
  dni varchar(8) primary key not null,
  apellidos varchar(30),
  nombre varchar(15),
  fnacimiento date,
  domicilio varchar(30)
 );

/*Tabla con la información necesaria de los articulos comercializados*/
 create table articulos(
  articulo int primary key not null, 
  descripcion varchar(30) not null,
  preciounidad decimal(5,2) not null,
  cod_seccion int
 );

/*Tabla con la información necesaria de los distintas secciones*/
 create table secciones(
  cod_seccion int primary key not null, 
  seccion varchar(30) not null,
  descuento decimal(5,2) not null
 );

/*Tabla con la información necesaria de las facturas*/
create table facturascli(
  factura int primary key not null, 
  dni varchar(8) not null,
  fecha date,
  pagada char(1) /*si está pagada, tendrá valor 's' si no, tendrá valor 'n'*/
);

/*Tabla con la información necesaria de cada línea de cada factura*/
 create table lineasfac(
  factura int not null, 
  linea int not null,
  articulo int not null,
  cantidad decimal (5,2) not null,   
  primary key(factura, linea)
 );

/********************* Carga de registros en tablas ****************/

 insert into clientes values('55888444','Romero', 'Julia','1977-12-18','Andromeda, 13');
 insert into clientes values('77333444','Alvarez','Jose Manuel','2003-03-25','Castellana, 14');
 insert into clientes values('88666444','Granados','Isabel','2001-02-01','Gran Via 9');
 insert into clientes values('99000444','Granados','Marcos', '1999-01-30','Plaza de la Libertad, 20');
 insert into clientes values('66111444','Pereyra','Antonio', '1990-01-15','Sucre 349');
 insert into clientes values('11555444','Perez', 'Juan','1967-02-11','Colon 234');
 insert into clientes values('22777444','Lopez','Marta','1993-11-05','Sarmiento 465');
 insert into clientes values('33999444','Juarez','Maria Isabel','2001-09-26','Caseros 980');
 insert into clientes values('44222444','Pereyra','Marco Antonio', '1992-03-14','PLaza de la Marina, 5');

-- Query para mostrar todos los datos de clientes, incluida su edad, ordenados por edad asc

-- select *, timestampdiff(YEAR, fnacimiento, CURRENT_DATE) as edad from clientes order by edad asc;

-- Añadimos secciones:
 insert into secciones values(1, 'Ferreteria', 0.20);
 insert into secciones values(2, 'Jardineria', 0.00);
 insert into secciones values(3, 'Carnes y pescados',0.40);
 insert into secciones values(4, 'Joyeria/Relojeria',0);
 
-- Añadimos unos articulos
 insert into articulos values(1, 'Salmon fresco', 12, 3);
 insert into articulos values(2, 'Alicates', 25, 1);
 insert into articulos values(3, 'Rollo manguera 10 mt',40, 2);
 insert into articulos values(4, 'Reloj Casio',50, 4);
 insert into articulos values(5, 'Sardina', 7, 3);
 insert into articulos values(6, 'Cinta Americana', 2, 1);
 insert into articulos values(7, 'Sustrato saco 5Kg',18, 2);
 insert into articulos values(8, 'Rolex',500, 4);
 
 
-- 1 Query que muestre el nombre, apellido y edad de todos los clientes ordenados ascendentemente por edad
 select nombre, apellidos, timestampdiff(YEAR, fnacimiento, CURRENT_DATE) as edad from clientes order by fnacimiento asc;

-- 1.1 Una consulta que me devuelva la descripcion de los articulos, su precio por unidad y su precio rebajado
 select a.descripcion, a.preciounidad, round(a.preciounidad*(1-s.descuento), 2) as precio_rebajado from articulos as a join secciones as s on a.cod_seccion = s.cod_seccion;

-- 2 Una consulta que te muestre todos los datos de todas las secciones que no tienen descuento
 select * from secciones where descuento = 0;

-- ***********************************************************************************
-- SUBCONSULTAS 
-- se forman con:  [=/in] (select _______ from ______);
-- ***********************************************************************************

-- ***********************************************************
-- SUBCONSULTA CON =
-- ***********************************************************
-- Una query que devuelva la descripcion y el precio de todos los articulos cuyo precio coincide con el precio maximo
-- Intentemos sin subconsultas
-- Fallaria:
  select descripcion, preciounidad from articulos where preciounidad = max(preciounidad);
-- Con Subconsultas
  select descripcion, preciounidad from articulos where preciounidad = (select max(preciounidad) from articulos);
 
-- Una query que devuelva la descripcion y el precio de todos los articulos cuyo precio coincide con el precio maximo o con el precio minimo
  select descripcion, preciounidad from articulos where preciounidad = (select max(preciounidad) from articulos) or preciounidad = (select min(preciounidad) from articulos);

-- Una query que devuelva la descripcion y el precio de todos los articulos cuyo precio coincide con el precio esta por debajop del precio medio de los articulos
  select descripcion, preciounidad from articulos where preciounidad < (select avg(preciounidad) from articulos);
 
-- ***********************************************************
-- SUBCONSULTA CON IN
-- ***********************************************************
-- Una query que devuelva la descripcion y el precio de todos los articulos cuyo precio coincida con la mitad del precio de algun articulo que empiece por 'R' o 'A'
-- empiezo primero con la subconsulta para usarlo despues como conjunto
  select round(preciounidad/2,2) as La_Mitad from articulos where descripcion like 'R%' or descripcion like 'A%';
-- El resultado:
  select descripcion, preciounidad from articulos where preciounidad in (select round(preciounidad/2,2) from articulos where descripcion like 'R%' or descripcion like 'A%');

-- Una query para mostrar los importes de todos los articulos par cada seccion
  select s.seccion, sum(a.preciounidad) from secciones as s join articulos as a on a.cod_seccion = s.cod_seccion group by (s.seccion);

-- Una query para mostrar los importes de todos los articulos par cada seccion, siempre que dicha suma no supere los 500€
  select s.seccion, sum(a.preciounidad) from secciones as s join articulos as a on a.cod_seccion = s.cod_seccion group by (s.seccion) having sum(a.preciounidad) <= 500;







  