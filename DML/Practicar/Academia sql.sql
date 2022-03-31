CREATE TABLE PROFESORES (
	nombre VARCHAR2 (25),
	apellido1 VARCHAR2 (25),
	apellido2 VARCHAR2 (25),
	dni VARCHAR2 (9), 
	direccion VARCHAR2 (50),
	titulo VARCHAR2 (25),
	gana NUMBER (10),
	CONSTRAINT pk_profesores PRIMARY KEY (dni)
	
);

CREATE TABLE CURSOS (
	nombre_curso VARCHAR2 (25),
	cod_curso NUMBER(1),
	dni_profesor VARCHAR2 (9),
	maximo_alumnos NUMBER (5),
	fecha_inicio DATE,
	fecha_fin DATE,
	num_horas NUMBER (10),
	CONSTRAINT pk_cursos PRIMARY KEY (cod_curso),
	CONSTRAINT fk_cursos_profesores FOREIGN KEY (dni_profesor) REFERENCES PROFESORES(dni)
	
);


CREATE TABLE ALUMNOS (
	nombre VARCHAR2 (25),
	apellido1 VARCHAR2 (25),
	apellido2 VARCHAR2 (25),
	dni VARCHAR2 (9),
	direccion VARCHAR2 (50),
	sexo VARCHAR2 (1),
	fecha_nacimiento DATE,
	curso NUMBER (1),
	CONSTRAINT pk_alumnos PRIMARY KEY (dni),
	CONSTRAINT fk_alumnos_cursos FOREIGN KEY (curso) REFERENCES CURSOS(cod_curso),
	CONSTRAINT ck_sexo CHECK (sexo IN('H','M'))
);



--Apartado 2

INSERT INTO PROFESORES VALUES ('Juan','Arch','López','32432455','Puerta Negra, 4', 'Ing. Informática', 7500);
INSERT INTO PROFESORES VALUES ('María','Oliva','Rubio','43215643','Juan Alfonso 32', 'Lda. Fil. Inglesa', 5400);


INSERT INTO CURSOS VALUES ('Inglés Básico',1,'43215643',15,TO_DATE('01/11/00','DD/MM/YY'),TO_DATE('22/12/00','DD/MM/YY'), 120);
INSERT INTO CURSOS VALUES ('Administración Linux',2,'32432455',NULL,TO_DATE('01/09/00','DD/MM/YY'),NULL, 80);


INSERT INTO ALUMNOS VALUES ('Lucas','Manilva','López','123523','Alhamar,3','H',TO_DATE('01/11/79','DD/MM/YY'),1);
INSERT INTO ALUMNOS VALUES ('Antonio','López','Alcantar','2567567','Maniquí, 21','M',NULL,2);
INSERT INTO ALUMNOS VALUES ('Manuel','Alcantara','Pedrós','3123689','Julian,2','H',NULL,1);
INSERT INTO ALUMNOS VALUES ('Sergio','Pérez','Caballar','4896765','Jarcha,5','H',TO_DATE('03/02/77','DD/MM/YY'),2);

--Apartado 3

INSERT INTO ALUMNOS VALUES ('Sergio','Pérez','Caballar','1235234',NULL,'H',NULL,1);

--Apartado 4

INSERT INTO PROFESORES VALUES ('Juan','Arch','López','32432454','Puerta Negra, 4', 'Ing. Informática', NULL);

--Apartado 5 

INSERT INTO ALUMNOS VALUES ('María','Jaén','Sevilla','789678','Martos,5','M',NULL,NULL);


--Apartado 6

SELECT * FROM ALUMNOS WHERE nombre='Antonio';

UPDATE ALUMNOS SET fecha_nacimiento=TO_DATE('23/12/1976','DD/MM/YYYY') WHERE nombre='Antonio'; 

--Apartado 7

INSERT INTO PROFESORES VALUES ('Alberto','Arch','López','48123165','Huerta, 44', 'Sistema', 1000);
INSERT INTO CURSOS VALUES ('Sistema',5,'48123165',NULL,NULL,NULL, 80);
SELECT * FROM ALUMNOS WHERE nombre='Antonio';
UPDATE ALUMNOS SET curso=5 WHERE nombre='Antonio';

--Apartado 8

INSERT INTO PROFESORES VALUES ('Laura','Jiménez','López','12345689','Huerta, 45', 'Lenguaje', 1200);
SELECT * FROM PROFESORES WHERE nombre LIKE ('%Laura%') AND apellido1 LIKE ('%Jiménez%');
DELETE FROM PROFESORES WHERE nombre LIKE ('%Laura%') AND apellido1 LIKE ('%Jiménez%');

--Apartado 9

SELECT * FROM CURSOS WHERE cod_curso=1;
--DELETE FROM CURSOS WHERE cod_curso=1;
ALTER TABLE ALUMNOS DROP CONSTRAINT fk_alumnos_cursos;
ALTER TABLE ALUMNOS ADD CONSTRAINT fk_alumnos_cursos FOREIGN KEY (curso) REFERENCES CURSOS(cod_curso) ON DELETE CASCADE;

SELECT * FROM CURSOS WHERE cod_curso=1;
DELETE FROM CURSOS WHERE cod_curso=1;

--Apartado 10

ALTER TABLE CURSOS ADD numero_alumnos NUMBER(10);

--Apartado 11

SELECT * FROM ALUMNOS WHERE fecha_nacimiento IS NULL;
UPDATE ALUMNOS SET fecha_nacimiento= TO_DATE('01/01/2012','DD/MM/YY') WHERE fecha_nacimiento IS NULL;

--Apartado 12

ALTER TABLE ALUMNOS DROP COLUMN sexo;

--Apartado 13

SELECT * FROM PROFESORES WHERE titulo LIKE ('%Informática%');
UPDATE PROFESORES SET gana=gana+(gana*0.2) WHERE titulo LIKE ('%Informática%');

--Apartado 14

SELECT * FROM PROFESORES WHERE nombre='Juan' AND apellido1='Arch';
--UPDATE PROFESORES SET dni='234567' WHERE nombre='Juan' AND apellido1='Arch';
--NO va pq está en otra tabla, si ponemos update casacade quizás si

--Apartado 15

SELECT * FROM PROFESORES;
SELECT * FROM PROFESORES WHERE titulo LIKE '%Informática%';
--UPDATE PROFESORES SET dni='7654321' WHERE titulo LIKE '%Informática%' ;

--Apartado 16

SELECT * FROM ALUMNOS WHERE nombre='María' AND apellido1='Jaén';
--UPDATE ALUMNOS SET sexo = 'F' WHERE nombre='María' AND apellido1='Jaén';



/*DROP TABLE PROFESORES CASCADE CONSTRAINT;
DROP TABLE CURSOS CASCADE CONSTRAINT;
DROP TABLE ALUMNOS CASCADE CONSTRAINT;*/













