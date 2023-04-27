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
    declare done int;
    declare var_id_matricula char(7);
    declare var_id_matricula2 char(7);
    declare var_importe_matricula decimal(7,2);
    declare cursor_vehiculos cursor from select id_matricula from vehiculo;
    declare cursor_visitas cursor from select id_matricula, importe_factura from visitas;
    declare continue handler for not found set done = true;
    open cursor_vehiculos;
    bucle_vehiculos: loop;
        fetch cursor_vehiculos into var_id_matricula;
        if done then
            leave bucle_vehiculos;
        end if;
        open cursor visitas;
        bucle_visitas: loop;
            fectch cursor_visitas into var_id_matricula2, var_importe_factura;
            if done then
                leave bucle_visitas;
            end if:
            if var_id_matricula2 = var_id_matricula then
                update vehiculo set puntos = puntos + round(var_importe_factura / 10, 0) where (var_id_matricula = var_id_matricula2);
            end if;
        end loop bucle_visitas;
        close cursor_visitas;
    end loop bucle_vehiculos;
    close cursor_vehiculos;
end;