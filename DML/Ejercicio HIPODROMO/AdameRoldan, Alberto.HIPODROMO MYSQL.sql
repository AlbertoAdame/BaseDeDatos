CREATE TABLE CABALLOS(
	codCaballo VARCHAR(4),
	nombre VARCHAR (20) NOT NULL,
	peso INT(3),
	fecha_nacimiento DATE,
	propietario VARCHAR(25),
	nacionalidad VARCHAR(20),
	CONSTRAINT ck_fecha_nacimineto CHECK (EXTRACT(YEAR FROM fecha_nacimiento)>2000),
	CONSTRAINT ck_peso CHECK (peso>=240 AND peso<=300),
	CONSTRAINT ck_nacionalidad CHECK (nacionalidad=UPPER(nacionalidad)),
	CONSTRAINT pk_caballos PRIMARY KEY (codCaballo)
	
);

CREATE TABLE CARRERAS(
	codCarrera VARCHAR(4),
	fecha_y_hora DATE,
	importe_premio INT (6),
	apuesta_limite DOUBLE(5,2),
	/*CONSTRAINT ck_fecha_y_hora CHECK (TO_CHAR(fecha_y_hora,'hh24:mi')BETWEEN '09:00' AND '14:20'),*/
	CONSTRAINT ck_apuesta_limite CHECK (apuesta_limite<20000),
	CONSTRAINT pk_carreras PRIMARY KEY (codCarrera)

);


CREATE TABLE CLIENTES(
	DNI VARCHAR(10),
	nombre VARCHAR(20),
	nacionalidad VARCHAR(20),
/*	CONSTRAINT ck_DNI_clientes CHECK (regexp_like(DNI,'^[0,9](1)')),*/
	CONSTRAINT ck_nacionalidad_clientes CHECK (nacionalidad=UPPER(nacionalidad)),
	CONSTRAINT pk_Clientes PRIMARY KEY (DNI)


);


CREATE TABLE PARTICIPANTES (
	codCaballo VARCHAR(4),
	codCarrera VARCHAR(4),
	dorsal int(2) NOT NULL,
	jockey VARCHAR(10) NOT NULL,
	posicionFinal INT(2),
	CONSTRAINT ck_posicionFInal CHECK (posicionFinal>0),
	CONSTRAINT pk_participantes PRIMARY KEY (codCaballo,codCarrera),
	CONSTRAINT fk_Participantes_codCaballo FOREIGN KEY (codCaballo) REFERENCES CABALLOS(codCaballo),
	CONSTRAINT fk_Participantes_codCarrera FOREIGN KEY (codCarrera) REFERENCES CARRERAS(codCarrera)

);


CREATE TABLE APUESTAS (
	DNIClientes VARCHAR(10),
	codCaballo VARCHAR(4),
	codCarrera VARCHAR(4),
	importe INT(6) DEFAULT 300 NOT NULL,
	tantoPorUno DOUBLE(4,2),
	CONSTRAINT ck_tantoPorUno CHECK (tantoPorUno>1),
	CONSTRAINT pk_apuestas PRIMARY KEY (DNIClientes,codCaballo,codCarrera),
	CONSTRAINT fk_apuestas_DNIclientes FOREIGN KEY (DNIclientes) REFERENCES CLIENTES(DNI) ON DELETE CASCADE,
	CONSTRAINT fk_apuestas_codCaballo FOREIGN KEY (codCaballo) REFERENCES CABALLOS(codCaballo) ON DELETE CASCADE,
	CONSTRAINT fk_apuestas_codCarrera FOREIGN KEY (codCarrera) REFERENCES CARRERAS(codCarrera) ON DELETE CASCADE

);

INSERT INTO CABALLOS VALUES ('1234','Luz','298',NULL,NULL,NULL);
INSERT INTO CLIENTES VALUES ('12325689M',NULL, 'ESCOCES');
INSERT INTO CARRERAS VALUES ('1235',TO_DATE('15/07/2009 09:15', 'DD/MM/YYYY hh24:mi'),NULL,NULL);
INSERT INTO APUESTAS VALUES ('12325689M','1234','1235',2000,30); /*FALLO*/

