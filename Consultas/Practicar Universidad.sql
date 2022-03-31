drop table alumno_asignatura;
drop table asignatura;
drop table alumno;
drop table profesor;
drop table persona;
drop table titulacion;

Create table titulacion (
Idtitulacion varchar2(6) primary key,
Nombre varchar2(30)
);


Create table persona (
dni varchar2(11) primary key,
Nombre varchar2(30),
Apellido varchar2(30),
Ciudad varchar2(15),
Direccioncalle varchar2(30),
Direccionnum number,
Telefono varchar2(9),
Fecha_nacimiento date,
Varon number
);



create table alumno (
idalumno varchar2(7) primary key,
dni varchar2(11),
foreign key (dni) references persona(dni)
);

Create table profesor (
Idprofesor varchar2(4) primary key,
Dni varchar2(11),
Foreign key(dni) references persona(dni)
);

Create table asignatura (
Idasignatura varchar2(6) primary key,
Nombre varchar2(20),
Creditos number,
Cuatrimestre number,
Costebasico number,
Idprofesor varchar2(4),
Idtitulacion varchar2(6),
Curso number,
Foreign key(idprofesor) references profesor(idprofesor),
Foreign key (idtitulacion) references titulacion(idtitulacion)
);

Create table  alumno_asignatura (
Idalumno varchar2(7),
Idasignatura varchar2(6),
Numeromatricula number,
  PRIMARY KEY(idalumno,idasignatura,numeromatricula),
Foreign key(idalumno) references alumno(idalumno),
Foreign key(idasignatura) references asignatura(idasignatura)
);


insert into persona values ('16161616A','Luis','Ramirez','Haro','Pez','34','941111111',to_date('1/1/1969','dd/mm/yyyy'),'1');
insert into persona values ('17171717A','Laura','Beltran','Madrid','Gran Va','23','912121212',to_date('8/8/1974','dd/mm/yyyy'),'0');
insert into persona values ('18181818A','Pepe','Perez','Madrid','Percebe','13','913131313',to_date('2/2/1980','dd/mm/yyyy'),'1');
insert into persona values ('19191919A','Juan','Sanchez','Bilbao','Melancola','7','944141414',to_date('3/2/1966','dd/mm/yyyy'),'1');
insert into persona values ('20202020A','Luis','Jimenez','Najera','Cigea','15','941151515',to_date('3/3/1979','dd/mm/yyyy'),'1');
insert into persona values ('21212121A','Rosa','Garcia','Haro','Alegra','16','941161616',to_date('4/4/1978','dd/mm/yyyy'),'0');
insert into persona values ('23232323A','Jorge','Saenz','Sevilla','Luis Ulloa','17','941171717',to_date('9/9/1978','dd/mm/yyyy'),'1');
insert into persona values ('24242424A','Mara','Gutierrez','Sevilla','Avda. de la Paz','18','941181818',to_date('10/10/1964','dd/mm/yyyy'),'0');
insert into persona values ('25252525A','Rosario','Diaz','Sevilla','Percebe','19','941191919',to_date('11/11/1971','dd/mm/yyyy'),'0');
insert into persona values ('26262626A','Elena','Gonzalez','Sevilla','Percebe','20','941202020',to_date('5/5/1975','dd/mm/yyyy'),'0');


insert into alumno values ('A010101','21212121A');
insert into alumno values ('A020202','18181818A');
insert into alumno values ('A030303','20202020A');
insert into alumno values ('A040404','26262626A');
insert into alumno values ('A121212','16161616A');
insert into alumno values ('A131313','17171717A');


insert into profesor values ('P101','19191919A');
insert into profesor values ('P117','25252525A');
insert into profesor values ('P203','23232323A');
insert into profesor values ('P204','26262626A');
insert into profesor values ('P304','24242424A');


insert into titulacion values ('130110','Matematicas');
insert into titulacion values ('150210','Quimicas');
insert into titulacion values ('160000','Empresariales');


