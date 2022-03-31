CREATE TABLE TIENDAS (
	nif VARCHAR2(10) NOT NULL,
	nombre VARCHAR2(20),
	direccion VARCHAR2(20),
	poblacion VARCHAR2(20),
	provincia VARCHAR2(20),
	cod_postal NUMBER(5),
	CONSTRAINT pk_nif PRIMARY KEY (nif),
	CONSTRAINT ck_provincia CHECK (provincia=UPPER(provincia))
);

CREATE TABLE FABRICANTES (
	cod_fabricante NUMBER(3) NOT NULL,
	nombre VARCHAR2(15),
	pais VARCHAR2(15),
	CONSTRAINT pk_cod_fabricante PRIMARY KEY (cod_fabricante),
	CONSTRAINT ck_nombre CHECK (nombre=UPPER(nombre)),
	CONSTRAINT ck_pais CHECK (pais=UPPER(pais))
);

CREATE TABLE ARTICULOS (
	articulo VARCHAR2(20) NOT NULL,
	cod_fabricante NUMBER(3) NOT NULL,
	peso NUMBER(3) NOT NULL,
	categoria VARCHAR2(10) NOT NULL,
	precio_venta NUMBER(4,2),
	precio_costo NUMBER(4,2),
	existencias NUMBER(5),
	CONSTRAINT pk_articulos PRIMARY KEY (articulo,cod_fabricante,peso,categoria),
	CONSTRAINT fk_cod_fabricante FOREIGN KEY (cod_fabricante) REFERENCES FABRICANTES(cod_fabricante),
	CONSTRAINT ck_articulos CHECK (precio_venta>0 AND precio_costo>0 AND peso>0),
	CONSTRAINT ck_categoria CHECK (categoria IN ('PRIMERO','SEGUNDO','TERCERO'))
);


CREATE TABLE PEDIDOS (
	nif VARCHAR2(10) NOT NULL,
	articulo VARCHAR2(20) NOT NULL,
	cod_fabricante NUMBER (3) NOT NULL,
	peso NUMBER(3) NOT NULL,
	categoria VARCHAR2(10) NOT NULL,
	fecha_pedida DATE NOT NULL,
	unidades_pedidas NUMBER(4),
	CONSTRAINT pk_pedidos PRIMARY KEY (nif,articulo,cod_fabricante,peso,categoria,fecha_pedida),
	CONSTRAINT fk_cod_fabricante_pedidos FOREIGN KEY (cod_fabricante) REFERENCES FABRICANTES(cod_fabricante),
	CONSTRAINT fk_varias_articulos FOREIGN KEY (articulo,cod_fabricante,peso,categoria) REFERENCES ARTICULOS(articulo,cod_fabricante,peso,categoria) ON DELETE CASCADE,
	CONSTRAINT fk_nif FOREIGN KEY (nif) REFERENCES TIENDAS(nif),
	CONSTRAINT ck_unidades_pedidas_pedidos CHECK (unidades_pedidas>0)
);


CREATE TABLE VENTAS (
	nif VARCHAR2(10) NOT NULL,
	articulo VARCHAR2(20) NOT NULL,
	cod_fabricante NUMBER(3) NOT NULL,
	peso NUMBER(10) NOT NULL,
	categoria VARCHAR2(10) NOT NULL,
	fecha_venta DATE DEFAULT SYSDATE NOT NULL ,
	unidades_vendidas NUMBER(4),
	CONSTRAINT pk_ventas PRIMARY KEY (nif,articulo,cod_fabricante,peso,categoria,fecha_venta),
	CONSTRAINT fk_cod_fabricante_ventas FOREIGN KEY (cod_fabricante) REFERENCES FABRICANTES(cod_fabricante),
	CONSTRAINT ck_unidades_vendidas CHECK (unidades_vendidas>0),
	CONSTRAINT fk_varias_ventas FOREIGN KEY (articulo,cod_fabricante,peso,categoria) REFERENCES ARTICULOS(articulo,cod_fabricante,peso,categoria) ON DELETE CASCADE,
	CONSTRAINT fk_nif_ventas FOREIGN KEY (nif) REFERENCES TIENDAS(nif)
);

Cuando ya estén creadas las tablas realiza las siguientes modificaciones:
1. Modificar las columnas de las tablas pedidos y ventas para que las
unidades_vendidas y las unidades_pedidas puedan almacenar cantidades numéricas
de 6 dígitos.

ALTER TABLE VENTAS MODIFY unidades_vendidas NUMBER(6);
ALTER TABLE PEDIDOS MODIFY unidades_pedidas NUMBER(6);

2. Añadir a las tablas pedidos y ventas una nueva columna para que almacenen el PVP
del artículo.

ALTER TABLE PEDIDOS ADD pvp_articulos NUMBER(5,2);

3. Borra la columna pais de la tabla fabricante.

ALTER TABLE FABRICANTES DROP COLUMN pais;

4. Añade una restricción que indique que las unidades vendidas son como mínimo 100

ALTER TABLE VENTAS ADD CONSTRAINT ck_unidades_vendidas_ventas CHECK (unidades_vendidas>99) /*con los dos puntos da fallo, creo que es por el 10 de arriba*/

5. Borra la restricción anterior

ALTER TABLE VENTAS DROP CONSTRAINT ck_unidades_vendidas

6. Borra todas las tablas creadas

/*DROP TABLE ARTICULOS CASCADE CONSTRAINT;
DROP TABLE TIENDAS CASCADE CONSTRAINT;
DROP TABLE FABRICANTES CASCADE CONSTRAINT;
DROP TABLE PEDIDOS CASCADE CONSTRAINT;
DROP TABLE VENTAS CASCADE CONSTRAINT;*/


