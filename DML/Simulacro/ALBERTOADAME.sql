--Creación usuario

ALTER SESSION SET"_oracle_script"=true;
CREATE USER SIMULACRO IDENTIFIED BY SIMULACRO;
GRANT CONNECT, RESOURCE, DBA TO SIMULACRO;


--Apartado 1

CREATE TABLE PROFESOR (
	idProfesor NUMBER (10),
	nif_p VARCHAR2 (9),
	nombre VARCHAR2 (25),
	especialidad VARCHAR2 (25),
	telefono VARCHAR2 (25),
	CONSTRAINT pk_profesor PRIMARY KEY (idProfesor)
	
);

CREATE TABLE ALUMNO (
	numMatricula NUMBER (15),
	nombre VARCHAR2 (25),
	fechaNacimiento DATE,
	telefono VARCHAR2(9),
	CONSTRAINT pk_alumno PRIMARY KEY (numMatricula)
);

CREATE TABLE ASIGNATURA (
	codAsignatura VARCHAR2(25),
	nombre VARCHAR2(25),
	idProfesor NUMBER (10),
	CONSTRAINT pk_asignatura PRIMARY KEY (codAsignatura),
	CONSTRAINT fk_asignatura_alumno FOREIGN KEY (idProfesor) REFERENCES PROFESOR(idProfesor)
);

CREATE TABLE RECIBE (
	numMatricula NUMBER (15),	
	codAsignatura VARCHAR2(25),
	cursoEscolar VARCHAR2 (1),
	CONSTRAINT pk_recibe PRIMARY KEY (numMatricula,codAsignatura,cursoEscolar),
	CONSTRAINT fk_recibe_alumno FOREIGN KEY (numMatricula) REFERENCES ALUMNO(numMatricula),
	CONSTRAINT fk_recibe_asignatura FOREIGN KEY (codAsignatura) REFERENCES ASIGNATURA(codAsignatura)

);


INSERT INTO PROFESOR VALUES (1, '48123165A', 'Alberto', 'Música', '622537951');
INSERT INTO PROFESOR VALUES (2, '48123165B', 'Javi', 'Informática', '622537952');

INSERT INTO ASIGNATURA VALUES (10, 'Informática', 2);
INSERT INTO ASIGNATURA VALUES (11, 'Música', 1);


--Necesitaremos añadir 2 profesores más para el correcto funcionamiento del programa
INSERT INTO PROFESOR VALUES (3, '48123165C', 'Jose', 'Sistema', '622537953');
INSERT INTO PROFESOR VALUES (4, '48123165D', 'Florian', 'Lenguaje', '622537954');


INSERT INTO ASIGNATURA VALUES (12, 'Sistema', 3);
INSERT INTO ASIGNATURA VALUES (13, 'Lenguaje', 4);

INSERT INTO ALUMNO VALUES (100, 'Juanma', TO_DATE('08/03/1990','DD/MM/YYYY'), '622537913');
INSERT INTO ALUMNO VALUES (101, 'Fernando', TO_DATE('08/03/1991','DD/MM/YYYY'), '622537923');
INSERT INTO ALUMNO VALUES (102, 'Jose Antonio', TO_DATE('08/03/1992','DD/MM/YYYY'), '622537933');
INSERT INTO ALUMNO VALUES (103, 'Juan', TO_DATE('08/03/1993','DD/MM/YYYY'), '622537943');
INSERT INTO ALUMNO VALUES (104, 'Daniel', TO_DATE('08/03/1994','DD/MM/YYYY'), '622537953');
INSERT INTO ALUMNO VALUES (105, 'Joaquin', TO_DATE('08/03/1995','DD/MM/YYYY'), '622537963');
INSERT INTO ALUMNO VALUES (106, 'Roman', TO_DATE('08/03/1996','DD/MM/YYYY'), '622537973');
INSERT INTO ALUMNO VALUES (107, 'Chisela', TO_DATE('08/03/1997','DD/MM/YYYY'), '622537983');
INSERT INTO ALUMNO VALUES (108, 'Nadia', TO_DATE('08/03/1998','DD/MM/YYYY'), '622537993');
INSERT INTO ALUMNO VALUES (109, 'Lucia', TO_DATE('08/03/1999','DD/MM/YYYY'), '622538000');


INSERT INTO RECIBE VALUES (100,10,1);
INSERT INTO RECIBE VALUES (100,11,2);
SELECT * FROM RECIBE;

INSERT INTO RECIBE VALUES (101,10,1);
INSERT INTO RECIBE VALUES (101,11,2);
SELECT * FROM RECIBE;