insert into asignatura values ('000115','Seguridad Vial','4','1','30 ','P204',null,null);
insert into asignatura values ('130113','Programacion I', '9','1','60 ','P101','130110','1');
insert into asignatura values ('130122','Analisis II',    '9','2','60 ','P203','130110','2');
insert into asignatura values ('150212','Quimica Fisica','4','2','70','P304','150210','1');
insert into asignatura values ('160002','Contabilidad','6','1','70','P117','160000','1');


insert into alumno_asignatura values('A010101','150212','1');
insert into alumno_asignatura values('A020202','130113','1');
insert into alumno_asignatura values('A020202','150212','2');
insert into alumno_asignatura values('A030303','130113','3');
insert into alumno_asignatura values('A030303','150212','1');
insert into alumno_asignatura values('A030303','130122','2');
insert into alumno_asignatura values('A040404','130122','1');
insert into alumno_asignatura values('A121212','000115','1');
insert into alumno_asignatura values('A131313','160002','4');



--1.	Mostrar los nombres y los créditos de cada una de las asignaturas.
SELECT NOMBRE, CREDITOS 
FROM ASIGNATURA a;
--2.	Obtener los posibles distintos créditos de las asignaturas que hay en la base de datos.

SELECT DISTINCT CREDITOS, NOMBRE 
FROM ASIGNATURA a; 
--3.	Mostrar todos los datos de todas de las personas
SELECT *
FROM PERSONA p;
--4.	Mostrar el nombre y créditos de las asignaturas del primer cuatrimestre.
SELECT NOMBRE, CREDITOS 
FROM ASIGNATURA a 
WHERE CUATRIMESTRE = 1;


--5.	Mostrar el nombre y el apellido de las personas nacidas antes del 1 de enero de 1975.
SELECT NOMBRE, APELLIDO 
FROM PERSONA p 
WHERE EXTRACT(YEAR FROM p.FECHA_NACIMIENTO)<1975;
--6.	Mostrar el nombre y el coste básico de las asignaturas de más de 4,5 créditos.
SELECT NOMBRE, COSTEBASICO 
FROM ASIGNATURA a 
WHERE CREDITOS > 4.5;
--7.	Mostrar el nombre de las asignaturas cuyo coste básico está entre 25 y 35 euros.
SELECT NOMBRE 
FROM ASIGNATURA a 
WHERE COSTEBASICO 
BETWEEN 25 AND 35;
--8.	Mostrar el identificador de los alumnos matriculados en la asignatura '150212' o en la '130113' o en ambas.
SELECT DISTINCT IDALUMNO 
FROM ALUMNO_ASIGNATURA a 
WHERE IDASIGNATURA = 150212
OR IDASIGNATURA = 130113
OR (IDASIGNATURA = 130113 
AND IDASIGNATURA = 150212);


--9.	Obtener el nombre de las asignaturas del 2º cuatrimestre que no sean de 6 créditos.
SELECT NOMBRE 
FROM ASIGNATURA a 
WHERE CUATRIMESTRE =2
AND CREDITOS != 6;


--10.	Mostrar el nombre y el apellido de las personas cuyo apellido comience por 'G'.
SELECT NOMBRE, APELLIDO 
FROM PERSONA p 
WHERE APELLIDO LIKE 'G%';

