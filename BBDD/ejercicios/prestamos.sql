drop table if exists libros, socios, prestamos;
 
 create table libros(
  codigo int unsigned auto_increment,
  titulo varchar(40) not null,
  autor varchar(20) default 'Desconocido',
  primary key (codigo)
 );

 create table socios(
  codigosocio char(8) not null,
  nombre varchar(30),
  domicilio varchar(30),
  primary key (codigosocio)
 );

 create table prestamos(
  codigosocio char(8) not null,
  codigolibro int unsigned,
  fechaprestamo date not null,
  fechadevolucion date,
  primary key (codigolibro,fechaprestamo)
 );


 insert into socios values('22333444','Juan Perez','Colon 345');
 insert into socios values('23333444','Luis Lopez','Caseros 940');
 insert into socios values('25333444','Ana Herrero','Sucre 120');

 insert into libros values(1,'Manual de 2º grado','Molina Manuel');
 insert into libros values(25,'Aprenda PHP','Oscar Mendez');
 insert into libros values(42,'Martin Fierro','Jose Hernandez');

 insert into prestamos values('22333444',1,'2016-08-10','2016-08-12');
 insert into prestamos values('22333444',1,'2016-08-15',null);
 insert into prestamos values('25333444',25,'2016-08-10','2016-08-13');
 insert into prestamos values('25333444',42,'2016-08-10',null);
 insert into prestamos values('25333444',25,'2016-08-15',null);
 insert into prestamos values('30333444',42,'2016-08-02','2016-08-05');
 insert into prestamos values('25333444',2,'2016-08-02','2016-08-05');

 select * from prestamos;

 -- Para obtener los datos completos de cada préstamo,
 -- necesitamos consultar las tres tablas.
 select nombre,titulo,fechaprestamo
  from prestamos as p
  join socios as s
  on s.codigosocio=p.codigosocio
  join libros as l
  on codigolibro=codigo;


 -- Para ver todos los prestamos, incluso los que no encuentran coincidencia
 --  en las otras tablas, usamos:
 select nombre,titulo,fechaprestamo
  from prestamos as p
  left join socios as s
  on p.codigosocio=s.codigosocio
  left join libros as l
  on l.codigo=p.codigolibro;


 -- Podemos ver aquellos prestamos con valor coincidente para "libros" pero 
 -- para "socio" con y sin coincidencia:
 select nombre,titulo,fechaprestamo
  from prestamos as p
  left join socios as s
  on p.codigosocio=s.codigosocio
  join libros as l
  on p.codigolibro=l.codigo;

 
 -- Todos los datos de los socios que tienen libros sin devolver y los títulos de los libros
 select socios.codigosocio, nombre, domicilio, titulo from socios join prestamos join libros on
 (fechadevolucion is null) and (socios.codigosocio = prestamos.codigosocio) and (prestamos.codigolibro =
 libros.codigo);
 
 -- Todos los datos de los socios que tienen libros sin devolver y los títulos de los libros
 select s.codigosocio, nombre, domicilio, titulo from socios as s join prestamos as p join libros as l on
 (fechadevolucion is null) and (s.codigosocio = p.codigosocio) and (p.codigolibro = l.codigo);
 
 -- Todos los datos de los socios que tienen libros sin devolver y los títulos de los libros
 select s.codigosocio, nombre, domicilio, titulo from socios as s join prestamos as p join libros as l on
 (fechadevolucion is null) and (s.codigosocio = p.codigosocio) and (p.codigolibro = l.codigo) and timestampdiff(day, fechaprestamo, current_date);
 
 
 -- Toda la información de los socios y los libres que están devueltos
  select s.codigosocio, nombre, domicilio, codigo, titulo, multadiaria from socios as s join prestamos as p join
  libros as l on (fechadevolucion is not null) and (s.codigosocio = p.codigosocio) and (p.codigolibro = l.codigo);