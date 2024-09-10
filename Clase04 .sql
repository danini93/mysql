-- Clase 04

-- -------------------------
-- -------- Ejercicio 1
-- -------------------------


-- 1- Crear la tabla facturas dentro de la base de datos con el siguiente detalle:

-- letra		char y PK
-- numero		int y PK
-- fecha		date
-- monto		double

-- PK significa Primary Key
-- observar que se esta declarando una clave primaria compuesta
-- es decir (letra,codigo)
-- cada campo por si solo no es clave, ni tampoco identifica al registro
-- pero la suma de los dos forman la clave
create database if not exists cursomysql;
use cursomysql;

create table facturas(
	letra char(1),
    numero int,
    fecha date not null,
    monto double not null,
    primary key(letra, numero)
);

describe facturas;

create table articulos(
	codigo int primary key,
    nombre varchar(50) not null,
    precio double not null,
    stock int not null
);

-- insertamos más registros a la tabla clientes
insert into clientes (nombre, apellido, cuit, direccion) values
('Homero', 'Thompson', '22336655487', 'Calle Falsa 123'),
('Fabián', 'Sanchez', '88665544985', 'Medrano 12345'),
('Luisana', 'Verón', '66554499875', 'Medrano 37'),
('Adolfina', 'Conti', '45653215478', 'Diaz Velez 123'),
('Otto', 'Wendell', '45687452159', 'Riglos 156'),
('Marcos', 'Gonzalez', '12346578965', null),
('Grecia', 'Huequi', '53626589457', 'Baigorria 42583'),
('Juan', 'Perez', '42358547569', 'Rosales 235'),
('Marcelo', 'Lopez', '12365666325', 'Salta 12'),
('María', 'Gonzalez', '23659874523', 'Lanús 123'),
('Juan', 'Catillo', '12356849753', null),
('Mario', 'Canteros', '23658585857', 'Mendoza 123'),
('Mariano', 'Pecollio', '12365478542', 'Belgrano 234');

select * from clientes;
-- el * es un comodín
select nombre from clientes;
-- muestra solo los nombres de todos los registros

select nombre, apellido from clientes;
-- listar los nombres y apellidos de todos los clientes

select nombre from clientes; -- 17

select distinct nombre from clientes;
-- no muestra los duplicados


-- Operadores relacionales
/*
=	igual
!=	no igual
<>	distinto
>	mayor
<	menor
>=	mayor o igual
<=	menor o igual
*/

-- filtrado con where
select * from clientes where nombre = 'Juan';
-- muestra todos los campos de todos los registros cuyo nombre sea igual a Juan

select * from clientes where nombre = 'JUAN';
-- trae los mimos resultados de la consulta anterior

insert into clientes (nombre, apellido, cuit) values
('Juan Carlos', 'Mendieta', '77885544123');

select * from clientes where codigo = 3;
-- lista los registros que tengan código igual a 3

select * from clientes where codigo > 3;
-- trae todos los campos de todos los clientes cuyo código sea mayor a 3

select * from clientes where codigo >= 3;
-- trae todos los campos de todos los registros cuyo código sea mayor o igual a 3

select * from clientes where codigo <> 3;
-- trae todos los campos de todos los registros cuyo código no sea igual a 3

-- operadores lógicos AND y OR
select * from clientes where codigo < 3 or codigo > 5;
-- lista todos los campos de todos los registros cuyo código sea menor a 3
-- o mayor a 5.

select * from clientes where codigo >= 3 and codigo <= 5; 
-- lista todos los campos de todos los registros cuyo código sea mayor o igual a 3
-- y menor o igual a 5.  

-- valores NULL
-- NULL significa desconocido, es una ausencia de valor
-- y no debe interpretarse como vacío o 0
-- Los valores nulos no ocupan espacio y son distintos al 0 o al espacio en blanco.
-- Hay que tener cuidado con los valores nulos en las operaciones, ya que 1 * NULL
-- es igual a NULL

select * from clientes;
select * from clientes where direccion='';
select * from clientes where direccion is null;
select * from clientes where direccion is not null;
-- para buscar valores nulos lo hacemos con is null
-- is not null trae los registros que no sean nulos

-- parámatero between y not between
select * from clientes where codigo between 4 and 12;
-- el between trae todos los registros que estén comprendidos entre los límites indicados
select * from clientes where codigo not between 4 and 12;
-- el not between trae todos los registros que no estén comprendidos entre los límites indicados

-- parámetro in y not in
select * from clientes where codigo in (3, 7, 9, 11);
-- esto es similar a poner
select * from clientes where codigo=3 or codigo=7 or codigo=9 or codigo=11;
--			(9)					F			F			v			F
select * from clientes where codigo not in (3, 7, 9, 11);
-- trae todos los campos de todos los registros cuyo codigo no sea igual a 3, ni a 7, ni a 9, ni a 11
select * from clientes where codigo<>3 and codigo<>7 and codigo<>9 and codigo<>11;
--				(3)				F				V			V			V


select * from clientes;
-- parámetros LIKE, NOT LIKE y operadores % y _
-- % significa cualquier cosa
-- _ significa un caracter cualquiera
select * from clientes where nombre like 'Juan%';
-- trae todos los registros que comiencen con 'Juan', esto incluye 'Juan Pablo', por ejemplo.

