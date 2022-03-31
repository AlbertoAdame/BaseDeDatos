CREATE TABLE ZONA (
	nombre VARCHAR2(20),
	localidad VARCHAR2(20),
	extension NUMBER(4),
	protegida VARCHAR2(2) CHECK (protegida IN('SI','NO')),
	CONSTRAINT pk_zona PRIMARY KEY (nombre)

);

CREATE TABLE PERSONA (
	DNI VARCHAR2(9),
	nombre VARCHAR2(20) UNIQUE,
	direccion VARCHAR2(20),
	telefono VARCHAR2(9),
	usuario VARCHAR2(25), 
	CONSTRAINT pk_persona PRIMARY KEY (DNI)
);


CREATE TABLE FAMILIA (
	nombre VARCHAR2(20),
	caracateristicas VARCHAR2(50),
	CONSTRAINT pk_familia PRIMARY KEY (nombre)

);

CREATE TABLE GENERO (
	nombre VARCHAR2(20),
	caracateristicas VARCHAR2(50),
	nombre_familia VARCHAR2(20),
	CONSTRAINT pk_genero PRIMARY KEY (nombre),
	CONSTRAINT fk_genero FOREIGN KEY (nombre_familia) REFERENCES FAMILIA(nombre)

);

CREATE TABLE ESPECIE (
	nombre VARCHAR2(20),
	caracateristicas VARCHAR2(50),
	nombre_genero VARCHAR2(20),
	CONSTRAINT pk_especie PRIMARY KEY (nombre),
	CONSTRAINT fk_especie FOREIGN KEY (nombre_genero) REFERENCES GENERO(nombre)

);

CREATE TABLE COLECCION (
	precio NUMBER(4,2),
	fecha_inicio DATE,
	num_ejemplares NUMBER(3),
	DNI VARCHAR2 (9) NOT NULL, 
	CONSTRAINT pk_coleccion PRIMARY KEY (DNI),
	CONSTRAINT fk_coleccion_persona FOREIGN KEY (DNI) REFERENCES PERSONA(DNI),
	CONSTRAINT ck_coleccion CHECK (num_ejemplares>=1 AND num_ejemplares<=150)
	
);


CREATE TABLE EJEMPLAR_MARIPOSA (
	fecha_captura DATE,
	hora_captura VARCHAR2(5),
	nombre_comun VARCHAR2(20),
	precio_ejemplar NUMBER(3,2) CHECK (precio_ejemplar>0),
	nombre_especie VARCHAR2(20),
	nombre_zona VARCHAR2(20),
	DNI_persona VARCHAR2(9),
	DNI_colección VARCHAR2(9),
	fecha_coleccion DATE,
	CONSTRAINT pk_ejemplar_mariposa PRIMARY KEY (fecha_captura, hora_captura),
	CONSTRAINT fk_ejemplar_especie FOREIGN KEY (nombre_especie) REFERENCES ESPECIE(nombre),
	CONSTRAINT fk_ejemplar_zona FOREIGN KEY (nombre_zona) REFERENCES ZONA(nombre),
	CONSTRAINT fk_ejemplar_persona FOREIGN KEY (DNI_persona) REFERENCES PERSONA(DNI),
	CONSTRAINT fk_ejemplar_coleccion FOREIGN KEY (DNI_persona) REFERENCES COLECCION(DNI)

);

ALTER TABLE PERSONA ADD apellidos VARCHAR2(30);
ALTER TABLE ZONA ADD CONSTRAINT ck_extension_zona CHECK (extension>=100 AND extension<=1500);
ALTER TABLE EJEMPLAR_MARIPOSA DISABLE CONSTRAINT ck_coleccion;

CREATE INDEX ID_fecha_cap ON ejemplar_mariposa (fecha_captura);

ALTER SESSION SET"_oracle_script"=true;

--USUARIO

CREATE USER usuario IDENTIFIED BY usuario;
CREATE ROLE rol_usuario;
GRANT SELECT ON persona TO rol_usuario;
GRANT SELECT ON ejemplar_mariposa TO rol_usuario;
GRANT SELECT ON coleccion TO rol_usuario;
GRANT rol_usuario TO usuario;

--EMPLEADO


CREATE USER empleado IDENTIFIED BY empleado;
CREATE ROLE rol_empleado;
GRANT SELECT ON persona TO rol_empleado;
GRANT SELECT ON ejemplar_mariposa TO rol_empleado;
GRANT SELECT ON coleccion TO rol_empleado;
GRANT rol_empleado TO empleado;

--ADMINISTRADOR

CREATE USER administrador IDENTIFIED BY administrador;
CREATE ROLE rol_administrador;
GRANT CONNECT, RESOURCE, DBA TO rol_administrador;
GRANT rol_administrador TO administrador;

--ELIMINAR ROLES

DROP ROLE rol_usuario;
DROP ROLE rol_empleado;
DROP ROLE rol_administrador;

--ELIMINAR INDICES

DROP INDEX ID_nombre_apellido;

--ELIMINAR TABLAS
 DROP TABLE coleccion CASCADE CONSTRAINT;
 DROP TABLE ejemplar_mariposa CASCADE CONSTRAINT;
 DROP TABLE especie CASCADE CONSTRAINT;
 DROP TABLE familia CASCADE CONSTRAINT;
 DROP TABLE genero CASCADE CONSTRAINT;
 DROP TABLE persona CASCADE CONSTRAINT;
 DROP TABLE zona CASCADE CONSTRAINT;


--ELIMINAR USUARIO

DROP USER usuario;
DROP USER empleado;
DROP USER administrador;