--11.	Obtener el nombre de las asignaturas que no tienen dato para el IdTitulacion. 
SELECT NOMBRE 
FROM ASIGNATURA a 
WHERE IDTITULACION IS NULL;
--12.	Obtener el nombre de las asignaturas que tienen dato para el IdTitulacion.
SELECT NOMBRE 
FROM ASIGNATURA a 
WHERE IDTITULACION IS NOT NULL;
--13.	Mostrar el nombre de las asignaturas cuyo coste por cada crédito sea mayor de 8 euros. 
SELECT NOMBRE 
FROM ASIGNATURA a 
WHERE COSTEBASICO/CREDITOS > 8;
--14.	Mostrar el nombre y el número de horas de las asignaturas de la base de datos. (1cred.=10 horas).
SELECT NOMBRE , CREDITOS * 10 AS NumHoras
FROM ASIGNATURA a;
--15.	Mostrar todos los datos de las asignaturas del 2º cuatrimestre ordenados por el identificador de asignatura.
SELECT *
FROM ASIGNATURA a 
WHERE CUATRIMESTRE =2
ORDER BY IDASIGNATURA;
--16.	Mostrar el nombre de todas las mujeres que viven en “Madrid”.
SELECT NOMBRE 
FROM PERSONA p 
WHERE UPPER(CIUDAD) LIKE 'MADRID'
AND VARON = 0;
--17.	Mostrar el nombre y los teléfonos de aquellas personas cuyo teléfono empieza por 91
SELECT NOMBRE , TELEFONO 
FROM PERSONA p 
WHERE TELEFONO LIKE '91%';
--18.	Mostrar el nombre de las asignaturas que contengan la sílaba “pro”
SELECT NOMBRE 
FROM ASIGNATURA a 
WHERE UPPER(NOMBRE) LIKE '%PRO%';

--19.	Mostrar el nombre de la asignatura de primero y que lo imparta el profesor que tiene código P101
SELECT NOMBRE 
FROM ASIGNATURA a 
WHERE CURSO = 1
AND IDPROFESOR = 'P101';
--20.	Mostrar el código de alumno que se ha matriculado tres o más veces de una asignatura, mostrando también el 
--código de la asignatura correspondiente.
SELECT IDALUMNO, IDASIGNATURA 
FROM ALUMNO_ASIGNATURA aa 
WHERE NUMEROMATRICULA >= 3;



--21.	El coste de cada asignatura va subiendo a medida que se repite la asignatura. Para saber cuál sería el precio 
--de las distintas asignaturas en las repeticiones (y así animar a nuestros alumnos a que estudien) se quiere mostrar
-- un listado en donde esté el nombre de la asignatura, el precio básico, el precio de la primera repetición
-- (un 10 por ciento más que el coste básico),  el precio de la segunda repetición (un 30 por ciento más que el 
--coste básico) y el precio de la tercer repetición (un 60 por ciento más que el coste básico).
SELECT NOMBRE , COSTEBASICO , (COSTEBASICO * 0.1)+ COSTEBASICO AS PRIMERAREPETICION,  (COSTEBASICO * 0.6)+ COSTEBASICO AS TERCERAREPETICION
FROM ASIGNATURA a;
--22.	Mostrar todos los datos de las personas que tenemos en la base de datos que han nacido antes de la década de 
--los 70.
SELECT *
FROM PERSONA p 
WHERE EXTRACT (YEAR FROM p.FECHA_NACIMIENTO)
BETWEEN 1970 AND 1979;
--23.	Mostrar el identificador de las personas que trabajan como profesor, sin que salgan valores repetidos.
SELECT DISTINCT IDPROFESOR 
FROM PROFESOR p;

--24.	Mostrar el identificador de los alumnos que se encuentran matriculados en la asignatura con código 130122.
SELECT IDALUMNO 
FROM ALUMNO_ASIGNATURA aa 
WHERE IDASIGNATURA = 130122;

--25.	Mostrar los códigos de las asignaturas en las que se encuentra matriculado algún alumno, sin que salgan 
--códigos repetidos.
SELECT DISTINCT IDASIGNATURA 
FROM ALUMNO_ASIGNATURA aa 
WHERE IDALUMNO IS NOT NULL;

--26.	Mostrar el nombre de las asignaturas que tienen más de 4 créditos, y además, o se imparten en el primer
-- cuatrimestre o son del primer curso.
SELECT NOMBRE 
FROM ASIGNATURA a 
WHERE CREDITOS > 4
AND (CUATRIMESTRE = 1
OR CURSO =1);
--27.	Mostrar los distintos códigos de las titulaciones en las que hay alguna asignatura en nuestra base de datos.
SELECT IDTITULACION 
FROM TITULACION t;

