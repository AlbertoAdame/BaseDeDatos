CREATE TABLE DEPARTAMENTO (
	codigo INT(10) auto_increment,
	nombre VARCHAR(100),
	presupuesto DOUBLE(10,2),
	gastos DOUBLE(10,2),
	CONSTRAINT pk_departamento PRIMARY KEY (codigo)
);


CREATE TABLE EMPLEADO (
	codigo INT(10) auto_increment,
	nif VARCHAR(9),
	nombre VARCHAR(100),
	apellido1 VARCHAR(100),
	apellido2 VARCHAR(100),
	codigo_departamento INT(10),
	CONSTRAINT pk_empleado PRIMARY KEY (codigo),
	CONSTRAINT fk_empleado FOREIGN KEY (codigo_departamento) REFERENCES DEPARTAMENTO(codigo)

);



INSERT INTO DEPARTAMENTO (codigo, nombre, presupuesto, gastos) VALUES (1, 'Desarrollo', 120000, 6000);
INSERT INTO DEPARTAMENTO (codigo, nombre, presupuesto, gastos) VALUES (2, 'Sistemas', 150000, 21000);
INSERT INTO DEPARTAMENTO (codigo, nombre, presupuesto, gastos) VALUES (3, 'Recursos Humanos', 280000, 25000);
INSERT INTO DEPARTAMENTO (codigo, nombre, presupuesto, gastos) VALUES (4, 'Contabilidad', 110000, 3000);
INSERT INTO DEPARTAMENTO (codigo, nombre, presupuesto, gastos) VALUES (5, 'I+D', 375000, 380000);
INSERT INTO DEPARTAMENTO (codigo, nombre, presupuesto, gastos) VALUES (6, 'Proyectos', 0, 0);
INSERT INTO DEPARTAMENTO (codigo, nombre, presupuesto, gastos) VALUES (7, 'Publicidad', 0, 1000);


INSERT INTO EMPLEADO VALUES (1, '32481596F', 'Aarón', 'Rivero', 'Gómez', 1);
INSERT INTO EMPLEADO VALUES (2, 'Y5575632D', 'Adela', 'Salas', 'Díaz', 2);
INSERT INTO EMPLEADO VALUES (3, 'R6970642B', 'Adolfo', 'Rubio', 'Flores', 3);
INSERT INTO EMPLEADO VALUES (4, '77705545E', 'Adrián', 'Suárez', NULL, 4);
INSERT INTO EMPLEADO VALUES (5, '17087203C', 'Marcos', 'Loyola', 'Méndez', 5);
INSERT INTO EMPLEADO VALUES (6, '38382980M', 'María', 'Santana', 'Moreno', 1);
INSERT INTO EMPLEADO VALUES (7, '80576669X', 'Pilar', 'Ruiz', NULL, 2);
INSERT INTO EMPLEADO VALUES (8, '71651431Z', 'Pepe', 'Ruiz', 'Santana', 3);
INSERT INTO EMPLEADO VALUES (9, '56399183D', 'Juan', 'Gómez', 'López', 2);
INSERT INTO EMPLEADO VALUES (10, '46384486H', 'Diego','Flores', 'Salas', 5);
INSERT INTO EMPLEADO VALUES (11, '67389283A', 'Marta','Herrera', 'Gil', 1);
INSERT INTO EMPLEADO VALUES (12, '41234836R', 'Irene','Salas', 'Flores', NULL);
INSERT INTO EMPLEADO VALUES (13, '82635162B', 'Juan Antonio','Sáez', 'Guerrero', NULL);


--1. Inserta un nuevo departamento indicando su código, nombre y presupuesto.

INSERT INTO DEPARTAMENTO (codigo, nombre, presupuesto) VALUES (10, 'Programacion', 12002);

--2. Inserta un nuevo departamento indicando su nombre y presupuesto.

INSERT INTO DEPARTAMENTO (nombre, presupuesto) VALUES ('Lengua', 1442);

--3. Inserta un nuevo departamento indicando su código, nombre, presupuesto y gastos.

INSERT INTO DEPARTAMENTO (codigo, nombre, presupuesto, gastos) VALUES (21, 'Desarrollo Informatico', 150000, 5000);

--4. Inserta un nuevo empleado asociado a uno de los nuevos departamentos. La sentencia de inserción 
--debe incluir: código, nif, nombre, apellido1, apellido2 y codigo_departamento.

INSERT INTO EMPLEADO (codigo,nif,nombre,apellido1,apellido2,codigo_departamento) VALUES (25, '41237836R', 'LUIS','Salero', 'Velez', 5);

