drop database if exists pruebas;
create database pruebas;
use pruebas;

create table if not exists libros(
    codigo int,
    nombre varchar(50),
    autor varchar(30),
    editorial varchar(20),
    costo decimal(5,2)
);



insert into libros values (1,'El aleph','Borges','Emece',23.5);
insert into libros values (2,'Alicia en el pais de las maravillas','Lewis Carroll','Planeta',15);
insert into libros values (3,'Matematica estas ahi','Paenza','Emece',34.6);
insert into libros values (4,'Martin Fierro','Jose Hernandez','Paidos',43.5);
insert into libros values (5,'Martin Fierro','Jose Hernandez','Planeta',12);
insert into libros values (6,'Aprenda PHP','Mario Molina','Paidos',21.8);
insert into libros values (7,'Aprenda Java','Mario Molina','Paidos',55.4);
insert into libros values (8,'Alicia a traves del espejo','Lewis Carroll','Emece',18);
insert into libros values (9,'Antologia poetica','Borges','Paidos',47.9);

    describe libros;

-- 1 Haz una clave primaria para el campo codigo. Haz un describe table para ver los cambios.
    alter table libros add primary key(codigo);
    describe libros;

-- 2 Añade un índice múltiple (indice normal) para el campo autor
    alter table libros add index i_autor (autor);
    describe libros;

-- 3 Suponemos que no deben repetirse en la tabla valores duplicados para títulos.
-- Realiza las acciones oportunas para que el gestor de error en caso de que vaya a ocurrir
    alter table libros add unique iu_nombre (nombre);
    describe libros;

-- 4 Cambia el nombre del campo "costo" por "precio" y el del campo "nombre" por "titulo"
    alter table libros rename column costo to precio;
    alter table libros rename column nombre to titulo;
    describe libros;

-- 5 Cambia la longitud del campo titulo a 50 caracteres máximo
    alter table libros modify titulo varchar(50) not null;
    describe libros;

-- 6 Añade un nuevo campo de tipo int llamado "stock" cuyo valor por defecto será 1. Este campor no podrá ser nulo
    alter table libros add stock int not null default 1;
    describe libros;
    select * from libros;

-- 7 A partir de la tabla libros, genera una tabla llamada lirbos_v2 obtenida a partir de una consulta
-- que recorra la tabla libros de forma descendente por código y obtenga la nueva tabla con el
-- campo codigo autoincremental y no aparezaca las editoriales
    create table lirbos_v2
    select codigo, titulo, autor, precio, stock from libros order by codigo desc;
    alter table lirbos_v2 modify codigo int auto_increment primary key;
    describe lirbos_v2;
    select * from lirbos_v2;