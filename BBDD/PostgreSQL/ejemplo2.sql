/*19/05/2023 PARA HACER EN POSTGRESQL*/
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
drop table if exists productos_iva_1;
create table productos_iva_1 (
	id_producto int primary key,
	nombre varchar(30),
	precio_base decimal(5,2)
);
drop table if exists productos_iva_2;
create table productos_iva_2 (
	id_producto int primary key,
	nombre varchar(30),
	precio_base decimal(5,2)
);
drop table if exists productos_iva_3;
create table productos_iva_3 (
	id_producto int primary key,
	nombre varchar(30),
	precio_base decimal(5,2)
);
drop table if exists productos_iva_4;
create table productos_iva_4 (
	id_producto int primary key,
	nombre varchar(30),
	precio_base decimal(5,2)
);
drop table if exists clientes;
create table clientes (
	id_cliente int primary key,
	nombre varchar(30),
	descuento decimal(5,2)
);
drop table if exists compras;
create table compras (
	id_cliente int,
	id_producto int,
	fecha_hora date,
	cantidad int,
	primary key (id_cliente, id_producto, fecha_hora)
);
insert into ivas values (1,'Super Reducido', 4.00);
insert into ivas values (2,'Reducido', 10.00);
insert into ivas values (3,'Normal', 16.00);
insert into ivas values (4,'Lujo', 20.00);

insert into clientes values (1,'Rocío Carrasco', 10.00);
insert into clientes values (2,'José L. García', 0.00);
insert into clientes values (3,'Andrés Sáenchez', 20.00);

insert into productos  values (1, 'Barra de pan', 0.75, 1);
insert into productos  values (2, 'Litro leche', 0.90, 1);
insert into productos  values (3, 'Paquete café', 1.20, 2);
insert into productos  values (4, 'Kg. patatas', 0.60, 2);
insert into productos  values (5, 'Kg. naranjas', 1.50, 3);
insert into productos  values (6, 'Kg. tomates', 1.80, 3);
insert into productos  values (7, 'Pantalón vaquero', 45.50, 4);
insert into productos  values (8, 'Reloj Casio', 22.00, 4);

insert into compras values (1,1,'2023-10-02', 5);
insert into compras values (1,8,'2023-10-02', 1);
insert into compras values (1,4,'2023-10-02', 2);
insert into compras values (2,1,'2023-10-02', 5);
insert into compras values (2,8,'2023-10-02', 1);
insert into compras values (2,4,'2023-10-02', 2);


/*18/05/2023*/
/*Estructuras condicionales*/
/*If then eslsif...*/
/* Realizar una función tramo_producto()  pl/pgsql a la que le pasaremos un identificador de producto y nos devolverá
en forma de mensaje raise junto con el identificador , su nombre, su precio base y el rango de precios en el que está:
'precio bajo' si el precio_base es menor a 5 €, 'precio medio' si 5<= precio_base < 10 y 'precio alto' en otro caso*/   
CREATE or replace FUNCTION tramo_producto(id int) RETURNS void AS
$$
DECLARE 
p_id int;
p_nombre varchar;
p_precio decimal(4,2);
p_tramo varchar;
BEGIN
select id_producto, nombre, precio_base into p_id, p_nombre, p_precio from
productos where id_producto = id;
if not found then
	raise notice 'El producto de código % no existe', id;
else
	if p_precio < 5 then
		p_tramo =  'Producto barato';
	elsif p_precio < 10 then
		p_tramo = 'Precio Medio';
		else
			p_tramo = 'Precio alto';
		end if;
	raise notice 'El producto => código: % , nombre: %, precio: % pertenece al tramo: %', p_id, p_nombre, p_precio, p_tramo;
end if;
END;
$$ LANGUAGE plpgsql;
select tramo_producto(8);

/* Crear una función llamada insertar_productos_iva(), para hacer una copia de los productos, según su iva, en las tablas
productos_iva_X que se han creado para ello, donde X es 1, 2, 3 ó 4 según el tipo de iva que tenga asignado cada producto
Nos vamos a recorrer los productos de la siguiente manera:
Empeezamos por un valor 1 y recogemos la información del artículo 1 Miramos su iva, y lo insertamos en la tabla productos_iva_x donde
x puede ser 1, 2, 3 y 4.
Lo vamos a hacer con un bucle (loop) de tal forma que nos saldremos del bucle cnd hayamos recorrido rtantos registros como 
calculemos que hay*/
/* Cuando termine la función mostrará un pequeño informe indicando cuantos productos ha procesado para cada iva*/ 
DROP FUNCTION IF EXISTS insertar_productos_iva;
CREATE FUNCTION insertar_productos_iva() RETURNS void AS
$$
DECLARE
p_id int;
p_nombre varchar;
p_precio decimal(4,2);
p_iva int;
total_registros int;
contador integer = 1;
total_productos_iva1 int = 0;
total_productos_iva2 int = 0;
total_productos_iva3 int = 0;
total_productos_iva4 int = 0;
BEGIN
select max(id_producto) into total_registros from productos;
LOOP
select id_producto, nombre, precio_base, id_iva into p_id, p_nombre, p_precio, p_iva
	from productos where id_producto = contador;
