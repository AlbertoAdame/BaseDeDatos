CREATE TABLE PROFESOR (
	dni VARCHAR2(9) NOT NULL,
	nombre VARCHAR2(10),
	sueldo NUMBER(4,2) NOT NULL,
	dirección VARCHAR2(10),
	titulacion VARCHAR2(15),
	CONSTRAINT pk_dni_profesor PRIMARY KEY (dni)

);

CREATE TABLE CURSO (
	codigo VARCHAR2(10) NOT NULL,
	nombre VARCHAR2(10) NOT NULL UNIQUE,
	num_horas NUMBER(10) NOT NULL,
	fecha_fin DATE,
	fecha_inicio DATE,
	profesor VARCHAR2(9),
	dni_alumno VARCHAR(9),
	max_alumnos NUMBER(2),
	CONSTRAINT pk_curso PRIMARY KEY (codigo),
	CONSTRAINT fk_dni_curso FOREIGN KEY (profesor) REFERENCES PROFESOR(dni),
	CONSTRAINT ck_curso_fechas CHECK (fecha_fin>fecha_inicio)
	

CREATE TABLE ALUMNO (
	dni VARCHAR2(9),
	nombre VARCHAR2(10),
	direccion VARCHAR2(10),
	sexo VARCHAR2(1),
	fecha_nacimiento DATE,
	codigo_curso VARCHAR2(10),
	CONSTRAINT pk_dni PRIMARY KEY (dni),
	CONSTRAINT fk_alumno FOREIGN KEY (codigo_curso) REFERENCES CURSO(codigo),
	CONSTRAINT ck_sexo CHECK (sexo IN ('H','M'))
);



);

/*DROP TABLE ALUMNO CASCADE CONSTRAINT;
DROP TABLE CURSO CASCADE CONSTRAINT;
DROP TABLE PROFESOR CASCADE CONSTRAINT;*/