select * from clientes where nombre like 'mar%';
-- trae todos los registros que comiencen con 'mar'

select * from clientes where nombre like 'mari_';
-- el _ ocupa un espacio si o si, con lo cual, en este caso los nombres deben tener siempre 5 caracteres

select * from clientes where apellido like '%z';
-- trae todos los registros cuyo apellido finalice con z

select * from clientes where apellido like 'g%z';
-- trae todos los registros cuyo apellido comience con g y finalice con z

select * from clientes where apellido like '_____'; 
-- trae todos los apellidos que tengan 5 caracteres


-- parámetros ORDER BY asc y desc
select * from clientes order by apellido asc;
-- ordena los registros teniendo en cuenta el apellido en orden alfabético ascendente
select * from clientes order by apellido;
-- no es necesario colocar el asc
select * from clientes order by apellido desc;
-- el desc indica que el orden debe ser descendente
select * from clientes order by apellido, codigo;
-- ordena los registros por apellido en forma ascendente y luego por codigo en caso de encontrar apellidos duplicados
select * from clientes order by apellido, codigo desc;
-- ordena por apellido en forma ascendente y luego por codigo en forma descendente en caso de encontrar apellidos duplicados

-- clausula limit
select * from clientes limit 5;
-- trae los primeros 5 registros

select * from clientes order by apellido limit 5;
-- trae los primeros 5 los clientes ordenados por apellido

select * from clientes where apellido like '%z' and codigo > 3 order by apellido limit 5;
-- trae los primeros 5 registros cuyo apellido finalice con 'z' y que el código sea mayor a 3
-- ordenados por apellido


-- inserción de registros en la tabla articulos
-- con definición de campos:
insert into articulos (codigo, nombre, precio, stock) values 
(1, 'caramelos flynn paff', 200, 50);
insert into articulos (codigo, nombre, precio, stock) values 
(2, 'chupetines pico dulce', 150, 30);
insert into articulos (codigo, nombre, precio, stock) values 
(3, 'alfajores fulbito', 200, 50);
insert into articulos (codigo, nombre, precio, stock) values 
(4, 'palitos de la selva', 50, 150);
insert into articulos (codigo, nombre, precio, stock) values 
(5, 'yerba Playadito', 4000, 30);
insert into articulos (codigo, nombre, precio, stock) values 
(6, 'Danonino vainilla', 10000, 30);
insert into articulos (codigo, nombre, precio, stock) values 
(7, 'pasta de maní', 280000, 5);
insert into articulos (codigo, nombre, precio, stock) values 
(8, 'mielcitas', 100, 50);
insert into articulos (codigo, nombre, precio, stock) values 
(9, 'Aquarius pera 500cc', 1500, 20);
insert into articulos (codigo, nombre, precio, stock) values 
(10, 'cañita de azúcar', 300, 100);
insert into articulos (codigo, nombre, precio, stock) values 
(11, 'leche vegetal de almendras', 320000, 20);
insert into articulos (codigo, nombre, precio, stock) values 
(12, 'cindor 1Litro', 5000, 3);
-- puedo cambiar el orden de los campos, respetando luego el orden de los valores
insert into articulos (precio, stock, codigo, nombre) values
( 200, 50, 13, 'turrón de maní');

-- sin definición de campos
insert into articulos values
(14, 'coca-cola 2lts.', 2200, 40);
-- cuando vamos a completar todos los campos en orden, no es necesario declararlos antes

insert into articulos values
(15, 'arroz 1kg', 2000, 100);

insert into articulos values
(16, 'serenito', 500, 20),
(17, 'detergente magistral', 15000, 20),
(18, 'agua mineral 500cc', 1500, 40);

-- 1
select * from articulos where precio > 1000;

-- 2
select * from articulos where precio > 2000 and precio < 40000;

-- 3
select * from articulos where precio > 4000 and precio < 6000;

-- 4
select * from articulos where precio = 2000 and stock > 300;
-- 5
select * from articulos where precio = 1200 or precio= 2000 or precio= 30000;
-- 6
select * from articulos where precio in (1200, 2000, 30000);
-- 7
select * from articulos where precio not in (100, 200, 10000);
-- 8
select * from articulos order by precio desc, nombre;
-- 9
select *, precio * 1.21 'precio con IVA' from articulos;
select nombre, precio, precio*1.21 ' precio con IVA' from articulos;

-- 10
select *, 3 'cantidad de cuotas', (precio/3)*1.05 'valor de cuota' from articulos;

-- 11- todos los artículos cuyo nombre termine con a y tenga 19 letras
select * from articulos where nombre like '%a' and nombre like '___________________';
 
-- 12- todos los artículos cuyo nombre contenga al menos dos 'L'
select * from articulos where nombre like '%l%l%';

-- 13- todos los artículos cuyo nombre esté compuesto con al menos dos palabras
select * from articulos where nombre like '% %';

-- 14- los primeros 5 artículos ordenados por precio en forma descendente
select * from articulos where codigo <= 5 order by precio desc;

-- 15- los 2 primeros artículos luego del segundo registro ordenado por stock
select * from articulos where codigo > 2 order by stock limit 2;