/*Inscribe a 2 caballos  en la carrera cuyo código es C6. 
 * La carrera aún no se ha celebrado. Invéntate los jockeys y los dorsales y los caballos.*/

INSERT INTO CABALLOS VALUES ('C6','Relampago','290',NULL,'Paco',NULL);
/*INSERT INTO CABALLOS VALUES ('C6','Terremoto','250',NULL,'Paco',NULL);*/
INSERT INTO CARRERAS VALUES ('25',TO_DATE('15/07/2023 10:15', 'DD/MM/YYYY hh24:mi'),NULL,NULL); /*fallo*/
INSERT INTO PARTICIPANTES VALUES ('C6','25','30','Luis',NULL);  /*fALLO*/
/*INSERT INTO PARTICIPANTES VALUES ('C6','25','31','Pedro',NULL);*/

/*NO nos deja pq ambos tienen el mismo codigo*/


/*Inserta dos carreras con los datos que creas necesario.*/
INSERT INTO CARRERAS VALUES ('1',TO_DATE('15/07/2022 11:15', 'DD/MM/YYYY hh24:mi'),NULL,NULL);
INSERT INTO CARRERAS VALUES ('2',TO_DATE('15/07/2022 12:15', 'DD/MM/YYYY hh24:mi'),NULL,NULL);

/*Quita el campo propietario de la tabla caballos*/
ALTER TABLE CABALLOS DROP COLUMN propietario;
SELECT * FROM CABALLOS;

/*6. Añadir las siguientes restricciones a las tablas:
• En la Tabla Participaciones los nombres de los jockeys tienen siempre las iniciales en mayúsculas.
• La temporada de carreras transcurre del 10 de Marzo al 10 de Noviembre.
• La nacionalidad de los caballos sólo puede ser Española, Británica o Árabe.
Si los datos que has introducidos no cumplen las restricciones haz los cambios necesarios para ellos.*/
/*ALTER TABLE PARTICIPANTES ADD CONSTRAINT ck_jockeys CHECK (regexp_like(jockeys,'^[0,9](1)'));*/

/*ALTER TABLE CARRERAS ADD CONSTRAINT ck_fecha_hora_fecha CHECK (to_char(fecha_y_hora,'DD/MM/YYYY') BETWEEN '10/03/****' AND '10/11/****');
SELECT * FROM CARRERAS;*/

ALTER TABLE CABALLOS ADD CONSTRAINT ck_nacionalidades_caballos CHECK (nacionalidad IN('ESPAÑOLA','BRITÁNICA','Árabe'));
SELECT * FROM CABALLOS;

/*DELETE CARRERAS 
WHERE 

SELECT * FROM CARRERAS;*/ 
/*No sé como eliminar una carrera sin saber los participantes*/

ALTER TABLE CLIENTES ADD codigo VARCHAR2(4) NOT NULL UNIQUE; --NO nos dejará si la tabla NO está vacía
SELECT * FROM CLIENTES;

DELETE CLIENTES 
WHERE DNI='12325689M';

SELECT * FROM CLIENTES;
ALTER TABLE CLIENTES ADD codigo VARCHAR2(4) NOT NULL UNIQUE;

/*UPDATE CABALLOS
SET codCaballo='C66'
WHERE codCaballo='C6';
SELECT * FROM CABALLOS;*/
--No tenemos disponible on update cascade

ALTER TABLE APUESTAS ADD premio NUMBER(10,2);

DROP TABLE CABALLOS CASCADE CONSTRAINT;
DROP TABLE PARTICIPANTES CASCADE CONSTRAINT;
DROP TABLE CARRERAS CASCADE CONSTRAINT;
DROP TABLE APUESTAS CASCADE CONSTRAINT;
DROP TABLE CLIENTES CASCADE CONSTRAINT;


