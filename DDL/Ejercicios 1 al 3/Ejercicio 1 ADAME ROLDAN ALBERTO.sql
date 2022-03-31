CREATE TABLE TEMA(
	cod_tema NUMBER(5),
	denominacion VARCHAR2(10),
	cod_tema_padre NUMBER(5),
	CONSTRAINT PK_TEMA PRIMARY KEY (cod_tema),
	CONSTRAINT FK_TEMA FOREIGN KEY (cod_tema_padre) REFERENCES TEMA(cod_tema) ON DELETE CASCADE,
	CONSTRAINT ck_cod_tema CHECK (cod_tema_padre > cod_tema)
);

CREATE TABLE AUTOR
(
	cod_autor NUMBER(5),
	nombre VARCHAR2(20) NOT NULL,
	f_nacimiento DATE,
	libro_principal NUMBER(5),
	CONSTRAINT PK_AUTOR PRIMARY KEY (cod_autor)
);

CREATE TABLE LIBRO(
	cod_libro NUMBER(5),
	titulo VARCHAR2(20) NOT NULL,
	f_creacion DATE,
	cod_tema NUMBER(5),
	autor_principal NUMBER(5),
	CONSTRAINT PK_LIBRO PRIMARY KEY (cod_libro),
	CONSTRAINT FK_TEMALIBRO FOREIGN KEY (cod_tema) REFERENCES TEMA(cod_tema),
	CONSTRAINT FK_AUTOR FOREIGN KEY (autor_principal) REFERENCES AUTOR(cod_autor)
);

--ALTER TABLE AUTOR ADD CONSTRAINT FK_LIBRO; 
--FOREIGN KEY (libro_principal) REFERENCES LIBRO(cod_libro) ON DELETE SET NULL;


 
CREATE TABLE LIBRO_AUTOR(
	cod_libro NUMBER(5),
	cod_autor NUMBER(5),
	orden NUMBER(5) CONSTRAINT ck_orden CHECK (orden>=1 AND orden<=5)NOT NULL,
	CONSTRAINT pk_libro_autor PRIMARY KEY (cod_libro, cod_autor),
	CONSTRAINT fk_libroautor FOREIGN KEY (cod_libro) REFERENCES LIBRO(cod_libro), 
	CONSTRAINT fk_autorlibro FOREIGN KEY (cod_autor) REFERENCES  AUTOR(cod_autor)
); 

CREATE TABLE EDITORIAL(
	cod_editorial NUMBER(5),
	denominacion VARCHAR2(50) NOT NULL,
	CONSTRAINT pk_cod_editorial PRIMARY KEY (cod_editorial)
);

CREATE TABLE PUBLICACIONES(
	cod_editorial NUMBER(5),
	cod_libro NUMBER(5),
	precio NUMBER(5,2) NOT NULL check (precio < 0),
	f_publicaciones DATE DEFAULT SYSDATE,
	CONSTRAINT pk_editorial PRIMARY KEY (cod_editorial, cod_libro),
	CONSTRAINT fk_libropublicaciones FOREIGN KEY (cod_libro) REFERENCES LIBRO(cod_libro),
	CONSTRAINT fk_editorialpublicaciones FOREIGN KEY (cod_editorial) REFERENCES EDITORIAL(cod_editorial)
);

DROP TABLE TEMA CASCADE CONSTRAINT;
DROP TABLE AUTOR CASCADE CONSTRAINT;
DROP TABLE LIBRO CASCADE CONSTRAINT;
DROP TABLE LIBRO_AUTOR CASCADE CONSTRAINT;
DROP TABLE EDITORIAL CASCADE CONSTRAINT;
DROP TABLE PUBLICACIONES CASCADE CONSTRAINT;

 