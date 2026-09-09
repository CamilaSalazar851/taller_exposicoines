use pruebas;
CREATE table empleado(
	id_empleado INT PRIMARY KEY AUTO_INCREMENT,
	nombre varchar(100) not null,
	email varchar(50)unique,
	salario decimal (1000,2) not null check (salario>=0),
	id_departamento INT not null,
	fecha_contratacion date,
	foreing key (id_departamento) references departamento(id_departamento)
);

create table departamento(
	id_departamento int primary key auto_increment,
	nombre varchar (50) not null
	);

	

create table productos_prueba()
	id int primary key auto_increment,
	nombre varchar (50) not null
);


ALTER TABLE producto_prueba ADD COLUNM precio varchar (10,2)
drop table productos_prueba;

