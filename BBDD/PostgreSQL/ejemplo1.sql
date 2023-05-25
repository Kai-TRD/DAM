/*22/05/2023 PARA HACER EN POSTGRESQL*/
/*En estos ejercicios ya no está el descuento a nivel de cliente, 
 está en la tabla ofertas*/
drop table if exists ofertas;
create table ofertas (
id_producto int primary key,
descuento decimal(4,2)
);
drop table if exists ivas;
create table ivas (
	id_iva int primary key,
	descripcion varchar(20),
	valor decimal(4,2)
);
drop table if exists productos;
create table productos (
	id_producto int primary key,
	nombre varchar(30),
	precio_base decimal(5,2),
	id_iva int
);
drop table if exists clientes;
create table clientes (
	id_cliente int primary key,
	nombre varchar(30)
);
drop table if exists cab_facturas;
create table cab_facturas (
	id_factura int primary key,
	id_cliente int,
	fecha_hora date
);
drop table if exists lin_facturas;
create table lin_facturas (
	id_factura int,
	id_linea int,
	id_producto int,
	cantidad int,
	primary key (id_factura, id_linea)
);


insert into ivas values (1,'Super Reducido', 4.00);
insert into ivas values (2,'Reducido', 10.00);
insert into ivas values (3,'Normal', 16.00);
insert into ivas values (4,'Lujo', 20.00);

insert into clientes values (1,'Rocío Carrasco');
insert into clientes values (2,'José L. García');
insert into clientes values (3,'Andrés Sánchez');
insert into clientes values (4,'Luisa Palomares');
insert into clientes values (5,'Ana Jiménez');
insert into clientes values (6,'Julio Torres');

insert into productos  values (1, 'Barra de pan', 0.75, 1);
insert into productos  values (2, 'Litro leche', 0.90, 1);
insert into productos  values (3, 'Paquete café', 1.20, 2);
insert into productos  values (4, 'Kg. patatas', 0.60, 2);
insert into productos  values (5, 'Kg. naranjas', 1.50, 3);
insert into productos  values (6, 'Kg. tomates', 1.80, 3);
insert into productos  values (7, 'Pantalón vaquero', 45.50, 4);
insert into productos  values (8, 'Reloj Casio', 22.00, 4);

insert into cab_facturas values (1, 1,'2023-10-01');
insert into cab_facturas values (2, 5,'2023-10-02');
insert into cab_facturas values (3, 6,'2023-10-03');


insert into lin_facturas values (1,1,2, 1);
insert into lin_facturas values (1,2,3, 2);
insert into lin_facturas values (1,3,4, 3);
insert into lin_facturas values (1,4,1, 2);
insert into lin_facturas values (2,1,5, 3);
insert into lin_facturas values (2,2,6, 1);
insert into lin_facturas values (2,3,7, 2);
insert into lin_facturas values (3,1,5, 3);
insert into lin_facturas values (3,2,6, 2);
insert into lin_facturas values (3,3,7, 1);
insert into lin_facturas values (3,4,8, 1);


/* Realizar una función factura_cliente(id_factura)  pl/pgsql a la que le pasaremos un identificador de factura y nos devolverá
en forma de mensaje raise todos los datos de la cabecera de factura y el detalle de las líneas de la factura

Nº FACTURA      FECHA    CLIENTE (id - nombre completo)
----------      -----    ------------------------------


ID DEL PRODUCTO   PRODUCTO    PRECIO BASE  PRECIO CON IVA  CANTIDAD   SUBTOTAL  
---------------   --------    -----------    ------------   -------   --------
   ........          .....        .......        ........   .......    .......
   ........          .....        .......    	 ........   .......    .......
   ........          .....        .......    	 ........   .......    .......

															TOTAL:     total*/

CREATE or replace FUNCTION factura_cliente(id int) RETURNS void AS
$$
DECLARE
	p_id_factura int;
	p_fecha date;
	p_id_cliente int;
    p_contador_lineas int;
	p_contador int = 1;	
	p_id_linea int;
	p_id_producto int;
	p_nombre varchar;
	p_nombre_producto varchar;
	p_precio_base decimal(5,2);
	p_precio_con_iva decimal (5,2);
	p_cantidad int;
	p_subtotal decimal(5,2);
	
BEGIN
	select count(*) into p_contador_lineas from lin_facturas where id_factura = id;
	select c.fecha_hora, c.id_cliente, cl.nombre into p_fecha, p_id_cliente, p_nombre from cab_facturas as c join clientes as cl on c.id_cliente = cl.id_cliente
	where c.id_factura = id;
	
	raise notice 'Nº FACTURA      FECHA    CLIENTE (id - nombre completo)';
	raise notice '----------    -------    ------------------------------';
	raise notice '         %    %          % - %', id, p_fecha, p_id_cliente, p_nombre;
	raise notice 'ID DEL PRODUCTO   PRODUCTO    PRECIO BASE  PRECIO CON DESC e IVA  CANTIDAD   SUBTOTAL ';
	raise notice '---------------   --------    -----------  ---------------------  --------   -------- ';

LOOP
select l.id_linea, l.id_producto, p.nombre, p.precio_base, p.precio_base*(1+i.valor/100), l.cantidad, p.precio_base*(1+i.valor/100)*l.cantidad
into p_id_linea, p_id_producto, p_nombre_producto, p_precio_base, p_precio_con_iva, p_cantidad, p_subtotal
from lin_facturas as l join cab_facturas as c on l.id_factura = c.id_factura  join productos as p on l.id_producto = p.id_producto
join ivas as i on i.id_iva = p.id_iva join clientes as cl on cl.id_cliente = c.id_cliente where id_linea = p_contador order by id_linea;
raise notice '              %   %          %          %         %       %', p_id_producto, p_nombre_producto,
	p_precio_base, p_precio_con_iva, p_cantidad, p_subtotal;
p_contador = p_contador + 1;
if p_contador > p_contador_lineas then
	exit;
end if;
END LOOP;	
END;
$$ LANGUAGE plpgsql;
select factura_cliente(3);