
/* NO se puede */

DECLARE @id_cliente INT
DECLARE @fecha_pedido DATE

DECLARE cursor_clientes CURSOR FOR 
SELECT ID_cliente FROM Clientes

OPEN cursor_clientes

FETCH NEXT FROM cursor_clientes INTO @id_cliente

WHILE @@FETCH_STATUS = 0
BEGIN
    DECLARE cursor_pedidos CURSOR FOR 
    SELECT fecha_pedido FROM Pedidos WHERE ID_cliente = @id_cliente

    OPEN cursor_pedidos

    FETCH NEXT FROM cursor_pedidos INTO @fecha_pedido

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Realizar alguna acción con el @id_cliente y el @fecha_pedido

        FETCH NEXT FROM cursor_pedidos INTO @fecha_pedido
    END

    CLOSE cursor_pedidos
    DEALLOCATE cursor_pedidos

    FETCH NEXT FROM cursor_clientes INTO @id_cliente
END

CLOSE cursor_clientes
DEALLOCATE cursor_clientes