--28.	Mostrar el dni de las personas cuyo apellido contiene la letra g en mayúsculas o minúsculas.
SELECT DNI 
FROM PERSONA p 
WHERE UPPER(APELLIDO) LIKE '%G%';
--29.	Mostrar las personas varones que tenemos en la base de datos que han nacido con posterioridad a 1970 y 
--que vivan en una ciudad que empieza por M.
SELECT *
FROM PERSONA p 
WHERE EXTRACT(YEAR FROM p.FECHA_NACIMIENTO)>1970
AND UPPER(CIUDAD) LIKE 'M%'
AND VARON =1;



--1.	Para cada titulación ordenar por coste mostrando primero las asignaturas más caras y para las asignaturas 
--del mismo coste mostrar por orden alfabético de nombre de asignatura. 
SELECT a.NOMBRE, a.COSTEBASICO 
FROM TITULACION t, ASIGNATURA a 
WHERE t.IDTITULACION = a.IDTITULACION 
ORDER BY a.COSTEBASICO DESC, a.NOMBRE;
--2.	Mostrar el nombre y los apellidos de los profesores. 
SELECT DISTINCT pe.NOMBRE, pe.APELLIDO 
FROM PROFESOR pr, PERSONA pe
WHERE pr.DNI = pe.DNI;
--3.	Mostrar el nombre de las asignaturas impartidas por profesores de Sevilla. 
SELECT asg.NOMBRE 
FROM PERSONA pe, PROFESOR pr, ASIGNATURA asg 
WHERE pe.DNI = pr.DNI 
AND pr.IDPROFESOR = asg.IDPROFESOR 
AND UPPER(pe.CIUDAD)LIKE 'SEVILLA';

--4.	Mostrar el nombre y los apellidos de los alumnos.
SELECT pe.NOMBRE , pe.APELLIDO 
FROM PERSONA pe, ALUMNO a 
WHERE pe.DNI = a.DNI;
--5.	Mostrar el DNI, nombre y apellidos de los alumnos que viven en Sevilla. 
SELECT DISTINCT p.DNI , p.NOMBRE , p.APELLIDO 
FROM PERSONA p, ALUMNO a 
WHERE p.DNI = a.DNI
AND UPPER(p.CIUDAD) LIKE 'SEVILLA';

--6.	Mostrar el DNI, nombre y apellidos de los alumnos matriculados en la asignatura "Seguridad Vial". 
SELECT p.DNI, p.NOMBRE , p.APELLIDO 
FROM PERSONA p, ALUMNO a, ALUMNO_ASIGNATURA aa, ASIGNATURA asg
WHERE p.DNI = a.DNI 
AND a.IDALUMNO = aa.IDALUMNO
AND aa.IDASIGNATURA = asg.IDASIGNATURA 
AND UPPER(asg.NOMBRE) LIKE 'SEGURIDAD VIAL';

--7.	Mostrar el Id de las titulaciones en las que está matriculado el alumno con DNI 20202020A. 
--Un alumno está matriculado en una titulación si está matriculado en una asignatura de la titulación.
SELECT DISTINCT t.IDTITULACION
FROM TITULACION t, ASIGNATURA a, ALUMNO_ASIGNATURA aa, ALUMNO al
WHERE t.IDTITULACION = a.IDTITULACION 
AND a.IDASIGNATURA = aa.IDASIGNATURA 
AND aa.IDALUMNO = al.IDALUMNO 
AND al.DNI = '20202020A';


--8.	Obtener el nombre de las asignaturas en las que está matriculada Rosa Garcia.
SELECT a.NOMBRE 
FROM ASIGNATURA a, ALUMNO_ASIGNATURA aa, ALUMNO al, PERSONA p 
WHERE a.IDASIGNATURA = aa.IDASIGNATURA 
AND aa.IDALUMNO = al.IDALUMNO 
AND al.DNI = p.DNI 
AND UPPER(p.NOMBRE) LIKE 'ROSA'
AND (UPPER(p.APELLIDO) LIKE 'GARCIA'
OR UPPER(p.APELLIDO) LIKE 'GARCÍA');

