/* 
    Ejemplo de Cursor: Supongamos que tenemos una tabla "empleados" que
    almacena información sobre los empleados de una empresa, incluyendo
    su salario y fecha de ingreso.Queremos calcular el salario promedio
    de los empleados que han trabajado en la empresa durante más de 5
    años.Podemos utilizar un cursor para recorrer los registros de la
    tabla "empleados", calcular la antigüedad de cada empleado y
    acumular el salario de los empleados que cumplen los requisitos.El
    código del cursor podría ser algo as í: 
 */

 DECLARE @salario_total FLOAT;
DECLARE @num_empleados INT;

DECLARE empleados_cursor CURSOR FOR
SELECT salario FROM empleados;

OPEN empleados_cursor;

FETCH NEXT FROM empleados_cursor INTO @salario_total;

WHILE @@FETCH_STATUS = 0
BEGIN
   IF DATEDIFF(year, fecha_ingreso, GETDATE()) > 5
   BEGIN
      SET @salario_total = @salario_total + salario;
      SET @num_empleados = @num_empleados + 1;
   END

   FETCH NEXT FROM empleados_cursor INTO @salario_total;
END;

CLOSE empleados_cursor;
DEALLOCATE empleados_cursor;

SELECT @salario_total / @num_empleados AS salario_promedio;

/* 
    En este ejemplo, creamos un cursor llamado "empleados_cursor" que
    selecciona los registros de la tabla "empleados". Luego, abrimos el 
    cursor y utilizamos la instrucción FETCH NEXT para obtener el primer
    registro del cursor. Después, utilizamos un bucle WHILE para recorrer
    todos los registros del cursor, calcular la antigüedad de cada empleado
    y acumular el salario de los empleados que han trabajado en la empresa
    durante más de 5 años. Finalmente, cerramos y eliminamos el cursor y
    calculamos el salario promedio de los empleados seleccionados. 
*/