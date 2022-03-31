CREATE TABLE DEPARTAMENTO(
	id NUMBER(10),
	nombre VARCHAR2(50),
	CONSTRAINT pk_departamento PRIMARY KEY (id)
);

CREATE TABLE GRADO(
	id NUMBER(10),
	nombre VARCHAR2(100),
	CONSTRAINT pk_grado PRIMARY KEY (id)
);

CREATE TABLE CURSO_ESCOLAR(
	id NUMBER(10),
	anyo_inicio NUMBER(4),
	anyo_fin NUMBER(4),
	CONSTRAINT pk_curso_escolar PRIMARY KEY (id)
);

CREATE TABLE PERSONA(
	id NUMBER(10),
	nif VARCHAR2(9),
	nombre VARCHAR2(25),
	apellido1 VARCHAR2(50),
	apellido2 VARCHAR2(50),
	ciudad VARCHAR2(25),
	direccion VARCHAR2(50),
	telefono VARCHAR2(9),
	fecha_nacimiento DATE,
	sexo VARCHAR2 (1) CHECK (sexo IN ('H','M')), 
	tipo VARCHAR2 (10) CHECK (tipo IN ('alto','bajo')), 
	CONSTRAINT pk_persona PRIMARY KEY (id)
);

CREATE TABLE PROFESOR(
	id_profesor NUMBER(10),
	id_departamento NUMBER(10),
	CONSTRAINT pk_profesor PRIMARY KEY (id_profesor),
	CONSTRAINT fk_profesor_id_profesor FOREIGN KEY (id_profesor) REFERENCES PERSONA(id),
	CONSTRAINT fk_profesor_id_departamento FOREIGN KEY (id_departamento) REFERENCES DEPARTAMENTO(id)
	
);

CREATE TABLE ASIGNATURA(
	id NUMBER(10),
	nombre VARCHAR2(100),
	creditos NUMBER(10,2),
	tipo VARCHAR2(10) CHECK (tipo IN ('alto','bajo')),
	curso NUMBER(3),
	cuatrimestre NUMBER(3),
	id_profesor NUMBER(10),
	id_grado NUMBER(10),
	CONSTRAINT pk_asignatura PRIMARY KEY (id),
	CONSTRAINT fk_asignatura_id_profesor FOREIGN KEY (id_profesor) REFERENCES PROFESOR(id_profesor),
	CONSTRAINT fk_asignatura_id_grado FOREIGN KEY (id_grado) REFERENCES GRADO(id)

);



CREATE TABLE ALUMNO_SE_MATRICULA_ASIGNATURA(
	id_alumno NUMBER(10),
	id_asignatura NUMBER(10),
	id_curso_escolar NUMBER(10),
	CONSTRAINT pk_alumno_se_matricula_asigntura_id_alumnos PRIMARY KEY (id_alumno,id_asignatura,id_curso_escolar),
	
	CONSTRAINT fk_alumno_se_matricula_asigntura_id_alumnos FOREIGN KEY (id_alumno) REFERENCES PERSONA(id),      
	CONSTRAINT fk_alumno_se_matricula_asigntura_id_asignatura FOREIGN KEY (id_asignatura) REFERENCES ASIGNATURA(id),
	CONSTRAINT fk_alumno_se_matricula_asigntura_id_curso_escolar FOREIGN KEY (id_curso_escolar) REFERENCES CURSO_ESCOLAR(id)

);





