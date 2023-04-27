drop database if exists norauto;
create database norauto;
use norauto;
create table vehiculos (
	id_matricula char(7) primary key,
    marca varchar (10),
    modelo varchar (10),
    puntos int default 0);
    
create table visitas (
	id_matricula char(7),
    fecha_visita date,
    importe_factura decimal(7,2),
    primary key (id_matricula, fecha_visita));
    
insert into vehiculos (id_matricula, marca, modelo) values ('3342LRQ', 'Toyota', 'CHR 185');
insert into vehiculos (id_matricula, marca, modelo) values ('0978BLT', 'Seat', 'Ibiza Tdi');
insert into vehiculos (id_matricula, marca, modelo) values ('1234CFS', 'Ferrari', 'Testarazo');

insert into visitas values ('3342LRQ', '2021-04-02', 328);
insert into visitas values ('0978BLT', '2022-09-12', 122);
insert into visitas values ('1234CFS', '2022-11-05', 3482);

DELIMITER //
CREATE PROCEDURE actualiza_puntos()
BEGIN
    DECLARE done INT;
    DECLARE var_id_matricula CHAR(7);
    DECLARE cursor_vehiculos CURSOR FOR SELECT id_matricula FROM vehiculos;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN cursor_vehiculos;
    bucle_vehiculos: LOOP
        FETCH cursor_vehiculos INTO var_id_matricula;
        IF done THEN
            LEAVE bucle_vehiculos;
        END IF;
		
        CALL actualiza_puntos_anidado(var_id_matricula);

    END LOOP bucle_vehiculos;
    CLOSE cursor_vehiculos;
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE actualiza_puntos_anidado(var_id_matricula CHAR(7))
BEGIN
    DECLARE done INT;
    DECLARE var_importe_factura DECIMAL(7,2);
    DECLARE cursor_visitas CURSOR FOR SELECT importe_factura FROM visitas WHERE id_matricula = var_id_matricula;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN cursor_visitas;
    bucle_visitas: LOOP
         FETCH cursor_visitas INTO var_importe_factura;
         IF done THEN
         LEAVE bucle_visitas;
         END IF;
         update vehiculos set puntos = puntos + round(var_importe_factura / 10, 0) where id_matricula = var_id_matricula;
    END LOOP bucle_visitas;
    CLOSE cursor_visitas;
END //

DELIMITER ;

select * from vehiculos;
call actualiza_puntos();
select * from vehiculos;

