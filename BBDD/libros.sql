drop table if exists libros;

create table libros(
  codigo int auto_increment,
  titulo varchar(40),
  autor varchar(30),
  editorial varchar(20),
  precio decimal(5,2),
  primary key(codigo)
);

 insert into libros(titulo,autor,editorial,precio) 
  values('Alicia en el pais de las maravillas','Lewis Carroll','Emece',20.00);
 insert into libros(titulo,autor,editorial,precio)
  values('Alicia en el pais de las maravillas','Lewis Carroll','Plaza',35.00);
 insert into libros(titulo,autor,editorial,precio)
  values('Aprenda PHP','Mario Molina','Siglo XXI',40.00);
 insert into libros(titulo,autor,editorial,precio)
  values('El aleph','Borges','Emece',10.00);
 insert into libros(titulo,autor,editorial,precio)
  values('Ilusiones','Richard Bach','Planeta',15.00);
 insert into libros(titulo,autor,editorial,precio)
  values('Java en 10 minutos','Mario Molina','Siglo XXI',50.00);
 insert into libros(titulo,autor,editorial,precio)
  values('Martin Fierro','Jose Hernandez','Planeta',20.00);
 insert into libros(titulo,autor,editorial,precio)
  values('Martin Fierro','Jose Hernandez','Emece',30.00);
 insert into libros(titulo,autor,editorial,precio)
  values('Uno','Richard Bach','Planeta',10.00);

  select * from libros;

  select * from libros where autor = 'Lewis Carroll';

  select titulo, autor, precio from libros where precio > (select avg(precio) from libros);

  select titulo, autor, precio from libros where autor like 'J%' and precio >= 30 order by precio asc;

