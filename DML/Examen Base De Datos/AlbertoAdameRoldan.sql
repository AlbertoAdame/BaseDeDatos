--APARTADO 1
SELECT * FROM PERSONA;
SELECT * FROM ALUMNO;
SELECT * FROM ASIGNATURA;
SELECT * FROM ALUMNO_ASIGNATURA;


INSERT INTO PERSONA VALUES ('48123165N','Alberto','Adame','Sevilla','Huerta',44,'622537953',TO_DATE('08/03/1999','DD/MM/YYYY'),1);
INSERT INTO ALUMNO VALUES ('1','48123165N');
INSERT INTO ALUMNO_ASIGNATURA VALUES ('1','160002',100);


--Apartado 2

SELECT * FROM PROFESOR;
SELECT * FROM ASIGNATURA;
SELECT * FROM TITULACION;

INSERT INTO PERSONA VALUES ('77222122K','MARTA','LÓPEZ MARTOS','SEVILLA','TARFIA',9,'615891432',TO_DATE('22/07/1981','DD/MM/YYYY'),0);

UPDATE PROFESOR
SET dni='77222122K'
WHERE idProfesor='P117';

SELECT * FROM PROFESOR;

--Apartado 3

CREATE TABLE ALUMNOS_MUYREPETIDORES (
	idAsignatura VARCHAR2 (6),
	idAlumno VARCHAR2 (7),
	nombre VARCHAR2 (25),
	apellido VARCHAR2 (50),
	teléfono VARCHAR2 (10),
	CONSTRAINT pk_alumnosMUY PRIMARY KEY (idAlumno),
	CONSTRAINT fk_alumnosMUY_idAsignatura FOREIGN KEY (idAsignatura) REFERENCES ASIGNATURA(idAsignatura),
	CONSTRAINT fk_alumnosMUY_dniAlumno FOREIGN KEY (idAlumno) REFERENCES ALUMNO(idAlumno)
);

INSERT INTO ALUMNOS_MUYREPETIDORES (idAlumno,idAsignatura) SELECT idAlumno,idAsignatura FROM ALUMNO_ASIGNATURA WHERE NUMEROMATRICULA>2;



--Apartado 4

SELECT IdAlumno FROM PERSONA p, ALUMNO a WHERE ciudad LIKE 'Sevilla' AND p.dni = a.dni;
SELECT * FROM ALUMNOS_MUYREPETIDORES WHERE teléfono LIKE '%20%';

ALTER TABLE ALUMNOS_MUYREPETIDORES ADD observaciones VARCHAR2 (200);

UPDATE ALUMNOS_MUYREPETIDORES
SET observaciones = 'Se encuentra en seguimiento'
WHERE teléfono LIKE '%20%' AND idAlumno IN (SELECT IdAlumno FROM PERSONA p, ALUMNO a WHERE ciudad LIKE 'Sevilla' AND p.dni = a.dni);


--Apartado 5

DELETE FROM ALUMNOS_MUYREPETIDORES
WHERE IdAlumno IN (SELECT IdAlumno FROM PERSONA p, ALUMNO a WHERE fecha_nacimiento = TO_DATE('11/1971','MM/YYYY') AND p.dni = a.dni);
SELECT IdAlumno FROM PERSONA p, ALUMNO a WHERE fecha_nacimiento = TO_DATE('11/1971','MM/YYYY') AND p.dni = a.dni;
											
																					
											
--Apartado 6
	
SELECT * FROM TITULACION;
SELECT * FROM RESUMEN_TITULACIONES;

CREATE TABLE RESUMEN_TITULACIONES (
	nombre_titulacion VARCHAR2(30),
	idAlumno VARCHAR2(7),
	idTitulacion VARCHAR2 (6),
	CONSTRAINT pk_resumenTitulaciones PRIMARY KEY (idAlumno,idTitulacion),
	CONSTRAINT fk_resumenTitulaciones_id FOREIGN KEY (idTitulacion) REFERENCES TITULACION(idTitulacion),
	CONSTRAINT fk_resumenTitulaciones_idAlumno FOREIGN KEY (idAlumno) REFERENCES Alumno(idAlumno)
);										


SELECT idAlumno,idTitulacion FROM ALUMNO,TITULACION;

INSERT INTO RESUMEN_TITULACIONES (idAlumno,idTitulacion) SELECT idAlumno,idTitulacion FROM ALUMNO,TITULACION;




/*Apartado 7 . Suponiendo	que	tenemos	el	AUTOCOMMIT desactivado,	¿Qué	pasaría	en	
las	siguientes	situaciones?*/

/*7.1 (0,5	puntos) Si	creo	una	nueva	tabla llamada	FACTURA en	la	base	de	datos	y	
posteriormente	 inserto	 datos sobre	 ella.	 ¿Podrá ver	 esos	 datos	 otro	
programador/a que	trabaje	en	tu	equipo	de	desarrollo y	que	tenga	acceso	a	
la	misma	base	de	datos?. Justifica	la	respuesta.*/



/*Si, siempre y cuando se haya realizado el commit o savepoint.*/ 




/*
7.2 (0,5	puntos) Si	posteriormente	creo	una	nueva	tabla CLIENTE en	la	base	de	
datos.	¿Quedarán	persistidos	los	datos	en	la	base	de	datos?	Indica	qué ocurre	
y	justifica	la	respuesta.*/





--Si, porque tenemos activado el auto-commit






/*7.3 (0,5	puntos) Posteriormente	nos	damos	cuenta	que	alguno	de	los datos	que	
inserté en	la	tabla	FACTURA no	son	correctos. ¿Puedo	volver	a	la	situación	
inicial con	alguna	operación?	Indica	cuál	en	caso	de	ser	posible	y	justifica	la	
respuesta.*/





/*Podríamos activar el "manual-commit", de esta forma haríamo una especie de "guardados" de vez en cuando.
De esta forma si queremos volver a un estado anterior solo tendremos que buscar el COMMIT que hicimos*/






/*7.4 . (0,5	 puntos) Inserto	 datos	 en	 la	 tabla	 CLIENTE	 y	 quiero	 que	 los	 datos	
queden	persistidos	en	la	base	de	datos.	¿Qué operación	necesito	realizar?	
Justifica	la	respuesta.*/






--Tendría que activar el "auto-commit", o bien dandole a "control+4".






/*7.5 (0,5	 puntos) Posteriormente	 quiero	 borrar	solo	 algunos	 datos	 de	 la	 tabla	
CLIENTE pero	 por	 error	 he	 borrado	 todos	 los	 datos	 de	 la	 tabla.	 ¿Puedo	
realizar	algo	para	recuperar	los	datos	que	borre?.	Justifícalo	y	en	caso	de ser	
posible	indica	cómo	actuarias.*/







/*Haría un "rollback", que básicamente es volver al estado en el que estaba mi base de datos en el
momento que hice COMMIT.*/







/*7.6 (1 puntos) ¿En	qué	consiste	el	SAVEPOINT?	Explícalo detalladamente e	indica	
a	 modo	 de	 ejemplo	 las	 instrucciones	 necesarias	 donde	 se	 vea	 que	 has	
utilizado	varios	INSERT y	SAVEPOINT	de	fo