--5. Inserta un nuevo empleado asociado a uno de los nuevos departamentos. La sentencia de inserción debe
--incluir: nif, nombre, apellido1, apellido2 y codigo_departamento.

INSERT INTO EMPLEADO (nif,nombre,apellido1,apellido2,codigo_departamento) VALUES ('41238936F', 'Paco','Lewis', 'Olias', 10);

--6. Crea una nueva tabla con el nombre departamento_backup que tenga las mismas columnas que la tabla departamento. Una vez creada copia todos
--las filas de tabla departamento en departamento_backup.

CREATE TABLE DEPARTAMENTO_BACKUP (
	codigo INT(10),
	nombre VARCHAR(100),
	presupuesto DOUBLE(10,2),
	gastos DOUBLE(10,2),
	CONSTRAINT pk_departamento_backup PRIMARY KEY (codigo)

);

INSERT INTO DEPARTAMENTO_BACKUP (codigo, nombre, presupuesto, gastos)
SELECT * FROM DEPARTAMENTO;
--en vez del * podriamos haber puesto "codigo, nombre, presupuesto, gastos"

--7. Elimina el departamento Proyectos. ¿Es posible eliminarlo? Si no fuese
--posible, ¿qué cambios debería realizar para que fuese posible borrarlo?

DELETE FROM DEPARTAMENTO WHERE UPPER(nombre) = UPPER('Proyectos'); --donde va el = podria poner un LIKE

--8. Elimina el departamento Desarrollo. ¿Es posible eliminarlo? Si no fuese
--posible, ¿qué cambios debería realizar para que fuese posible borrarlo?

DELETE FROM DEPARTAMENTO WHERE nombre='Desarrollo'; --NO podremos pq hay que poner ON DELETE CASCADE 

SELECT * FROM DEPARTAMENTO; --comprobamos cual es el que queremos borrar para en la siguiente tabla, fijarnos que se borra.
SELECT * FROM EMPLEADO; --en este caso era el 1, y lo tenian dos, por lo que se ha borrado bien

ALTER TABLE EMPLEADO DROP CONSTRAINT fk_empleado; /*DEBEREMOS BORRAR LA CONSTRAINT*/
ALTER TABLE EMPLEADO ADD CONSTRAINT fk_empleado FOREIGN KEY (codigo_departamento) REFERENCES DEPARTAMENTO(codigo) ON DELETE CASCADE; --AHORA PONEMOS EL ON DELETE CASCADE

DELETE FROM DEPARTAMENTO WHERE nombre='Desarrollo'; -- Y YA NOS DEJARÁ BORRARLO

SELECT * FROM DEPARTAMENTO;
SELECT * FROM EMPLEADO;


--9. Actualiza el código del departamento Recursos Humanos y asígnale el valor 30. 
--¿Es posible actualizarlo? Si no fuese posible, ¿qué cambios debería realizar para que fuese actualizarlo?

ALTER TABLE EMPLEADO DROP CONSTRAINT fk_empleado; /*DEBEREMOS BORRAR LA CONSTRAINT*/
ALTER TABLE EMPLEADO ADD CONSTRAINT fk_empleado FOREIGN KEY (codigo_departamento) REFERENCES DEPARTAMENTO(codigo) ON DELETE CASCADE ON UPDATE CASCADE; 

UPDATE DEPARTAMENTO
SET codigo=30
WHERE nombre='Recursos Humanos';

--En mysql pondremos UPDATE CASCADE en la tabla


--10.Actualiza el código del departamento Publicidad y asígnale el valor 40.
--¿Es posible actualizarlo? Si no fuese posible, ¿qué cambios debería realizar para que fuese actualizarlo?

UPDATE DEPARTAMENTO
SET codigo=40
WHERE nombre='Publicidad';

--11.Actualiza el presupuesto de los departamentos sumándole 50000 € al
--valor del presupuesto actual, solamente a aquellos departamentos que tienen un presupuesto menor que 20000 €.

UPDATE DEPARTAMENTO
SET presupuesto=presupuesto+50000
WHERE presupuesto<20000;

SELECT * FROM DEPARTAMENTO;

--12.Realiza una transacción que elimine todas los empleados que no tienen un departamento asociado.

SELECT * FROM EMPLEADO WHERE codigo_departamento IS NULL;
DELETE FROM EMPLEADO WHERE codigo_departamento IS NULL;

--En mysql hay que poner "delete from" el from será indispensable




















