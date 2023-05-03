drop database prueba;
create database prueba;
use prueba;

create table motores (
id_motor int,
bastidor_asociado varchar (12),
nombre_motor varchar (20) not null,
tipomotor enum ('Eléctrico', 'Híbrido', 'Gasolina', 'Diésel') not null,
primary key (id_motor)
);

create table componentes (
id_componente int,
nombre_componente varchar (20) not null,
precio decimal (7,2) not null,
precio_rebajado decimal (7,2) not null,
id_motor int not null,

primary key (id_componente)
);

insert into motores values (1, 'AX563300', 'motor_1', 'Gasolina');
insert into motores values (2, 'NY000567', 'motor_2', 'Eléctrico');
insert into componentes values (1, 'componente_1', 150.00, 145.90, 1);
insert into componentes values (2, 'componente_2', 39.00, 37.50, 1);
insert into componentes values (3, 'componente_3', 96.00, 89.25, 2);

describe motores;

select 'Ejercicio 1:';
-- Escribe las instrucciones necesarias para añadirle a la tabla "componentes" un campo de tipo fecha llamado "fecha_fabricacion" que pueda contener valores null.
    alter table componentes add fecha_fabricacion date null;
    describe componentes;
select 'Ejercicio 2:';
-- Escribe las instrucciones necesarias para eliminar en la tabla "componentes" el campo "precio_rebajado".
    alter table componentes drop precio_rebajado;
    describe componentes;
select 'Ejercicio 3:';
-- Escribe las instrucciones necesarias para quitar la clave primaria que tiene la tabla motores y asisgnársela al campo "bastidor_asociado".
    describe motores;
    alter table motores drop primary key;
    describe motores;
    alter table motores add primary key (bastidor_asociado);
    describe motores;
select 'Ejercicio 4:';
-- Escribe las instrucciones necesarias para añadir a la tabla "motores" un índice único para el campo "id_motor", llamado "i_id_motor".
    alter table motores add unique i_id_motor (id_motor);
    show index from motores;
select 'Ejercicio 5:';
-- Escribe las instrucciones necesarias para eliminar el índice creado en el ejercicio 4.
    alter table motores drop index i_id_motor;
    show index from motores;

select 'Ejercicio 6:';
-- Escribe las instrucciones necesarias para que los campos "nombre_motor" de la tabla "motores" y "nombre_componente" de la tabla "componentes" puedan almacenar hasta 30 caracteres.
    alter table motores modify nombre_motor varchar(30);
    alter table componentes modify nombre_componente varchar(30);
    describe motores;
    describe componentes;


-- Se eliminar el ejercicio 7



select 'Ejercicio 8:';
-- Escribe las instrucciones necesarias intercambiar los nombres de las dos tablas, de tal forma que "componentes" pase a llamarse "motores" y "motores" se llame "componerntes".
-- Escribe las instrucciones necesarias para que se muestren las estructuras de las dos tablas antes y después de intercambiar los nombres.
-- Deshaz los cambios llevados a cabo para que vuelvan a quedar como estaban inicialmente
    
    /* tabla origuinal */
    describe motores;
    describe componentes;
    
    /* tabla cambiada */
    alter table componentes rename temporal;
    alter table motores rename componentes;
    alter table temporal rename motores;
    describe motores;
    describe componentes;
    
    /* devuelvo todo como estaba antes */
    alter table motores rename temporal;
    alter table componentes rename motores;
    alter table temporal rename componentes;
    describe motores;
    describe componentes;



select 'Ejercicio 9:';
-- Escribe las instrucciones necesarias para crear una tabla llamada "componentes_motor" que muestre los campos "nombre_componente", "precio" y el campo "nombre_del_motor"  
    create table componentes_motor (
        nombre_componente varchar(20) not null,
        precio DECIMAL(7,2) not null,
        nombre_del_motor VARCHAR(20) not null
    );

    select c.nombre_componente, c.precio, m.nombre_motor as nombre_del_motor from componentes c join motores m on c.id_motor = m.id_motor;
    insert into componentes_motor (nombre_componente, precio, nombre_del_motor)
        select c.nombre_componente, c.precio, m.nombre_motor from componentes c join motores m on c.id_motor = m.id_motor;



select 'Ejercicio 10:';
-- Escribe las instrucciones necesarias para crear una tabla llamada "total_componentes_por_motor" (a partir de las tabla "motores" y "componentes") que contendra un campo
-- llamado "motor" obtenido a partir de los nombres de motor y otro llamado "total_componentes" que indicará cuantos componentes tiene cada motor. 

    create table total_componentes_por_motor select m.nombre_motor as motor, count(*) as total_componentes from motores as m join componentes as c on m.id_motor = c.id_motorgroup by m.id_motor;

select 'Ejercicio 11:';
-- Escribe las instrucciones necesarias para que al borrar un motor de la base de datos mediante la instrucción siguiente:
-- delete from motores where id_motor = 2;
-- ...automáticamente se borren también sus componentes asociados.:

    delete motores join componentes where id_motor = 2;

select 'Ejercicio 12:';
-- Reescribe la instrucción "delete..." anterior, de manera que al realizar el borrado del motor cuyo "id_motor" sea = 2 y sus componentes, no sea necesario usar una Foreign Key.


select 'Ejercicio 13:';
-- Escribe las instrucciones necesarias para generar una tabla llamada "descuentos" a partir de la tabla componentes, que tendrá los campos:
-- "nombre_componente", "precio_componente" e "importe_a_descontar", calculado este último como la diferencia entre los campos "precio" y "precio_rebajado"

    drop database prueba;
    create database prueba;
    use prueba;

    create table motores (
    id_motor int,
    bastidor_asociado varchar (12),
    nombre_motor varchar (20) not null,
    tipomotor enum ('Eléctrico', 'Híbrido', 'Gasolina', 'Diésel') not null,
    primary key (id_motor)
    );

    create table componentes (
    id_componente int,
    nombre_componente varchar (20) not null,
    precio decimal (7,2) not null,
    precio_rebajado decimal (7,2) not null,
    id_motor int not null,

    primary key (id_componente)
    );

    insert into motores values (1, 'AX563300', 'motor_1', 'Gasolina');
    insert into motores values (2, 'NY000567', 'motor_2', 'Eléctrico');
    insert into componentes values (1, 'componente_1', 150.00, 145.90, 1);
    insert into componentes values (2, 'componente_2', 39.00, 37.50, 1);
    insert into componentes values (3, 'componente_3', 96.00, 89.25, 2);

    create table descuento select nombre_componente, precio, (precio - precio_rebajado) as importe_a_descontar from componentes;
    
    show tables;
    describe descuento;

select 'Ejercicio 14:';
-- Escribe las instrucciones necesarias para que al actualizar el valor de "id_motor" en la tabla "motores" a su valor actual + 5, se actualice
-- dicho campo igualmente en la tabla componentes:
-- Hacerlo de dos formas:
-- Con JOIN:
update componentes join motores on componentes.id_motor = motores.id_motor set componentes.id_motor = motores.id_motor + 5;

-- Sin JOIN:
update motores, componentes
    set motores.id_motor = motores.id_motor + 5, componentes.id_motor = componentes.id_motor + 5 where motores.id_motor = componentes.id_motor;



























