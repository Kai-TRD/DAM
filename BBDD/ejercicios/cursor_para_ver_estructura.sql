drop database if exists libreria;
create database libreria;
use libreria;

 create table libros(
  codigo int,
  titulo varchar(40),
  codigoeditorial int,
  precio decimal(5,2),
  primary key (codigo)
 );
 create table editoriales(
  codigo int,
  nombre varchar(20),
  primary key(codigo)
 );
 insert into editoriales values(1, 'Emece');
 insert into editoriales values(2, 'Planeta');
 insert into editoriales values(3, 'Paidos');
 insert into libros values (1,'El aleph',1,23.5);
 insert into libros values (2,'Alicia en el pais de las maravillas',2,15);
 insert into libros values (3,'Matematica estas ahi',1,34.6);
 insert into libros values (4,'Martin Fierro',3,43.5);
 insert into libros values (5,'Martin Fierro',2,12);
 insert into libros values (6,'Aprenda PHP',3,21.8);
 insert into libros values (7,'Aprenda Java',3,55.4);
 insert into libros values (8,'Alicia a traves del espejo',1,18);
 insert into libros values (9,'Antologia poetica',3,47.9);
select * from libros;

DELIMITER // 
/* Conociendo la estructurea de un corsor intenta realizar un cursor que recorra las editoriales y acurañize los precios de sus libros en 5€ */
DROP PROCEDURE IF EXISTS actualiza_precio//
CREATE PROCEDURE actualiza_precio()
BEGIN
  DECLARE var_final INTEGER;
  DECLARE var_codigo INTEGER;1
  DECLARE var_editorial varchar(20);
  DECLARE var_precio decimal(5,2);
  DECLARE cursor1 CURSOR FOR SELECT codigo, codigoeditorial, precio FROM libros;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET var_final = 1;
  OPEN cursor1;
  repite: LOOP
    FETCH cursor1 INTO var_codigo, var_editorial, var_precio;
    IF var_final = 1 THEN
      LEAVE repite;
    END IF;
    UPDATE libros SET precio = precio + 1 WHERE codigoeditorial = 2 and var_codigo = codigo;
  END LOOP repite;
  CLOSE cursor1;
END//
DELIMITER ;

call actualiza_precio();

select * from libros;