--9.	Obtener el DNI de los alumnos a los que le imparte clase el profesor Jorge Saenz. 
SELECT pa.DNI 
FROM PERSONA pa, ALUMNO a, ALUMNO_ASIGNATURA aa, ASIGNATURA asg, PROFESOR pr, PERSONA pp
WHERE pa.DNI =a.DNI 
AND a.IDALUMNO = aa.IDALUMNO 
AND aa.IDASIGNATURA = asg.IDASIGNATURA 
AND asg.IDPROFESOR = pr.IDPROFESOR 
AND pr.DNI = pp.DNI 
AND UPPER(pp.NOMBRE) LIKE 'JORGE'
AND UPPER(pp.APELLIDO) LIKE 'SAENZ';

SELECT al.DNI 
FROM PROFESOR pr, PERSONA pe, ALUMNO al, ALUMNO_ASIGNATURA aa, ASIGNATURA asg 
WHERE pe.nombre LIKE 'Jorge'
AND pe.apellido LIKE 'Saenz'
AND pr.DNI =pe.DNI
AND asg.IDPROFESOR = pr.IDPROFESOR
AND aa.IDASIGNATURA = asg.IDASIGNATURA
AND al.IDALUMNO =aa.IDALUMNO;
--10.	Obtener el DNI, nombre y apellido de los alumnos a los que imparte clase el profesor Jorge Sáenz. 
SELECT pa.DNI, pa.NOMBRE, pa.APELLIDO 
FROM PERSONA pa, ALUMNO a, ALUMNO_ASIGNATURA aa, ASIGNATURA asg, PROFESOR pr, PERSONA pp
WHERE pa.DNI =a.DNI 
AND a.IDALUMNO = aa.IDALUMNO 
AND aa.IDASIGNATURA = asg.IDASIGNATURA 
AND asg.IDPROFESOR = pr.IDPROFESOR 
AND pr.DNI = pp.DNI 
AND UPPER(pp.NOMBRE) LIKE 'JORGE'
AND UPPER(pp.APELLIDO) LIKE 'SAENZ';
--11.	Mostrar el nombre de las titulaciones que tengan al menos una asignatura de 4 créditos. 
SELECT DISTINCT t.NOMBRE
FROM TITULACION t, ASIGNATURA a 
WHERE a.CREDITOS >=4;

--12.	Mostrar el nombre y los créditos de las asignaturas del primer cuatrimestre junto con el nombre de la 
--titulación a la que pertenecen. 
SELECT a.NOMBRE, a.CREDITOS, t.NOMBRE 
FROM ASIGNATURA a, TITULACION t 
WHERE a.IDTITULACION = t.IDTITULACION 
AND a.CUATRIMESTRE =1;


--13.	Mostrar el nombre y el coste básico de las asignaturas de más de 4,5 créditos junto con el 
--nombre de las personas matriculadas
SELECT DISTINCT a.NOMBRE, a.COSTEBASICO, p.NOMBRE 
FROM ASIGNATURA a, ALUMNO_ASIGNATURA aa, ALUMNO al, PERSONA p 
WHERE a.IDASIGNATURA = aa.IDASIGNATURA 
AND aa.IDALUMNO = al.IDALUMNO 
AND al.DNI = p.DNI 
AND a.CREDITOS > 4.5;

--14.	Mostrar el nombre de los profesores que imparten asignaturas con coste entre 25 y 35 euros, ambos incluidos
SELECT p.NOMBRE 
FROM PERSONA p, PROFESOR pr, ASIGNATURA a 
WHERE p.DNI = pr.DNI 
AND pr.IDPROFESOR = a.IDPROFESOR
AND a.COSTEBASICO 
BETWEEN 25 AND 35;


--15.	Mostrar el nombre de los alumnos matriculados en la asignatura '150212' ó en la '130113' ó en ambas.

