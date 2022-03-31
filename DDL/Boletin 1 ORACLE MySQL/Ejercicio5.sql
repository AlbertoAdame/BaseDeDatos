CREATE TABLE DEPARTAMENTO(
	id NUMBER(10),
	nombre VARCHAR2(50),
	CONSTRAINT pk_departamento PRIMARY KEY (id)
);

CREATE TABLE PROFESOR(
	id NUMBER(10),
	nif VARCHAR2(9),
	nombre VARCHAR2(25),
	apellido1 VARCHAR2(50),
	apellido2 VARCHAR2(50),
	ciudad VARCHAR2(25),
	direccion VARCHAR2(50),
	telefono VARCHAR2(9),
	fecha_nacimiento DATE,
	sexo VARCHAR(1) CHECK sexo IN('H','M'),
	id_departamento NUMBER(10),
	CONSTRAINT pk_departamento PRIMARY KEY (id)
	CONSTRAINT fk_profesor FOREIGN KEY id_departamento REFERENCES DEPARTAMENTO(id)
	
);

CREATE TABLE ASIGNATURA(
	id NUMBER(10),
	nombre VARCHAR2(100),
	creditos NUMBER(5,2),
	curso NUMBER(3),
	tipo VARCHAR(10) CHECK sexo IN('Alto','Bajo'),
	id_profesor NUMBER(10),
	id_grado NUMBER(10),
	CONSTRAINT pk_asignatura PRIMARY KEY (id)
	CONSTRAINT fk_asignatura_id_profesor FOREIGN KEY id_profesor REFERENCES PROFESOR(id)
	CONSTRAINT fk_asignatura_id_grado FOREIGN KEY id_grado REFERENCES GRADO(id)

);
CREATE TABLE GRADO(
	id NUMBER(10),
	nombre VARCHAR2(100),
	CONSTRAINT pk_grado PRIMARY KEY (id)

);

CREATE TABLE ALUMNO(
	id NUMBER(10),
	nif VARCHAR2(9),
	nombre VARCHAR2(25),
	apellido1 VARCHAR2(50),
	apellido2 VARCHAR2(50),
	ciudad VARCHAR2(25),
	direccion VARCHAR2(50),
	telefono VARCHAR2(9),
	fecha_nacimiento DATE,
	sexo VARCHAR(1) CHECK sexo IN('H','M'),
	CONSTRAINT pk_departamento PRIMARY KEY (id)

);

CREATE TABLE CURSO_ESCOLAR(
	id NUMBER(10),
	anyo_inicio NUMBER(4),
	anyo_fin NUMBER(4),
	CONSTRAINT pk_grado PRIMARY KEY (id)

);

CREATE TABLE ALUMNO_SE_MATRICULA_ASIGNATURA(


);