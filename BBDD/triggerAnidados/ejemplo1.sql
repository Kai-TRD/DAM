/* Tenemos que hacer dos cursores, con uno nos recorreremos cada vehículo (cursor externo) y para cada
vehículo nos recorreremos cada una de sus visitas al taller (cursor interno) para llevar a cabo la
actualización de puntos de fidelización */

drop database if exists norauto;

create database norauto;

use norauto;

create table vehiculo (
    id_matricula char(7) primary key,
    marca varchar(10),
    modelo varchar(10),
    punto int default 0
);

create table visitas (
    id_matricula char(7),
    fecha_visita date,
    importe_factura decimal(7, 2),
    primary key (id_matricula, fecha_visita)
);

insert into vehiculo (id_matricula, marca, modelo) values ('3342LRQ', 'Yoyota', 'CHR 185');
insert into vehiculo (id_matricula, marca, modelo) values ('097BBLT', 'Seat', 'Ibiza Tdi');
insert into vehiculo (id_matricula, marca, modelo) values ('1234CFS', 'Ferrari', 'Testarazo');

insert into visitas values ('3342LRQ', '2021/04/02', 328);
insert into visitas values ('097BBLT', '2022/09/12', 122);
insert into visitas values ('1234CFS', '2022/11/05', 3482);


drop procedure if exists actualiza_puntos
create procedure actualiza_puntos()
begin
    declare done int default false;
    declare






