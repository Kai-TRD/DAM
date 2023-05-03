/* Plantilla de Cursor para Recorrer una Tabla: */

DECLARE @variable1 TIPO_DATO
DECLARE @variable2 TIPO_DATO

DECLARE nombre_cursor CURSOR FOR
SELECT columna1, columna2 FROM nombre_tabla -- select de la tabla que quieres recorrer

OPEN nombre_cursor

FETCH NEXT FROM nombre_cursor INTO @variable1, @variable2

WHILE @@FETCH_STATUS = 0
BEGIN
   -- Código a ejecutar para cada fila
   FETCH NEXT FROM nombre_cursor INTO @variable1, @variable2
END

CLOSE nombre_cursor
DEALLOCATE nombre_cursor

/* Explicación: */

/* "DECLARE @variable1 TIPO_DATO, @variable2 TIPO_DATO": Declara las variables que se utilizarán para almacenar los valores de cada fila.
"DECLARE nombre_cursor CURSOR FOR SELECT columna1, columna2 FROM nombre_tabla": Declara el cursor y establece la consulta que recorrerá la tabla.
"OPEN nombre_cursor": Abre el cursor para comenzar el recorrido de la tabla.
"FETCH NEXT FROM nombre_cursor INTO @variable1, @variable2": Obtiene el primer conjunto de valores de la tabla y los asigna a las variables.
"WHILE @@FETCH_STATUS = 0 BEGIN": Inicia un bucle que se ejecutará hasta que se recorra toda la tabla.
"-- Código a ejecutar para cada fila": Es el código que quieres que se ejecute para cada fila de la tabla.
"FETCH NEXT FROM nombre_cursor INTO @variable1, @variable2": Obtiene el siguiente conjunto de valores de la tabla y los asigna a las variables.
"CLOSE nombre_cursor": Cierra el cursor.
"DEALLOCATE nombre_cursor": Elimina el cursor. */








/* Plantilla de Cursor para Actualizar una Tabla: */

DECLARE @variable1 TIPO_DATO
DECLARE @variable2 TIPO_DATO

DECLARE nombre_cursor CURSOR FOR
SELECT columna1, columna2 FROM nombre_tabla -- select de la tabla que quieres actualizar

OPEN nombre_cursor

FETCH NEXT FROM nombre_cursor INTO @variable1, @variable2

WHILE @@FETCH_STATUS = 0
BEGIN
   -- Código para actualizar los valores de la fila actual
   UPDATE nombre_tabla SET columna1 = @variable1, columna2 = @variable2 WHERE CURRENT OF nombre_cursor
   FETCH NEXT FROM nombre_cursor INTO @variable1, @variable2
END

CLOSE nombre_cursor
DEALLOCATE nombre_cursor

/* Explicación: */

/* "DECLARE @variable1 TIPO_DATO, @variable2 TIPO_DATO": Declara las variables que se utilizarán para almacenar los valores de cada fila.
"DECLARE nombre_cursor CURSOR FOR SELECT columna1, columna2 FROM nombre_tabla": Declara el cursor y establece la consulta que recorrerá la tabla.
"OPEN nombre_cursor": Abre el cursor para comenzar el recorrido de la tabla.
"FETCH NEXT FROM nombre_cursor INTO @variable1, @variable2": Obtiene el primer conjunto de valores de la tabla y los asigna a las variables.
"WHILE @@FETCH_STATUS = 0 BEGIN": Inicia un bucle que se ejecutará hasta que se recorra toda la tabla.
"-- Código para actualizar los valores de la fila actual": Es el código que quieres que se ejecute para actualizar los valores de la fila actual.
"UPDATE nombre_tabla SET columna1 = @variable1, columna2 = @variable2 */