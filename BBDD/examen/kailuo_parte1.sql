/* Cursor que recorra los saltos y si alguno es mayor que su mejor marca, la actualizará*/ 
/* Esta nota daría hasta 8 puntos */
/* Para conseguir hasta 2 puntos extra, realiza el mismo ejercicio pero mediante un cursor
que se recorra la tabla de deportistas y acceda para cada deportista al valor maximo de sus saltos para
ver si le actualiza se mejor marca personal */

DROP DATABASE IF EXISTS tokio_2020;
CREATE DATABASE tokio_2020;
USE tokio_2020;

CREATE TABLE deportistas_saltos (
    id_deportista int primary key,
    nombre varchar(30),
	pais varchar(3),
	mejor_marca_personal decimal(3,2)
);
CREATE TABLE saltos (
    id_deportista int,
    id_salto int,
    marca decimal(3,2),
    primary key (id_deportista, id_salto) 
);

INSERT INTO deportistas_saltos VALUES (1, 'Mondo Duplantis', 'SUE', 6.22);
INSERT INTO deportistas_saltos VALUES (2, 'Thiago Braz', 'BRA', 6.03);
INSERT INTO deportistas_saltos VALUES (3, 'Igor Potapovich', 'KAZ', 5.99);
INSERT INTO deportistas_saltos VALUES (4, 'Brad Walker', 'USA', 6.12);

INSERT INTO saltos VALUES (1,1, 6.01);
INSERT INTO saltos VALUES (1,2, 6.24);
INSERT INTO saltos VALUES (1,3, 5.98);
INSERT INTO saltos VALUES (2,1, 5.99);
INSERT INTO saltos VALUES (2,2, 5.97);
INSERT INTO saltos VALUES (2,3, 5.94);
INSERT INTO saltos VALUES (3,1, 6.02);
INSERT INTO saltos VALUES (3,2, 6.04);
INSERT INTO saltos VALUES (3,3, 6.00);
INSERT INTO saltos VALUES (4,1, 6.10);
INSERT INTO saltos VALUES (4,2, 6.17);
INSERT INTO saltos VALUES (4,3, 6.01);

SELECT * from deportistas_saltos;


/* 8 puntos */
/* --------------------------------------------------------- */


DELIMITER //

CREATE PROCEDURE actualizar_marcas()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE var_id_deportista INT;
    DECLARE var_id_salto INT;
    DECLARE var_marca DECIMAL(3,2);
    DECLARE cursor_saltos CURSOR FOR SELECT id_deportista, id_salto, marca FROM saltos;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN cursor_saltos;
    bucle_saltos: LOOP
        FETCH cursor_saltos INTO var_id_deportista, var_id_salto, var_marca;
        IF done THEN
            LEAVE bucle_saltos;
        END IF;
        IF var_marca > (SELECT mejor_marca_personal FROM deportistas_saltos WHERE id_deportista = var_id_deportista) THEN
            UPDATE deportistas_saltos SET mejor_marca_personal = var_marca WHERE id_deportista = var_id_deportista;
        END IF;
    END LOOP bucle_saltos;
    CLOSE cursor_saltos;
END //

DELIMITER ;

CALL actualizar_marcas();

SELECT * FROM deportistas_saltos;


/* 2 puntos EXTRAS */
/* --------------------------------------------------------- */

/* DELIMITER //
CREATE PROCEDURE actualizar_mejor_marca()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE var_id_deportista INT;
    DECLARE mejor_marca DECIMAL(3,2);
    DECLARE cursor2 CURSOR FOR SELECT id_deportista FROM deportistas_saltos;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN cursor2;
    
    read_loop: LOOP
        FETCH cursor2 INTO var_id_deportista;
        IF done THEN
            LEAVE read_loop;
        END IF;

        SELECT MAX(marca) INTO mejor_marca FROM saltos WHERE id_deportista = var_id_deportista;
        
        UPDATE deportistas_saltos SET mejor_marca_personal = mejor_marca WHERE id_deportista = var_id_deportista AND mejor_marca > mejor_marca_personal;
    END LOOP;
    
    CLOSE cursor2;
END //
DELIMITER ;

CALL actualizar_mejor_marca();

SELECT * from deportistas_saltos; */