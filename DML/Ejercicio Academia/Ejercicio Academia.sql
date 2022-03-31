CREATE TABLE PROFESORES(
	nombre VARCHAR2 (25),
	apellido1 VARCHAR2 (20),
	apellido2 VARCHAR2 (20),
	dni VARCHAR2(9),
	direccion VARCHAR2 (20),
	titulo VARCHAR2(50),
	gana NUMBER(10),
	CONSTRAINT pk_profesores PRIMARY KEY (dni)

);

CREATE TABLE CURSOS(
	codigo_curso VARCHAR2 (10),	
	nombre_curso VARCHAR2 (20),
	maximo_alumnos NUMBER (20),
	dni_profesor VARCHAR2 (9),
	fecha_inicio DATE,
	fecha_fin DATE,
	num_horas NUMBER (10),
	CONSTRAINT pk_cursos PRIMARY KEY (codigo_curso),
	CONSTRAINT fk_cursos FOREIGN KEY (dni_profesor) REFERENCES PROFESORES(dni)

);
SELECT * FROM CURSOS;

CREATE TABLE ALUMNOS (	
	nombre VARCHAR2 (20),
	apellido1 VARCHAR2 (20),
	apellido2 VARCHAR2 (20),
	dni VARCHAR2 (9),
	direccion VARCHAR2 (20),
	sexo VARCHAR2 (1),
	fecha_nacimiento DATE,
	curso VARCHAR2 (10) UNIQUE,
	CONSTRAINT pk_alumnos PRIMARY KEY (dni),
	CONSTRAINT fk_curso FOREIGN KEY (curso) REFERENCES CURSOS(codigo_curso),
	CONSTRAINT ck_sexo CHECK (sexo IN('H','M'))
	
);

DROP TABLE ALUMNOS CASCADE CONSTRAINT;
DROP TABLE CURSOS CASCADE CONSTRAINT;
DROP TABLE PROFESORES CASCADE CONSTRAINT;

INSERT INTO CURSOS (nombre_curso,codigo_curso,maximo_alumnos,fecha_inicio,fecha_fin,num_horas) VALUES ('Inglés Básico','1','43215643',TO_DATE('01/11/00','DD/MM/YY'),TO_DATE('22/12/00','DD,MM,YY'),120);
INSERT INTO CURSOS (nombre_curso,codigo_curso,fecha_inicio,num_horas) VALUES ('Administración Linux','2','32432455',TO_DATE('01/09/00','DD/MM/YY'),80);

INSERT INTO ALUMNOS (nombre,apellido1,apellido2,dni,direccion,sexo,fecha_nacimiento,curso) VALUES ('Lucas','Manilva','López','123523','Alhamar,3','H',TO_DATE('11/01/79','DD/MM/YY'),'1');
INSERT INTO ALUMNOS (nombre,apellido1,apellido2,dni,direccion,sexo,curso) VALUES ('Antonio','López','Alcantara','2567567','Maniquí, 21','M','2');
INSERT INTO ALUMNOS (nombre,apellido1,apellido2,dni,direccion,sexo,curso) VALUES ('Manuel','Alcantara','Pedrós','3123689','Julian, 2','H','1');
INSERT INTO ALUMNOS (nombre,apellido1,apellido2,dni,direccion,sexo,fecha_nacimiento,curso) VALUES ('José','Pérez','Caballar','4896765','Jarcha,5','H',03/02/77,'3');*/

INSERT INTO PROFESORES (nombre,apellido1,apellido2,dni,direccion,titulo,gana) VALUES ('Juan', 'Arch','López','32432455','Puerta Negra,4','Inq. Informática',7500);
INSERT INTO PROFESORES (nombre,apellido1,apellido2,dni,direccion,titulo,gana) VALUES ('María','Oliva','Rubio','43215643','Juan Alfonso, 32','Lda. Fil. Inglesa',5400);



/*Insertar en alumnos*/

/*INSERT INTO ALUMNOS (nombre,apellido1,apellido2,dni,direccion,sexo,curso) VALUES ('Sergio','Navas','Retal','123523',NULL,'H','1');*/


/*Insertar en profesor*/

/*INSERT INTO PROFESORES (nombre,apellido1,apellido2,dni,direccion,titulo,gana) VALUES ('Juan','Arch','López','32432455','Puerta Negra, 4','Ing. Informática',NULL);*/


/*Insertar en estudiante*/

INSERT INTO ALUMNOS (nombre,apellido1,apellido2,dni,direccion,sexo,fecha_nacimiento,curso) VALUES ('María','Jaén','Sevilla','789678','Martos,5','M',NULL,NULL);


/*6.- La fecha de nacimiento de Antonia López está equivocada. La verdadera es 23 de diciembre de 1976.*/

--UPDATE ALUMNOS
--SET fecha_nacimiento='23/12/1976'
--WHERE fecha_nacimiento=NULL;

/*7.-  Cambiar a Antonia López al curso de código 5.*/

--UPDATE ALUMNOS
--SET curso='5'
--WHERE curso='2';

/*8.- Eliminar la profesora Laura Jiménez*/

--DELETE PROFESORES WHERE nombre='Laura';

/*9.- Borrar el curso con código 1.*/

--DELETE CURSOS WHERE cod_curso='1';

/*10.- Añadir un campo llamado numero_alumnos en la tabla curso*/



/*11.- Modificar la fecha de nacimiento a 01/01/2012 en aquellos alumnos que no tengan fecha de nacimiento.*/

--UPDATE ALUMNOS
--SET fecha_nacimiento='01/01/2012'
--WHERE fecha_alumno=NULL;

/*12.- Borra el campo sexo en la tabla de alumnos.*/

--DELETE SEXO;

/*13.- Modificar la tabla profesores para que los  profesores de Informática cobren un 20 pro ciento más de lo que cobran actualmente.*/

--UPDATE PROFESORES
--SET gana=gana*0,8
--WHERE titulo='Informatica';

/*14.- Modifica el dni de Juan Arch a 1234567*/

--UPDATE PROFESORES
--SET dni='1234567'
--WHERE nombre='Juan';

/*15.- Modifica el dni de todos los profesores de informática para que tengan el dni 7654321*/


--UPDATE PROFESORES
--SET dni='7654321'


/*16.- Cambia el sexo de la alumna María Jaén a F.*/

--UPDATE PROFESORES
--SET sexo='F'
--WHERE nombre='María';