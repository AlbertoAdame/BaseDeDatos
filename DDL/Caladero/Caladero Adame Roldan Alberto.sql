CREATE TABLE BARCOS(
	matricula VARCHAR2(7),
	nombre VARCHAR2(10), 
	clase VARCHAR2(10),
	armador VARCHAR2(50),
	capacidad NUMBER(30),
	nacionalidad VARCHAR2(20),
	CONSTRAINT pk_matricula PRIMARY KEY (matricula)
);

CREATE TABLE LOTES(
	codigo VARCHAR2(10),
	matricula VARCHAR2(7),
	numkilos NUMBER(10),
	precioporkilosalida NUMBER(10,2),
	precioporkiloadjudicado NUMBER(10,2),
	fechaventa DATE,
	cod_especie VARCHAR2(10),
	CONSTRAINT pk_codigo PRIMARY KEY (codigo),
	CONSTRAINT fk_matricula_barcos FOREIGN KEY (matricula) REFERENCES BARCOS(matricula),
	CONSTRAINT fk_codigo_especia FOREIGN KEY (codigo) REFERENCES ESPECIE(codigo)
);

CREATE TABLE CALADERO(
	codigo VARCHAR(10),
	nombre VARCHAR(10),
	ubicacion VARCHAR2(20),
	especie_principal VARCHAR2(10),
	CONSTRAINT pk_codigo_caladero PRIMARY KEY (codigo)
);

CREATE TABLE ESPECIE(
	codigo VARCHAR2(10),
	nombre VARCHAR2(10),
	tipo VARCHAR2(10),
	cupoPorBarco NUMBER(30),
	caladero_principal VARCHAR2(10),
	CONSTRAINT pk_codigo_especie PRIMARY KEY (codigo),
	CONSTRAINT fk_caladero_principal_especie FOREIGN KEY (caladero_principal) REFERENCES CALADERO(codigo)
);


ALTER TABLE CALADERO ADD CONSTRAINT fk_especie_principal_caladero FOREIGN KEY (especie_principal) REFERENCES ESPECIE(codigo);


CREATE TABLE FECHAS_CAPTURAS_PERMITIDAS(
	cod_especie VARCHAR2(10),
	cod_caladero VARCHAR2(10),
	fecha_inicial DATE,
	fecha_final DATE,
	CONSTRAINT pk_fechas_capturas_permitidas PRIMARY KEY (cod_especie,cod_caladero),
	CONSTRAINT fK_cod_especie_fechas_capturas_permitidas FOREIGN KEY (cod_especie) REFERENCES ESPECIE(codigo),
	CONSTRAINT fK_cod_caladero_fechas_capturas_permitidas FOREIGN KEY (cod_caladero) REFERENCES CALADERO(codigo)
);


/*La fechaventa de la tabla lotes no admite valores nulos.*/

ALTER TABLE LOTES MODIFY fechaventa NOT NULL;

/*El campo precioporkiloadjudicado debe ser mayor que el campo precioporkilosalida.*/

ALTER TABLE LOTES ADD CONSTRAINT ck_lotes_precioporkilo_mayorque CHECK (precioporkiloadjudicado > precioporkilosalida);

/*El campo numkilos y los campos precio de la tabla lotes deben ser mayor que cero*/

ALTER TABLE LOTES ADD CONSTRAINT ck_lotes_numkilos_mayorque CHECK (numkilos > 0);

/*El campo nombre y ubicación de la tabla caladero deben estar siempre en mayúsculas.*/

ALTER TABLE CALADERO ADD CONSTRAINT ck_caladero_mayuscula_nombre CHECK (nombre = UPPER(nombre));
ALTER TABLE CALADERO ADD CONSTRAINT ck_caladero_mayuscula_ubicacion CHECK (ubicacion = UPPER(ubicacion));

/*Hay que tener en cuenta que en ningún caladero se permite ninguna captura de especie desde el 2 de
febrero al 28 de marzo*/

ALTER TABLE fechas_capturas_permitidas ADD CONSTRAINT ck_fecha_inicial CHECK (TO_CHAR(fecha_inicial,'mm/dd') < '02/02' OR TO_CHAR(fecha_inicial,'mm/dd') > '03/28');
ALTER TABLE fechas_capturas_permitidas ADD CONSTRAINT ck_fecha_final CHECK (TO_CHAR(fecha_final,'mm/dd') < '02/02' OR TO_CHAR(fecha_final,'mm/dd') > '03/28');