if not found then
	raise notice 'El producto % no existe', contador;
else
	if p_iva =1  then
			insert into productos_iva_1 (id_producto, nombre, precio_base) values (p_id, p_nombre, p_precio);
			total_productos_iva1 = total_productos_iva1 + 1;
		elsif p_iva = 2 then
			insert into productos_iva_2 (id_producto, nombre, precio_base) values (p_id, p_nombre, p_precio);
			total_productos_iva2 = total_productos_iva2 + 1;
		elseif p_iva = 3 then
			insert into productos_iva_3 (id_producto, nombre, precio_base) values (p_id, p_nombre, p_precio);
			total_productos_iva3 = total_productos_iva3 + 1;
		else
			insert into productos_iva_4 (id_producto, nombre, precio_base) values (p_id, p_nombre, p_precio);
			total_productos_iva4 = total_productos_iva4 + 1;
	end if;
end if;
contador = contador + 1;
if contador > total_registros then
	exit;
end if;
END LOOP;
	raise notice 'Total de productos procesados con iva tipo 1: %', total_productos_iva1;
	raise notice 'Total de productos procesados con iva tipo 2: %', total_productos_iva2;
	raise notice 'Total de productos procesados con iva tipo 3: %', total_productos_iva3;
	raise notice 'Total de productos procesados con iva tipo 4: %', total_productos_iva4;	
END;
$$ LANGUAGE plpgsql;

select insertar_productos_iva();
/*Para probarlo:*/
select * from productos_iva_1;
select * from productos_iva_2;
select * from productos_iva_3;
select * from productos_iva_4;

/* Programar una función llamada total_compras_agrupadas_por_iva() que muestre para cada iva todas
las compras acumuladas de los productos que tienen dicho iva
No tiene retorno, la función mostrará los resultados a manera de mensajes con un formato similar a éste
 COMPRAS CON IVA : id_iva DE VALOR: valor% 
 DETALLE DE LAS COMPRAS
ID DEL PRODUCTO   PRODUCTO    PRECIO BASE    CANTIDAD  
---------------   --------    -----------    -------- 
   ........          .....        .......    ........
   ........          .....        .......    ........
   ........          .....        .......    ........

toda la estructura anterior se repite para cada tipo de iva

Se muestra con la cabecera para cada iva, se consigue programar sin cursores mediante dos bucles (LOOP)
La función no recibe ni retorna nada, lo hace con mensajes raise y recorriendo todos los registros de la 
tabla de ivas y para cada iva, recorriéndose sus compras asociadas.*/

drop function if exists compras_por_iva;
CREATE or replace FUNCTION compras_por_iva() RETURNS void AS
$$
DECLARE
p_iva int;
p_desc_iva varchar;
p_valor decimal(4,2);
p_fecha date;
p_id int;
p_nombre varchar;
p_precio_base decimal(4,2);
p_final decimal(4,2);
p_cantidad int;
p_total decimal(4,2);
total_registros_iva int;
total_registros_producto int;
contador_iva integer = 1;
contador_producto integer = 1;
total_productos_iva1 int = 0;
BEGIN
select max(id_iva) into total_registros_iva from ivas;
select max(id_producto) into total_registros_producto from productos;
if contador_iva <= total_registros_iva then
LOOP
select id_iva, descripcion, valor into p_iva, p_desc_iva, p_valor
	from ivas where id_iva = contador_iva;
if found then
 raise notice 'COMPRAS CON IVA : % DE VALOR: %', p_iva, p_valor; 
 raise notice 'ID DEL PRODUCTO   PRODUCTO    PRECIO BASE   CANTIDAD VENDIDA';
 raise notice '---------------   --------    -----------   ----------------';
/*Bucle para registros de compra*/
	
	LOOP
	select p.id_producto, p.nombre, p.precio_base, sum(c.cantidad)
	into p_id, p_nombre, p_precio_base, p_cantidad
	from compras as c join productos as p on c.id_producto = p.id_producto 
	join ivas as i on p.id_iva = i.id_iva 
	where p.id_iva = contador_iva and c.id_producto = contador_producto group by p.id_producto;
	if found then
 		raise notice '   %            %           %            %           ', p_id, p_nombre, p_precio_base, p_cantidad; 
	end if;
contador_producto = contador_producto + 1;
	if contador_producto > total_registros_producto then
		exit;
	end if;
	END LOOP;
contador_iva = contador_iva + 1;
end if;
END LOOP;
end if;
END;
$$ LANGUAGE plpgsql;

select compras_por_iva();

