/* 
    Ejemplo de Trigger:
    Supongamos que tenemos una tabla "notas" que almacena las notas de
    los estudiantes en diferentes asignaturas. Queremos asegurarnos de
    que las notas estén en el rango de 0 a 10 y no haya valores negativos
    o superiores a 10. Podemos crear un trigger que se active cada vez
    que se inserte o actualice una nota y que verifique si el valor de
    la nota está dentro del rango permitido. Si la nota es incorrecta, 
    el trigger puede generar un error y evitar que se realice la operación.
    El código del trigger podría ser algo así:
 */

 CREATE TRIGGER validar_nota
ON notas
AFTER INSERT, UPDATE
AS
BEGIN
   IF EXISTS (SELECT * FROM inserted WHERE nota < 0 OR nota > 10)
   BEGIN
      RAISERROR('La nota debe estar en el rango de 0 a 10', 16, 1);
      ROLLBACK TRANSACTION;
   END
END;

/* 
    En este ejemplo, el trigger se activa después de cada inserción o
    actualización en la tabla "notas" (AFTER INSERT, UPDATE). El trigger utiliza
    la tabla "inserted" para acceder a los valores recién insertados o actualizados.
    Si la nota es incorrecta, el trigger genera un error y revierte la operación
    utilizando la instrucción ROLLBACK TRANSACTION.
 */ 