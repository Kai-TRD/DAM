
Resolver el Trigger indicado dentro del enunciado.
Miguel Ángel Sáenz Soubrier
•
13:03
10 puntos

enunciado_trigger_ej.sql
Archivo desconocido
Comentarios de la clase
Tu trabajo
Asignado
Comentarios privados
DROP DATABASE IF EXISTS seneca;
CREATE DATABASE seneca;
USE seneca;

CREATE TABLE alumnos (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido1 VARCHAR(50) NOT NULL,
    nota FLOAT
);

CREATE TABLE log_notas (
    id_incidencia INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_alumno INT UNSIGNED,
    nombre VARCHAR(50) NOT NULL,
    apellido1 VARCHAR(50) NOT NULL,
    nota FLOAT,
    ipv4 varchar(15),
    usuario varchar(50),
    fechahora datetime
);

DROP TRIGGER IF EXISTS tcnbi;
DELIMITER //
CREATE TRIGGER tcnbi
BEFORE INSERT
ON alumnos FOR EACH ROW
BEGIN

  IF NEW.nota < 0 THEN
    set NEW.nota = 0;
  ELSEIF NEW.nota > 10 THEN
    set NEW.nota = 10;
  END IF;
END //
DELIMITER ;

DROP TRIGGER IF EXISTS tcnbu;
DELIMITER //
CREATE TRIGGER tcnbu
BEFORE UPDATE
ON alumnos FOR EACH ROW
BEGIN
  IF NEW.nota < 0 THEN
    set NEW.nota = 0;
  ELSEIF NEW.nota > 10 THEN
    set NEW.nota = 10;
  END IF;
END //
DELIMITER ;

SELECT * FROM alumnos;
select * from log_notas;

INSERT INTO alumnos VALUES (1, 'Pepe', 'López', -1);
INSERT INTO alumnos VALUES (2, 'María', 'Sánchez', 11);
INSERT INTO alumnos VALUES (3, 'Juan', 'Pérez', 8.5);

SELECT * FROM alumnos;
select * from log_notas;
UPDATE alumnos SET nota = -4 WHERE id = 3;
SELECT * FROM alumnos;
select * from log_notas;
UPDATE alumnos SET nota = 14 WHERE id = 3;
SELECT * FROM alumnos;
select * from log_notas;
UPDATE alumnos SET nota = 9.5 WHERE id = 3;
SELECT * FROM alumnos;
select * from log_notas;

/* Sabiendo que puedo preparar consultas de cualquier tipo dentro de un trigger
que podrán actuar sobre cualquier tabla de la base de datos que estamos usando, se pide:
Modificar el trigger "tcnbi" añadiendo una funcionalidad que consista en "chivarse"
del intento de introducir una nota negativa en un alumno.
Para ello, cada vez que este intento se produzca, se insertará un registro en la tabla
"log_notas" indicando el valor que se pretendía introducir, el id y nombre del alumno
afectado, la ipv4 del sistema que lanzó la query, el usuario implicado y la fecha/hora
en la que se produjo el intento. */







