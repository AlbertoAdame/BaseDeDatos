CREATE TABLE VEHICULOS
( 
	matricula VARCHAR2(7),
	marca VARCHAR2(10) NOT NULL,
	modelo VARCHAR2(10) NOT NULL,
	fecha_compra DATE CHECK (EXTRACT (YEAR from fecha_compra) >2001),
	precio_por_dia NUMBER(5,2) CHECK (precio_por_dia >0),
	CONSTRAINT PK_VEHICULOS PRIMARY KEY (matricula)
);

CREATE TABLE CLIENTES
( 
	dni VARCHAR2(9),
	nombre VARCHAR2(30) NOT NULL,
	nacionalidad VARCHAR2(30),
	fecha_nacimiento DATE,
	direccion VARCHAR2(50),
	CONSTRAINT PK_CLIENTES PRIMARY KEY (dni)
);

CREATE TABLE ALQUILERES
( 
	matricula VARCHAR2(7) NOT NULL,
	dni VARCHAR2(10) NOT NULL,
	fecha_hora DATE,
	num_dias NUMBER(2) NOT NULL,
	kilometros NUMBER(4) DEFAULT 0,
	CONSTRAINT PK_ALQUILERES PRIMARY KEY (fecha_hora),
	CONSTRAINT FK_VEHICULOS FOREIGN KEY (matricula) REFERENCES VEHICULOS(matricula),
	CONSTRAINT FK_CLIENTES FOREIGN KEY (dni) REFERENCES CLIENTES(dni)
);

















CREATE TABLE JUGADORES
(
	codJugador VARCHAR2(4),
	nombre VARCHAR2(30) NOT NULL,
	fechaNacimiento DATE,
	demarcacion VARCHAR2(10),
	codEquipo VARCHAR2(4),
	CONSTRAINT pk_codJugador PRIMARY KEY  (codJugador),
	CONSTRAINT fk_codEquipo FOREIGN KEY (codEquipo) REFERENCES EQUIPOS(codEquipo)
);


CREATE TABLE EQUIPOS
(
	codEquipo VARCHAR2(4),
	nombre VARCHAR2(30) NOT NULL,
	localidad VARCHAR2(15),
	CONSTRAINT pk_codEquipo PRIMARY KEY (codEquipo)
);


CREATE TABLE PARTIDOS
(
	codPartido VARCHAR2(4),
	codEquipoLocal VARCHAR2(4),
	codEquipoVisitante VARCHAR2(4),
	fecha DATE CHECK (EXTRACT (MONTH FROM fecha) NOT IN (6,7)),
	competicion VARCHAR2(4) CHECK (competicion IN ('Copa','Liga')),
	jornada VARCHAR2(20),
	CONSTRAINT pk_codPartido PRIMARY KEY (codPartido),
	CONSTRAINT fk_codEquipoLocal FOREIGN KEY (codEquipoLocal) REFERENCES EQUIPOS(codEquipo),
	CONSTRAINT fk_codEquipoVisitante FOREIGN KEY (codEquipoVisitante) REFERENCES EQUIPOS(codEquipo)
);


CREATE TABLE INCIDENCIAS
(
	numIncidencia VARCHAR2(6),
	codPartido VARCHAR2(4),
	codJugador VARCHAR(4),
	minuto NUMBER(2) CHECK (minuto >=1 AND minuto <=99),
	tipo VARCHAR2(20),
	CONSTRAINT numIncidencia PRIMARY KEY (numIncidencia),
	CONSTRAINT fk_codPartido FOREIGN KEY (codPartido) REFERENCES PARTIDOS(codPartido),
	CONSTRAINT fk_codJugador FOREIGN KEY (codJugador) REFERENCES JUGADORES(codJugador)
);


ALTER TABLE JUGADORES ADD CONSTRAINT ch_jugadores_nombre CHECK (INITCAP(nombre) = nombre);

ALTER TABLE JUGADORES ADD CONSTRAINT ch_jugadores_demarcacion CHECK (demarcacion IN ('Portero','Defensa','Medio','Delantero'));

ALTER TABLE EQUIPOS ADD CONSTRAINT ch_equipos_nombre CHECK (regexp_like(nombre,'^[0,9](1)'));

ALTER TABLE INCIDENCIAS MODIFY tipo NOT NULL;

ALTER TABLE EQUIPOS ADD golesMarcados NUMBER(2);