SELECT DISTINCT p.NOMBRE 
FROM PERSONA p, ALUMNO a, ALUMNO_ASIGNATURA aa 
WHERE p.DNI = a.DNI 
AND a.IDALUMNO = aa.IDALUMNO 
AND (aa.IDASIGNATURA = 150212
OR aa.IDASIGNATURA = 130113)
OR (aa.IDASIGNATURA = 150212
AND aa.IDASIGNATURA = 130113);


--16.	Mostrar el nombre de las asignaturas del 2º cuatrimestre que no sean de 6 créditos, junto con el 
--nombre de la titulación a la que pertenece.
SELECT a.NOMBRE, t.NOMBRE 
FROM ASIGNATURA a, TITULACION t 
WHERE a.IDTITULACION = t.IDTITULACION 
AND a.CUATRIMESTRE =2
AND a.CREDITOS != 6;

--17.	Mostrar el nombre y el número de horas de todas las asignaturas. (1cred.=10 horas) junto 
--con el dni de los alumnos que están matriculados.
SELECT DISTINCT a.NOMBRE, a.CREDITOS *10 AS HORAS, p.DNI 
FROM ASIGNATURA a, ALUMNO_ASIGNATURA aa, ALUMNO al, PERSONA p 
WHERE a.IDASIGNATURA = aa.IDASIGNATURA 
AND aa.IDALUMNO = al.IDALUMNO
AND al.DNI = p.DNI; 


--18.	Mostrar el nombre de todas las mujeres que viven en “Sevilla” y que estén matriculados de alguna asignatura
SELECT p.NOMBRE 
FROM PERSONA p, ALUMNO al, ALUMNO_ASIGNATURA aa  
WHERE p.DNI = al.DNI 
AND al.IDALUMNO = aa.IDALUMNO 
AND UPPER(p.CIUDAD) LIKE 'SEVILLA'
AND p.VARON = 0;


--19.	Mostrar el nombre de la asignatura de primero y que lo imparta el profesor con identificador p101.
SELECT a.NOMBRE 
FROM ASIGNATURA a, PROFESOR p 
WHERE a.IDPROFESOR = p.IDPROFESOR 
AND p.IDPROFESOR = 'P101'
AND a.CURSO = 1;

--20.	Mostrar el nombre de los alumnos que se ha matriculado tres o más veces en alguna asignatura.
SELECT p.NOMBRE 
FROM PERSONA p, ALUMNO a, ALUMNO_ASIGNATURA aa 
WHERE p.DNI = a.DNI 
AND a.IDALUMNO = aa.IDALUMNO 
AND aa.NUMEROMATRICULA >=3;





--1.	Cuantos costes básicos hay.
SELECT COUNT(COSTEBASICO)
FROM ASIGNATURA a; 

--2.	Para cada titulación mostrar el número de asignaturas que hay junto con el nombre de la titulación.

SELECT COUNT(a.IDASIGNATURA), t.NOMBRE 
FROM TITULACION t, ASIGNATURA a 
WHERE t.IDTITULACION = a.IDTITULACION 
GROUP BY t.NOMBRE;


--3.	Para cada titulación mostrar el nombre de la titulación junto con el precio total de todas sus asignaturas.
SELECT t.NOMBRE, SUM(a.COSTEBASICO)
FROM TITULACION t, ASIGNATURA a 
WHERE t.IDTITULACION = a.IDTITULACION
GROUP BY t.NOMBRE;


--4.	Cual sería el coste global de cursar la titulación de Matemáticas si el coste de cada asignatura 
--fuera incrementado en un 7%. 
SELECT  SUM(a.COSTEBASICO*1.07) 
FROM TITULACION t, ASIGNATURA a 
WHERE t.IDTITULACION = a.IDTITULACION 
AND UPPER(t.NOMBRE) LIKE 'MATEMATICAS';


--5.	Cuantos alumnos hay matriculados en cada asignatura, junto al id de la asignatura. 
SELECT COUNT(IDALUMNO), IDASIGNATURA
FROM ALUMNO_ASIGNATURA aa 
GROUP BY IDASIGNATURA;