INSERT INTO RECIBE VALUES (102,10,1);
INSERT INTO RECIBE VALUES (102,11,2);

INSERT INTO RECIBE VALUES (103,10,1);
INSERT INTO RECIBE VALUES (103,11,2);

INSERT INTO RECIBE VALUES (104,10,1);
INSERT INTO RECIBE VALUES (104,11,2);

INSERT INTO RECIBE VALUES (105,10,1);
INSERT INTO RECIBE VALUES (105,11,2);

INSERT INTO RECIBE VALUES (106,10,1);
INSERT INTO RECIBE VALUES (106,11,2);

INSERT INTO RECIBE VALUES (107,10,1);
INSERT INTO RECIBE VALUES (107,11,2);

INSERT INTO RECIBE VALUES (108,10,1);
INSERT INTO RECIBE VALUES (108,11,2);

INSERT INTO RECIBE VALUES (109,10,1);
INSERT INTO RECIBE VALUES (109,11,2);

--Apartado 3

--Tenemos a juanma que ya estaba creado
--INSERT INTO ALUMNO VALUES (100, 'Juanma', TO_DATE('08/03/1990','DD/MM/YYYY'), '622537913');

--Y ahora añadiremos a Paco
--INSERT INTO ALUMNO VALUES (100, 'Paco', TO_DATE('08/03/1989','DD/MM/YYYY'), '622538001');
--Nos da error pq la primary key no es única, nunca dos alumnos podrán tener el mismo código
--Para arreglar deberemos ponerle un número de matrícula diferente, o en mysql ponerle un auto_incremente
--En nuestro caso con cambiarle el número manualmente nos servirá
INSERT INTO ALUMNO VALUES (110, 'Paco', TO_DATE('08/03/1989','DD/MM/YYYY'), '622538001');

--Apartado 4

INSERT INTO ALUMNO VALUES (111, 'Pedro', TO_DATE('09/03/1989','DD/MM/YYYY'), NULL);
INSERT INTO ALUMNO VALUES (112, 'Lucas', TO_DATE('10/03/1989','DD/MM/YYYY'), NULL);
INSERT INTO ALUMNO VALUES (113, 'Mario', TO_DATE('11/03/1989','DD/MM/YYYY'), NULL);

--Apartado 5

UPDATE ALUMNO 
SET telefono='622538002'
WHERE numMatricula=111;
--SELECT * FROM ALUMNO;

UPDATE ALUMNO 
SET telefono='622538003'
WHERE numMatricula=112;

UPDATE ALUMNO 
SET telefono='622538004'
WHERE numMatricula=113;

--Apartado 6

--Como no tenemos ningun alumno en esta fecha, crearemos uno

INSERT INTO ALUMNO VALUES (114, 'Manolo', TO_DATE('11/03/2001','DD/MM/YYYY'), '622538010');

UPDATE ALUMNO
SET fechaNacimiento=TO_DATE('22/07/1981','DD/MM/YYYY')
WHERE (EXTRACT (YEAR FROM fechaNacimiento) > 2000);

--Apartado 7

UPDATE PROFESOR
SET especialidad='Informática'
WHERE telefono LIKE ('%') AND nif_p NOT LIKE ('9%');

--Apartado 8

DELETE RECIBE
WHERE codAsignatura=10;

SELECT * FROM RECIBE;

--Apartado 9

DELETE ASIGNATURA
WHERE codAsignatura=10;

SELECT * FROM ASIGNATURA;

--Aparatado 10

--DELETE ASIGNATURA;

--Da error, porque la tabla RECIBE tiene información de ASIGNATURA
--Lo solucionamos borrando la información de RECIBE

DELETE RECIBE;
DELETE ASIGNATURA;

--Apartado 11

DELETE PROFESOR;
--En este caso nos dejará porque en el apartado anterior hemos borrado todos los datos de recibe

--Apartado 12
SELECT * FROM ALUMNO;

UPDATE ALUMNO
SET nombre = UPPER (nombre);

--Apartado 13

CREATE TABLE ALUMNO_BACKUP (
	numMatricula NUMBER (15),
	nombre VARCHAR2 (25),
	fechaNacimiento DATE,
	telefono VARCHAR2(9),
	CONSTRAINT pk_alumno_backup PRIMARY KEY (numMatricula)
);


INSERT INTO ALUMNO_BACKUP SELECT * FROM ALUMNO;

SELECT * FROM ALUMNO_BACKUP;














