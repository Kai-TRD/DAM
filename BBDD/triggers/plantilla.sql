/* Plantilla de Trigger para Inserción: */

CREATE TRIGGER nombre_trigger
ON nombre_tabla
AFTER INSERT
AS
BEGIN
   -- Código a ejecutar después de una inserción
END;
Explicación:

/* "nombre_trigger": Es el nombre que le darás a tu trigger.
"nombre_tabla": Es el nombre de la tabla en la que quieres activar el trigger.
"AFTER INSERT": Especifica que el trigger se activará después de una inserción en la tabla.
"-- Código a ejecutar después de una inserción": Es el código que quieres que se ejecute después de una inserción en la tabla. */











/* Plantilla de Trigger para Actualización: */

CREATE TRIGGER nombre_trigger
ON nombre_tabla
AFTER UPDATE
AS
BEGIN
   -- Código a ejecutar después de una actualización
END;
Explicación:

/* "nombre_trigger": Es el nombre que le darás a tu trigger.
"nombre_tabla": Es el nombre de la tabla en la que quieres activar el trigger.
"AFTER UPDATE": Especifica que el trigger se activará después de una actualización en la tabla.
"-- Código a ejecutar después de una actualización": Es el código que quieres que se ejecute después de una actualización en la tabla. */










/* Plantilla de Trigger para Inserción con Validación: */

CREATE TRIGGER nombre_trigger
ON nombre_tabla
AFTER INSERT
AS
BEGIN
   IF EXISTS (SELECT * FROM inserted WHERE columna = 'valor') -- condición de validación
   BEGIN
      -- Código a ejecutar si la condición se cumple
   END
   ELSE
   BEGIN
      -- Código a ejecutar si la condición no se cumple
   END
END;
/* 
Explicación:

"nombre_trigger": Es el nombre que le darás a tu trigger.
"nombre_tabla": Es el nombre de la tabla en la que quieres activar el trigger.
"AFTER INSERT": Especifica que el trigger se activará después de una inserción en la tabla.
"IF EXISTS (SELECT * FROM inserted WHERE columna = 'valor')": Es una condición de validación que se ejecuta sobre la tabla "inserted", que contiene los valores recién insertados.
"-- Código a ejecutar si la condición se cumple": Es el código que quieres que se ejecute si la condición de validación se cumple.
"-- Código a ejecutar si la condición no se cumple": Es el código que quieres que se ejecute si la condición de validación no se cumple. */










/* Plantilla de Trigger para Actualización con Registro de Cambios: */

CREATE TRIGGER nombre_trigger
ON nombre_tabla
AFTER UPDATE
AS
BEGIN
   DECLARE @columna VARCHAR(50)
   DECLARE @valor_anterior VARCHAR(50)
   DECLARE @valor_nuevo VARCHAR(50)

   SELECT @columna = 'nombre_columna', @valor_anterior = deleted.nombre_columna, @valor_nuevo = inserted.nombre_columna FROM inserted, deleted WHERE inserted.id = deleted.id -- valores de la columna que ha sido actualizada

   IF @valor_anterior <> @valor_nuevo -- condición de cambio
   BEGIN
      INSERT INTO registro_cambios (id, columna, valor_anterior, valor_nuevo, fecha) VALUES (inserted.id, @columna, @valor_anterior, @valor_nuevo, GETDATE()) -- registro del cambio en una tabla de registro
   END
END;

/* Explicación:

"nombre_trigger": Es el nombre que le darás a tu trigger.
"nombre_tabla": Es el nombre de la tabla en la que quieres activar el trigger.
"AFTER UPDATE": Especifica que el trigger se activará después de una actualización en la tabla.
"DECLARE @columna VARCHAR(50), @valor_anterior VARCHAR(50), @valor_nuevo VARCHAR(50)": Declara variables para almacenar el nombre de la columna que ha sido actualizada, el valor anterior de la columna y el valor nuevo de la columna.
"SELECT @columna = 'nombre_columna', @valor_anterior = deleted.nombre_columna, @valor_nuevo = inserted.nombre_columna FROM inserted, deleted WHERE inserted.id = deleted.id": Asigna los valores de la columna que ha sido actualizada a las variables declaradas anteriormente utilizando las tablas "inserted" y "deleted".
"IF @valor_anterior <> @valor_nuevo": Es una condición que comprueba si el valor de la columna ha sido cambiado.
"INSERT INTO registro_cambios (id, columna, valor_anterior, valor_nuevo, fecha) VALUES (inserted.id, @columna, @valor_an */