--6.	Igual que el anterior pero mostrando el nombre de la asignatura.
SELECT COUNT(aa.IDALUMNO), aa.IDASIGNATURA, a.NOMBRE 
FROM ALUMNO_ASIGNATURA aa, ASIGNATURA a 
WHERE aa.IDASIGNATURA = a.IDASIGNATURA 
GROUP BY aa.IDASIGNATURA, a.NOMBRE ;



--7.	Mostrar para cada alumno, el nombre del alumno junto con lo que tendría que pagar por el total de 
--todas las asignaturas en las que está matriculada. Recuerda que el precio de la matrícula tiene un incremento 
--de un 10% por cada año en el que esté matriculado. 
SELECT p.NOMBRE, SUM(a.COSTEBASICO* POWER(1.1, aa.NUMEROMATRICULA-1)) AS PRECIOTOTAL 
FROM PERSONA p, ALUMNO al, ALUMNO_ASIGNATURA aa, ASIGNATURA a 
WHERE p.DNI = al.DNI 
AND al.IDALUMNO = aa.IDALUMNO 
AND aa.IDASIGNATURA = a.IDASIGNATURA
GROUP BY p.NOMBRE ; 

--8.	Coste medio de las asignaturas de cada titulación, para aquellas titulaciones en el que el coste total 
--de la 1ª matrícula sea mayor que 60 euros. 
SELECT AVG(a.COSTEBASICO), t.NOMBRE 
FROM  ALUMNO_ASIGNATURA aa ,ASIGNATURA a, TITULACION t
WHERE aa.IDASIGNATURA = a.IDASIGNATURA 
AND a.IDTITULACION = t.IDTITULACION 
AND aa.NUMEROMATRICULA = 1
GROUP BY t.NOMBRE 
HAVING SUM(a.COSTEBASICO)>60;
--9.	Nombre de las titulaciones  que tengan más de tres alumnos.
SELECT t.NOMBRE 
FROM TITULACION t, ASIGNATURA a, ALUMNO_ASIGNATURA aa 
WHERE t.IDTITULACION = a.IDTITULACION 
AND a.IDASIGNATURA = aa.IDASIGNATURA 
GROUP BY t.NOMBRE 
HAVING COUNT(aa.IDALUMNO)>3;
--10.	Nombre de cada ciudad junto con el número de personas que viven en ella.
SELECT p.CIUDAD, COUNT(DNI)
FROM PERSONA p
GROUP BY p.CIUDAD;
--11.	Nombre de cada profesor junto con el número de asignaturas que imparte.
SELECT p.NOMBRE, COUNT(a.IDASIGNATURA)
FROM PERSONA p, PROFESOR pr, ASIGNATURA a 
WHERE p.DNI = pr.DNI 
AND pr.IDPROFESOR = a.IDPROFESOR 
GROUP BY p.NOMBRE; 
--12.	Nombre de cada profesor junto con el número de alumnos que tiene, para aquellos profesores que tengan 
--dos o más de 2 alumnos.
SELECT p.NOMBRE, COUNT(aa.IDALUMNO)
FROM PERSONA p, PROFESOR pr, ASIGNATURA a, ALUMNO_ASIGNATURA aa 
WHERE p.DNI = pr.DNI 
AND pr.IDPROFESOR = a.IDPROFESOR 
AND a.IDASIGNATURA = aa.IDASIGNATURA
GROUP BY p.NOMBRE 
HAVING COUNT(aa.IDALUMNO)>=2;


--13.	Obtener el máximo de las sumas de los costesbásicos de cada cuatrimestre
SELECT MAX(SUM(a.COSTEBASICO)), a.CUATRIMESTRE 
FROM ASIGNATURA a 
GROUP BY a.CUATRIMESTRE;

