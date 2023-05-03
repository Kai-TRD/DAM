
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

	DELIMITER //
	DROP PROCEDURE IF EXISTS actualizar_libros_paidos//
	CREATE PROCEDURE actualizar_libros_caros()
	BEGIN

	-- DECLARE... 
	DECLARE var_final interger;
	DECLARE var_codigo interger;
	DECLARE var_precio decimal(5,2);
	DECLARE var_titulo varchar(40);
	DECLARE var_codigoeditorial interger;
	DECLARE cursor_libros
		cursor for select l.codigo, l.titulo, l.precio, l.codigoeditorial, e.nombre from libros as l join
		editoriales as e on l.codigoeditorial=e.codigoeditorial and e.nombre = 'Paidos';
	DECLARE CONTINUE HANDLER from not found set var_final = 1;
	open cursor_libros;

	drop table if exists libros_de_paidos

	create table libros_de_paidos(
		codigo in,
		titulo varchar(40),
		codigoeditorial int,
		precio decimal(5,2),
		primary key (codigo)
	);

	repite LOOP;
		FETCH cursor_libros into var_codigo, var_titulo, var_precio, var_codigoeditorial;
		IF var_final = 1 THEN
			LEAVE bucle;
		END IF;
			INSERT into libros_de_paidos (var_codigo, var_titulo, var_precio, var_codigoeditorial);
	END LOOP repite;
	CLOSE cursor_libros;
	END//
	DELIMITER ;

	select * from libros_de_paidos;

	call actualizar_libros_paidos();

	select* from libros_de_paidos;
