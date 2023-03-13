/*Hemos aprendido cómo ver todos los registros de una tabla:

select nombre, clave from padres;
El comando "select" recupera los registros de una tabla. Detallando los nombres de los campos separados por comas, indicamos que seleccione todos los campos de la tabla que nombramos.

Existe una cláusula, "where" que es opcional, con ella podemos especificar condiciones para la consulta "select". Es decir, podemos recuperar algunos registros, sólo los que cumplan con ciertas condiciones indicadas con la cláusula "where". Por ejemplo, queremos ver el padres cuyo nombre es "MarioPerez", para ello utilizamos "where" y luego de ella, la condición:

select nombre, clave from padress where nombre='MarioPerez';
Para las condiciones se utilizan operadores relacionales (tema que trataremos más adelante en detalle). El signo igual(=) es un operador relacional. Para la siguiente selección de registros especificamos una condición que solicita los padress cuya clave es igual a 'bocajunior':

select nombre, clave from padress where clave='bocajunior';
Si ningún registro cumple la condición establecida con el "where", no aparecerá ningún registro.

Servidor de MySQL instalado en forma local.
Ingresemos al programa "Workbench" y ejecutamos los siguientes comandos SQL:

-- Creamos clave en nombre
*/
drop database if exists tablaUsuarios;
create database tablaUsuarios;
Use tablaUsuarios;

drop table if exists hijos;
drop table if exists padres;

create table padres (
  dni_padre varchar(10) primary key,
  nombre varchar(30),
  apellido varchar(30),
  sueldo decimal (6,2),
  r_irpf decimal (4,2),
  r_ss decimal (4,2)
);

create table hijos (
  dni_hijo varchar(10) primary key,
  nombre varchar(30),
  apellido varchar(30),
  fecha_nacimiento date,
  dni_padre varchar (10),
  foreign key (dni_padre) references padres(dni_padre)
);

describe padres;
describe hijos;

insert into padres values ('23463745-T','Leonardo','Payaso', 1387.56, 0.15, 0.20);
insert into padres values ('68941259-H','Donatello','Garcia', 1755.89, 0.15, 0.20);
insert into padres values ('85736122-P','Alfonso','Jimenez', 2755.89, 0.15, 0.20);
insert into padres (dni_padre, nombre, apellido, sueldo, r_irpf, r_ss) values ('80001312-O','Freemans','Gon', 1499.99, 0.15, 0.20);

/* Insertamos dos hijos a Leonardo */
insert into hijos (dni_hijo, nombre, apellido,fecha_nacimiento, dni_padre) values ('31456167-J','Antonio','Jimenez','1998/03/07', '23463745-T');
insert into hijos (dni_hijo, nombre, apellido,fecha_nacimiento, dni_padre) values ('95483281-F','Michael','Willie','2002/06/15', '23463745-T');
/* Insertamos dos hijos a Donatello */
insert into hijos (dni_hijo, nombre, apellido, dni_padre) values ('21425587-D','Juani','Perez', '68941259-H');
insert into hijos (dni_hijo, nombre, apellido, dni_padre) values ('74896521-L','Keywith','Loan', '68941259-H');

/* Quiero ver toda la información sobre todos los padres */
select * from padres;
/* Quiero ver DNI y Nombre de todos los padres */
select dni_padre, nombre from padres;

/* Quiero ver todos los datos de todos los hijos de los padres que se llamen Leonardo */
select * from hijos join padres where padres.nombre = 'Leonardo' and hijos.dni_padre = padres.dni_padre;

/* Quiero ver todos los datos de todos los hijos de Leonardo de DNI = '23463745-T' */
select * from hijos where dni_padre='23463745-T';

/* Quiero conocer todos los hijos nacidos en el siglo XX */
select * from hijos where fecha_nacimiento < '2001/01/01';
/* o */
select * from hijos where fecha_nacimiento < '2000/12/31';

/* Quiero conocer el DNI, nombre y sueldos de todos los padres que cobran menos de 1500 euros */
select dni_padre, nombre, sueldo from padres where sueldo < 1500;

/* Quiero conocer el DNI, nombre, sueldos y sueldo neto de todos los padres que cobran menos de 1500 euros */
/* Para calcular el neto supongamos que le quitamos el 10% al sueldo(al sueldo bruto) */
select dni_padre, nombre, sueldo, sueldo*0.9 from padres where sueldo < 1500;

/* Se pueden redondear con round(, 2)*/
select dni_padre, apellido nombre, sueldo as S_Bruto, round(sueldo * r_irpf) as IRPF, round (sueldo * r_ss) as Seg_Social,round (sueldo - sueldo*r_irpf - sueldo*r_ss) as Neto from padres;

select * from hijos where dni_padre = '68941259-H';