--14.	Suma del coste de las asignaturas
SELECT SUM(COSTEBASICO) 
FROM ASIGNATURA a; 
--15.	¿Cuántas asignaturas hay?
SELECT COUNT(IDASIGNATURA)
FROM ASIGNATURA a;
--16.	Coste de la asignatura más cara y de la más barata
SELECT MAX(COSTEBASICO), MIN(COSTEBASICO)
FROM ASIGNATURA a;
--17.	¿Cuántas posibilidades de créditos de asignatura hay?
SELECT COUNT(DISTINCT CREDITOS)
FROM ASIGNATURA a; 

SELECT CREDITOS FROM ASIGNATURA a ;
--18.	¿Cuántos cursos hay?
SELECT count(CURSO)
FROM ASIGNATURA a;

select curso FROM ASIGNATURA a;

--19.	¿Cuántas ciudades hau?
SELECT COUNT(DISTINCT CIUDAD)
FROM PERSONA p;

SELECT CIUDAD FROM PERSONA;
--20.	Nombre y número de horas de todas las asignaturas.
SELECT a.NOMBRE, a.CREDITOS *10
FROM ASIGNATURA a ;

--21.	Mostrar las asignaturas que no pertenecen a ninguna titulación.
SELECT *
FROM ASIGNATURA a 
WHERE IDTITULACION IS NULL;


--22.	Listado del nombre completo de las personas, sus teléfonos y sus direcciones, 
--llamando a la columna del nombre "NombreCompleto" y a la de direcciones "Direccion".

SELECT NOMBRE || ' ' || APELLIDO AS NOMBRECOMPLETO,  TELEFONO, DIRECCIONCALLE ||' nº '|| DIRECCIONNUM AS direccion
FROM PERSONA p; 

--23.	Cual es el día siguiente al día en que nacieron las personas de la B.D.
SELECT FECHA_NACIMIENTO +1
FROM PERSONA p;

--24.	Años de las personas de la Base de Datos, esta consulta tiene que valor para cualquier momento
SELECT  EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM p.FECHA_NACIMIENTO) AS edad, p.nombre
FROM PERSONA p;

--25.	Listado de personas mayores de 25 años ordenadas por apellidos y nombre, 
--esta consulta tiene que valor para cualquier momento
SELECT  TRUNC((SYSDATE -p.FECHA_NACIMIENTO)/365) AS edad, p.nombre
FROM PERSONA p
WHERE TRUNC((SYSDATE -p.FECHA_NACIMIENTO)/365)>25
ORDER BY p.APELLIDO, p.NOMBRE ;
--26.	Nombres completos de los profesores que además son alumnos
SELECT p1.NOMBRE || ' ' || p1.APELLIDO AS nombreCOMPLETO 
FROM PERSONA p1, PROFESOR pr, PERSONA p2, ALUMNO a 
WHERE pr.DNI = p1.DNI 
AND p1.DNI = p2.DNI 
AND p2.DNI = a.DNI;


--27.	Suma de los créditos de las asignaturas de la titulación de Matemáticas
SELECT SUM(CREDITOS)
FROM ASIGNATURA a, TITULACION t 
WHERE a.IDTITULACION = t.IDTITULACION 
AND UPPER(t.NOMBRE) LIKE 'MATEMATICAS';


--28.	Número de asignaturas de la titulación de Matemáticas
SELECT COUNT(IDASIGNATURA)
FROM ASIGNATURA a, TITULACION t 
WHERE a.IDTITULACION = t.IDTITULACION 
AND UPPER(t.NOMBRE) LIKE 'MATEMATICAS';


--29.	¿Cuánto paga cada alumno por su matrícula?
SELECT SUM(a.COSTEBASICO), aa.IDALUMNO 
FROM ALUMNO_ASIGNATURA aa, ASIGNATURA a ;


--30.	¿Cuántos alumnos hay matriculados en cada asignatura?
SELECT COUNT(aa.IDALUMNO), a.NOMBRE 
FROM ALUMNO_ASIGNATURA aa, ASIGNATURA a 
WHERE aa.IDASIGNATURA = a.IDASIGNATURA 
GROUP BY  a.NOMBRE ;






