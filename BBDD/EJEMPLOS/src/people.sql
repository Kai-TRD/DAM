drop database if exists people;
create database people;
use people;

create table people(
	dni char(8) primary key,
	nombre varchar(20),
	apellidos varchar(50),
	telefono char(9)
);
