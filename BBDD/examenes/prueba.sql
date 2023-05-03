drop table if exists libros;
create database libros;
use libros;

create table libros(
  codigo int unsigned auto_increment,
  titulo varchar(40) not null,
  autor varchar(30),
  editorial varchar (20),
  precio decimal(5,2) unsigned,
  primary key(codigo)
 );

alter table libros
  add cantidad smallint unsigned not null;

describe libros;

select 'Apartados relativos a alter table:';

    select '49	Agregar campos a una tabla (alter table - add)';
        alter table libros
            add edicion date;
            /*add [field_name] [type];*/
        describe libros;
    select '50	Eliminar campos de una tabla (alter table - drop)';
        alter table libros
            drop codigo;
            /* drop [field_name, field_name];*/
        describe libros;

    select '51	Modificar campos de una tabla (alter table - modify)';
        alter table libros
            modify cantidad int;
            /* modify [field_name] [new_type]; */
        describe libros;

    select '52	Cambiar el nombre de un campo de una tabla (alter table - change)';
        alter table libros
            change editorial cosarara varchar(20);
            /* change [old_field_name] [new_field_name] [type];*/
        describe libros;

    select '53	Agregar y eliminar la clave primaria (alter table - primary key)';
    /* ADD PRIMARY KEY */
        alter table libros
            add primary key (precio, titulo);
            /* add primary key ([field_name], [field_name]);*/
        describe libros;
    
    /* DROP PRIMARY KEY */
        alter table libros
            drop primary key;
            /* drop primary key; = remove all PK*/
        describe libros;

    select '54	Agregar índices(alter table - add index)';
        alter table libros
            add index i_editorial (autor, cantidad);
            /* add index [new_index_name] ([field_namem], [field_name]);*/
            /* indice unico = mas de 2 cosas*/
        show index from libros;

    select '55	Borrado de índices (alter table - drop index)';
        alter table libros
            drop index i_editorial;
            /* drop index [existing_index_name] */
        show index from libros;

    select '56	renombrar tablas (alter table - rename - rename table)';

        drop table if exists contactos;/* elimino tabla contactos si existe */
        show tables;/* Muestro tab  las */

        alter table libros rename contactos;/* cambio el nombre de la tabla libros por contactos */
        /* alter table [actual_table_name] rename [new_table_name] */
        show tables;/* muestro tabla */


select 'Apartados relativos a actualizaciones de tablas en función de los contenidos de otras tablas:';

    select '73	Crear tabla a partir de otra (create - insert)';    
        
        -- Crearemos la tabla "editoriales" con el campo necesario consultando la tabla "libros"
        -- y en el mismo momento insertaremos la información:
        create table editoriales
        select distinct editorial as nombre
        from libros;

        select * from editoriales;

        describe editoriales;

        -- Queremos crear una tabla llamada "cantidadporeditorial" que contenga la 
        -- cantidad de libros de cada editorial.
        -- Eliminamos la tabla "cantidadporeditorial" si existe:
        drop table if exists cantidadporeditorial;

        create table cantidadporeditorial
        select editorial as nombre,count(*) as cantidad
        from libros
        group by editorial;

    select '74	Crear tabla a partir de otras (create - insert - join)';    


    select '76	Insertar registros con valores de otra tabla (insert - select)';    


    select '77	Insertar registros con valores de otra tabla (insert - select - join)';    


    select '78	Actualizar datos con valores de otra tabla (update)';    


    select '79	Actualización en cascada (update - join)';    


    select '80	Borrar registros consultando otras tablas (delete - join)';    


    select '81	Borrar registros buscando coincidencias en otras tablas (delete - join)';    


    select '82	Borrar registros en cascada (delete - join)';    













