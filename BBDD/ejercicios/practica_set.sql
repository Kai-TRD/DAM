drop database practica_set;
create database practica_set;
use practica_set;
drop table cursos;

create table cursos(
  codigo tinyint unsigned auto_increment,
  tema varchar(20) not null,
  dias set ('lunes','martes','miercoles','jueves','viernes','sabado') not null,
  horario enum ('AM','PM') not null,
  clases tinyint unsigned default 1,
  fechainicio date,
  costo decimal(5,2) unsigned,
  primary key(codigo)
 );

 insert into cursos (tema, dias,horario,clases,fechainicio,costo)
  values('PHP básico','lunes,martes,miercoles','AM',18,'2006-08-07',200);
 insert into cursos (tema, dias,horario,clases,fechainicio,costo)
  values('PHP básico','lunes,martes,miercoles','PM',18,'2006-08-14',200);
 insert into cursos (tema, dias,horario,clases,fechainicio,costo)
  values('PHP básico','sabado','AM',18,'2006-08-05',280);
 insert into cursos (tema, dias,horario,clases,fechainicio,costo)
  values('PHP avanzado','martes,jueves','AM',20,'2006-08-01',350);
 insert into cursos (tema, dias,horario,clases,fechainicio,costo)
  values('JavaScript','lunes,martes,miercoles','PM',15,'2006-09-11',150);
 insert into cursos (tema, dias,horario,clases,fechainicio,costo)
  values('Paginas web','martes,jueves','PM',10,'2006-08-08',250);
 insert into cursos (tema, dias,horario,clases,fechainicio,costo)
  values('Paginas web','sabado','AM',10,'2006-08-12',280);
 insert into cursos (tema, dias,horario,clases,fechainicio,costo)
  values('Paginas web','lunes,viernes','AM',10,'2006-08-21',200);
 insert into cursos (tema, dias,horario,clases,fechainicio,costo)
  values('Paginas web','lunes,martes,miercoles,jueves,viernes','AM',10,'2006-09-18',180);
 insert into cursos (tema, dias,horario,clases,fechainicio,costo)
  values('Paginas web','lunes,viernes','PM',10,'2006-09-25',280);
 insert into cursos (tema, dias,horario,clases,fechainicio,costo)
  values('JavaScript','lunes,martes,viernes,sabado','PM',12,'2006-09-18',150);

-- 1- Una persona quiere inscribirse en un curso de "PHP" y sólo tiene disponibles los sábados. Localice los cursos de "PHP" que se dictan solamente los sábados:
select * from cursos where tema like '%PHP%' and find_in_set('sabado', dias) ;
-- 2- Otra persona quiere aprender a diseñar páginas web, tiene disponibles todas las mañanas -- excepto  los miércoles. Vea si existe algún curso que cumpla con sus necesidades:
select * from cursos where tema like 'Paginas web' and horario like 'AM' and dias not like '%sabado%';
-- 3- Otra persona necesita aprender JavaScript, tiene disponibles todos las tardes excepto 
-- los jueves  y quiere un curso que no supere las 15 clases para el mes de setiembre. Busque -- algún curso para  esta persona:
select * from cursos where tema like 'JavaScript' and horario like 'PM' and dias not like '%jueves%' and clases < 16 and fechainicio like '%-09-%';


