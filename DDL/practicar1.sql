CREATE TABLE ARTICULOS (
	articulo VARCHAR2(20) NOT NULL,
	cod_fabricante NUMBER(3) NOT NULL,
	peso NUMBER(3) NOT NULL,
	categoria VARCHAR2(10) NOT NULL,
	precio_venta NUMBER(4,2),
	precio_costo NUMBER(4,2),
	existencias NUMBER(5),
	CONSTRAINT pk_articulos PRIMARY KEY (articulo, cod_fabricante, peso, categoria),
	CONSTRAINT fk_articulos_cod_fabricante FOREIGN KEY (cod_fabricante) REFERENCES FABRICANTES(cod_fabricante)
	CONSTRAINT ck_precios CHECK (precio_venta >0 AND precio_costo >0),
	CONSTRAINT ck_categoria CHECK (categoria IN('PRIMERA','SEGUNDA','TERCERA')

);

CREATE TABLE TIENDAS (
	nif VARCHAR2(10) NOT NULL,
	nombre VARCHAR(20),
	direccion VARCHAR(20),
	poblacion VARCHAR(20),
	provincia VARCHAR(20),
	cod_postal NUMBER(5) CHECK (cod_postal<=5 AND cod_postal>0)
	CONSTRAINT pk_nif PRIMARY KEY (nif),
	CONSTRAINT ck_provincia CHECK (provincia=UPPER(provincia)

);

CREATE TABLE FABRICANTES(
	cod_fabricante NUMBER(3) NOT NULL,
	nombre VARCHAR2(15),
	pais VARCHAR(15),
	CONSTRAINT pk_fabricantes PRIMARY KEY (cod_fabricante),
	CONSTRAINT ck_nombre_y_pais CHECK(nombre=UPPER(nombre AND pais=UPPER(pais)))

);

CREATE TABLE PEDIDOS(
	nif VARCHAR2(10) NOT NULL,
	articulo VARCHAR2(20) NOT NULL,
	cod_fabricante NUMBER(3) NOT NULL,
	peso NUMBER(3) NOT NULL,
	categoria VARCHAR2(10) NOT NULL,
	fecha_pedido DATE NOT NULL,
	unidades_pedidas NUMBER(4),
	CONSTRAINT pk_pedidos PRIMARY KEY (nif,articulo,cod_fabricante,peso,categoria,fecha_pedido),
	CONSTRAINT fk_pedidos_cod_fabricante FOREIGN KEY (cod_fabricante) REFERENCES FABRICANTES(cod_fabricantes),
	CONSTRAINT ck_unidades CHECK (unidades_pedidas>0),
	CONSTRAINT fk_pedidos_varias FOREIGN KEY (articulo,cod_fabricante,peso,categoria) REFERENCES ARTICULOS(articulo,cod_fabricante,peso,categoria) ON DELETE CASCADE,
	CONSTRAINT fk_pedidos_nif FOREIGN KEY (nif) REFERENCES TIENDAS(nif)

);

CREATE TABLE VENTAS(
	nif VARCHAR2(10) NOT NULL,
	articulo VARCHAR2(20) NOT NULL,
	cod_fabricante NUMBER(3) NOT NULL,
	peso NUMBER(3) NOT NULL,
	categoria VARCHAR2(10) NOT NULL,
	fecha_pedido DATE DEFAULT SYSDATE,
	unidades_vendidas NUMBER(4),
	CONSTRAINT pk_ventas PRIMARY KEY (nif,articulo,cod_fabricante,peso,categoria,fecha_venta),
	
);

ALTER TABLE PEDIDOS MODIFY unidades_pedidas NUMBER(6);
ALTER TABLE VENTAS MODIFY unidades_vendidas NUMBER(6);

ALTER TABLE PEDIDOS ADD pvp NUMBER(5,2);
ALTER TABLE VENTAS ADD pvp NUMBER(5,2);

ALTER TABLE FABRICANTE DROP COLUMN pais;

ALTER TABLE VENTAS ADD CONSTRAINT ck_ventasunidades CHECK(unidades_vendidas>=100);

ALTER TABLE VENTAS DROP CONSTRAINT ck_ventasunidades;

DROP TABLE VENTAS CASCADE CONSTRAINT;
DROP TABLE ARTICULOS CASCADE CONSTRAINT;
DROP TABLE TIENDAS CASCADE CONSTRAINT;
DROP TABLE FABRICANTES CASCADE CONSTRAINT;
DROP TABLE PEDIDOS CASCADE CONSTRAINT;
