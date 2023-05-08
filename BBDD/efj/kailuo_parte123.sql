/* Cursor que recorra los saltos y si alguno es mayor que su mejor marca, la actualizará*/ 
/* Esta nota daría hasta 8 puntos */
/* Para conseguir hasta 2 puntos extra, realiza el mismo ejercicio pero mediante un cursor
que se recorra la tabla de deportistas y acceda para cada deportista al valor maximo de sus saltos para
ver si le actualiza se mejor marca personal */

DROP DATABASE IF EXISTS tokio_2020;
CREATE DATABASE tokio_2020;
USE tokio_2020;

CREATE TABLE deportistas_saltos (
    var_id_deportista int primary key,
    nombre varchar(30),
    pais varchar(3),
    mejor_marca_personal decimal(3,2)
);
CREATE TABLE saltos (
    var_id_deportista int,
    id_salto int,
    marca decimal(3,2),
    primary key (var_id_deportista, id_salto) 
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

DELIMITER //
CREATE PROCEDURE actualiza_mejor_marca_personal()
    BEGIN
        DECLARE done INT DEFAULT FALSE;
        DECLARE var_id_deportista INT;
        DECLARE cur_deportistas CURSOR FOR SELECT var_id_deportista FROM deportistas_saltos;
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

        OPEN cur_deportistas;

        recorrer_deportistas: LOOP
            FETCH cur_deportistas INTO var_id_deportista;
            IF done THEN
                LEAVE recorrer_deportistas;
            END IF;

            SELECT MAX(marca) INTO @mejor_marca FROM saltos WHERE var_id_deportista = var_id_deportista;
            UPDATE deportistas_saltos SET mejor_marca_personal = @mejor_marca WHERE var_id_deportista = var_id_deportista;
        END LOOP;

        CLOSE cur_deportistas;

    END //
DELIMITER ;
CALL actualiza_mejor_marca_personal();
SELECT * FROM deportistas_saltos;
