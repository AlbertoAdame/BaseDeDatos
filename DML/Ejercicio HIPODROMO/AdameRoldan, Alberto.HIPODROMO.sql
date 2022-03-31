CREATE TABLE CABALLOS(
	codCaballo VARCHAR2(4),
	nombre VARCHAR2 (20) NOT NULL,
	peso NUMBER(3),
	fecha_nacimiento DATE,
	propietario VARCHAR2(25),
	nacionalidad VARCHAR2(20),
	CONSTRAINT ck_fecha_nacimineto CHECK (EXTRACT(YEAR FROM fecha_nacimiento)>2000),
	CONSTRAINT ck_peso CHECK (peso>=240 AND peso<=300),
	CONSTRAINT ck_nacionalidad CHECK (nacionalidad=UPPER(nacionalidad)),
	CONSTRAINT pk_caballos PRIMARY KEY (codCaballo)
);

CREATE TABLE CARRERAS(
	codCarrera VARCHAR2(4),
	fecha_y_hora DATE,
	importe_premio NUMBER(6),
	apuesta_limite NUMBER(5,2),
	CONSTRAINT ck_fecha_y_hora CHECK (to_char(fecha_y_hora,'hh24:mi')BETWEEN '09:00' AND '14:20'),
	CONSTRAINT ck_apuesta_limite CHECK (apuesta_limite<20000),
	CONSTRAINT pk_carreras PRIMARY KEY (codCarrera)
);


CREATE TABLE CLIENTES(
	DNI VARCHAR2(10),
	nombre VARCHAR2(20),
	nacionalidad VARCHAR2(20),
	CONSTRAINT ck_DNI_clientes CHECK (regexp_like(DNI,'[0-9]{8}[A-Z]{1}')),
	CONSTRAINT ck_nacionalidad_clientes CHECK (nacionalidad=UPPER(nacionalidad)),
	CONSTRAINT pk_Clientes PRIMARY KEY (DNI)
);


CREATE TABLE PARTICIPANTES (
	codCaballo VARCHAR2(4),
	codCarrera VARCHAR2(4),
	dorsal NUMBER(2) NOT NULL,
	jockey VARCHAR2(10) NOT NULL,
	posicionFinal NUMBER(2),
	CONSTRAINT ck_posicionFInal CHECK (posicionFinal>0),
	CONSTRAINT pk_participantes PRIMARY KEY (codCaballo,codCarrera),
	CONSTRAINT fk_Participantes_codCaballo FOREIGN KEY (codCaballo) REFERENCES CABALLOS(codCaballo),
	CONSTRAINT fk_Participantes_codCarrera FOREIGN KEY (codCarrera) REFERENCES CARRERAS(codCarrera)
);


CREATE TABLE APUESTAS (
	DNIClientes VARCHAR2(10),
	codCaballo VARCHAR2(4),
	codCarrera VARCHAR2(4),
	importe NUMBER(6) DEFAULT 300 NOT NULL,
	tantoPorUno NUMBER(4,2),
	CONSTRAINT ck_tantoPorUno CHECK (tantoPorUno>1),
	CONSTRAINT pk_apuestas PRIMARY KEY (DNIClientes,codCaballo,codCarrera),
	CONSTRAINT fk_apuestas_DNIclientes FOREIGN KEY (DNIclientes) REFERENCES CLIENTES(DNI) ON DELETE CASCADE,
	CONSTRAINT fk_apuestas_codCaballo FOREIGN KEY (codCaballo) REFERENCES CABALLOS(codCaballo) ON DELETE CASCADE,
	CONSTRAINT fk_apuestas_codCarrera FOREIGN KEY (codCarrera) REFERENCES CARRERAS(codCarrera) ON DELETE CASCADE
);

--He puesto peso en VARCHAR, y no en number, aunque se lo traga igual

INSERT INTO CABALLOS VALUES ('1234','Luz','298',NULL,NULL,NULL);
SELECT*FROM CABALLOS;

INSERT INTO CLIENTES VALUES ('12325689M',NULL, 'ESCOCES');
INSERT INTO CARRERAS VALUES ('1235',NULL,NULL,NULL);
INSERT INTO APUESTAS VALUES ('12325689M','1234','1235',2000,30);

/*Inscribe a 2 caballos  en la carrera cuyo código es C6. 
 * La carrera aún no se ha celebrado. Invéntate los jockeys y los dorsales y los caballos.*/

INSERT INTO CABALLOS VALUES ('C6','Relampago','290',NULL,'Paco',NULL);
/*INSERT INTO CABALLOS VALUES ('C6','Terremoto','250',NULL,'Paco',NULL);*/
INSERT INTO CARRERAS VALUES ('25',TO_DATE('15/07/2023 10:15', 'DD/MM/YYYY hh24:mi'),NULL,NULL);
INSERT INTO PARTICIPANTES VALUES ('C6','25','30','Luis',NULL);
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

--ALTER TABLE PARTICIPANTES ADD CONSTRAINT ck_jockeys CHECK (regexp_like(jockey,'[A-Z]{1}')); --No estoy seguro si este es así
ALTER TABLE PARTICIPANTES ADD CONSTRAINT ck_jockeys CHECK (jockey=INITCAP(jockey));

ALTER TABLE CARRERAS ADD CONSTRAINT ck_fecha_hora_fecha CHECK (to_char(fecha_y_hora,'DD/MM') BETWEEN '10/03' AND '10/11');
-- probar si va la restrccion de ariba con esto INSERT INTO CARRERAS VALUES ('3',TO_DATE('15/07/2022 11:15', 'DD/MM/YYYY hh24:mi'),NULL,NULL);

SELECT * FROM CARRERAS;
DELETE CARRERAS;

ALTER TABLE CABALLOS ADD CONSTRAINT ck_nacionalidades_caballos_mayus CHECK (nacionalidad IN('ESPAÑOLA','BRITÁNICA','ÁRABE'));
SELECT * FROM CABALLOS;
DELETE CABALLOS;

--Este es interesante (ECHAR UN OJO)

DELETE FROM PARTICIPANTES 
WHERE codCaballo=NULL; --CON ESTO BORRAMOS PARTICIPANTES, POR LO QUE NO SIRVE

SELECT * FROM CARRERAS;*/ 
/*No sé como eliminar una carrera sin saber los participantes*/

ALTER TABLE CLIENTES ADD codigo VARCHAR2(4) NOT NULL UNIQUE; --NO nos dejará si la tabla NO está vacía
SELECT * FROM CLIENTES;

DELETE CLIENTES;

SELECT * FROM CLIENTES;
ALTER TABLE CLIENTES ADD codigo VARCHAR2(4) NOT NULL UNIQUE;

UPDATE CABALLOS
SET codCaballo='C66'
WHERE codCaballo='C6';
SELECT * FROM CABALLOS;--NO sé si ha funcionao
--No tenemos disponible on update cascade

ALTER TABLE APUESTAS ADD premio NUMBER(10,2);

/*DROP TABLE CABALLOS CASCADE CONSTRAINT;
DROP TABLE PARTICIPANTES CASCADE CONSTRAINT;
DROP TABLE CARRERAS CASCADE CONSTRAINT;
DROP TABLE APUESTAS CASCADE CONSTRAINT;
DROP TABLE CLIENTES CASCADE CONSTRAINT;*/

