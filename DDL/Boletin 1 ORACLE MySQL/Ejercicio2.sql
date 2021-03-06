CREATE TABLE COMERCIAL(
	id NUMBER(10),
	nombre VARCHAR2(100),
	apellido1 VARCHAR2(100),
	apellido2 VARCHAR2(100),
	ciudad VARCHAR2(100),
	comision NUMBER(3,2),
	CONSTRAINT pk_comercial PRIMARY KEY (id)
);

CREATE TABLE CLIENTE(
	id NUMBER(10),
	nombre VARCHAR2(100),
	apellido1 VARCHAR2(100),
	apellido2 VARCHAR2(100),
	ciudad VARCHAR2(100),
	categoria NUMBER(10),
	CONSTRAINT pk_cliente PRIMARY KEY (id)

);



CREATE TABLE PEDIDO (
	id NUMBER(10),
	cantidad NUMBER(3,2),
	fecha DATE,
	id_cliente NUMBER(10),
	id_comercial NUMBER(10),
	CONSTRAINT pk_pedido PRIMARY KEY (id),
	CONSTRAINT fk_id_cliente_pedido FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id),
	CONSTRAINT fk_id_comercial_pedido FOREIGN KEY (id_comercial) REFERENCES COMERCIAL(id)

);
