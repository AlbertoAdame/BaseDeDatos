/*drop table alumno_asignatura;
drop table asignatura;
drop table alumno;
drop table profesor;
drop table persona;
drop table titulacion;*/

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


--1.Para cada titulación ordenar por coste mostrando primero las asignaturas más caras y para las asignaturas del mismo coste 
--mostrar por orden alfabético de nombre de asignatura. 

SELECT  t.nombre,a.costebasico
FROM TITULACION t, ASIGNATURA a 
WHERE t.idtitulacion= a.idtitulacion
ORDER BY costebasico DESC;

--2.	Mostrar el nombre y los apellidos de los profesores. 

SELECT pe.nombre, pe.apellido
FROM PERSONA pe, PROFESOR pr
WHERE pe.dni=pr.dni;


--3.	Mostrar el nombre de las asignaturas impartidas por profesores de Sevilla. 

SELECT pe.nombre, a.nombre
FROM ASIGNATURA a, PROFESOR pr,PERSONA pe
WHERE a.IDPROFESOR=pr.IDPROFESOR
AND pr.dni=pe.dni
AND pe.ciudad LIKE 'Sevilla'; --Preguntar como se pondría la ciudad en mayuscula, con UPPER NO funciona

--4.	Mostrar el nombre y los apellidos de los alumnos.

SELECT p.nombre, p.apellido
FROM ALUMNO a, PERSONA p 
WHERE p.dni=a.dni;


--5.	Mostrar el DNI, nombre y apellidos de los alumnos que viven en Sevilla. 

SELECT p.dni, p.dni, p.apellido
FROM ALUMNO a, PERSONA p 
WHERE  p.dni=a.dni
AND p.ciudad LIKE 'Sevilla';

--6.	Mostrar el DNI, nombre y apellidos de los alumnos matriculados en la asignatura "Seguridad Vial". 

SELECT p.dni, p.nombre, p.apellido
FROM  ALUMNO al, ASIGNATURA asg, PERSONA p, ALUMNO_ASIGNATURA aa 
WHERE aa.idasignatura = asg.idasignatura
AND aa.idalumno = al.idalumno
AND al.dni=p.dni
AND asg.nombre LIKE 'Seguridad Vial';

--7.	Mostrar el Id de las titulaciones en las que está matriculado el alumno con DNI 20202020A. 
--Un alumno está matriculado en una titulación si está matriculado en una asignatura de la titulación.

SELECT t.idtitulacion, al.dni
FROM ALUMNO al, ALUMNO_ASIGNATURA aa, ASIGNATURA asg, TITULACION t 
WHERE al.dni LIKE '20202020A'
AND al.IDALUMNO = aa.IDALUMNO 
AND aa.IDASIGNATURA = asg.IDASIGNATURA 
AND asg.idtitulacion = t.IDTITULACION
AND aa.NUMEROMATRICULA > 0;

--8.	Obtener el nombre de las asignaturas en las que está matriculada Rosa Garcia.

SELECT asg.nombre
FROM ASIGNATURA asg, ALUMNO_ASIGNATURA aa, ALUMNO al, PERSONA p 
WHERE p.nombre LIKE 'Rosa'
AND p.apellido LIKE 'Garcia'
AND p.dni=al.dni
AND aa.IDALUMNO =al.IDALUMNO 
AND aa.IDASIGNATURA = asg.IDASIGNATURA 

--9.	Obtener el DNI de los alumnos a los que le imparte clase el profesor Jorge Saenz. 

SELECT al.DNI 
FROM PROFESOR pr, PERSONA pe, ALUMNO al, ALUMNO_ASIGNATURA aa, ASIGNATURA asg 
WHERE pe.nombre LIKE 'Jorge'
AND pe.apellido LIKE 'Saenz'
AND pr.DNI =pe.DNI
AND asg.IDPROFESOR = pr.IDPROFESOR
AND aa.IDASIGNATURA = asg.IDASIGNATURA
AND al.IDALUMNO =aa.IDALUMNO;





--10.	Obtener el DNI, nombre y apellido de los alumnos a los que imparte clase el profesor Jorge Sáenz. 

SELECT pe.DNI, pe.nombre, pe.apellido
FROM PROFESOR pr, PERSONA pe, ALUMNO al, ALUMNO_ASIGNATURA aa, ASIGNATURA asg 
WHERE pe.nombre LIKE 'Jorge'
AND pe.apellido LIKE 'Saenz'
AND pe.DNI = pr.DNI 
AND pr.IDPROFESOR = asg.IDPROFESOR 
AND aa.IDASIGNATURA = asg.IDASIGNATURA
AND al.IDALUMNO =aa.IDALUMNO
AND pe.DNI=al.DNI;




--11.	Mostrar el nombre de las titulaciones que tengan al menos una asignatura de 4 créditos. 

SELECT t.nombre
FROM TITULACION t, ASIGNATURA a 
WHERE t.IDTITULACION = a.IDTITULACION 
AND a.CREDITOS >= 4;

--12.	Mostrar el nombre y los créditos de las asignaturas del primer cuatrimestre junto con el nombre de la 
--titulación a la que pertenecen. 

SELECT a.NOMBRE , a.CREDITOS, t.NOMBRE 
FROM ASIGNATURA a, TITULACION t 
WHERE t.IDTITULACION =a.IDTITULACION 
AND a.CUATRIMESTRE = 1;

--13.Mostrar el nombre y el coste básico de las asignaturas de más de 4,5 créditos junto con el 
--nombre de las personas matriculadas

SELECT asg.NOMBRE, asg.COSTEBASICO, pe.NOMBRE 
FROM  ASIGNATURA asg, PERSONA pe, ALUMNO_ASIGNATURA aa, ALUMNO al 
WHERE asg.CREDITOS > 4.5
AND asg.IDASIGNATURA =aa.IDASIGNATURA 
AND aa.IDALUMNO = al.IDALUMNO 
AND al.DNI = pe.DNI; 

--14.	Mostrar el nombre de los profesores que imparten asignaturas con coste entre 25 y 35 euros, ambos incluidos

SELECT pe.NOMBRE
FROM PERSONA pe, PROFESOR pr, ASIGNATURA asg 
WHERE asg.COSTEBASICO BETWEEN 25 AND 35
AND asg.IDPROFESOR = pr.IDPROFESOR 
AND pr.DNI = pe.DNI;

--15.	Mostrar el nombre de los alumnos matriculados en la asignatura '150212' ó en la '130113' ó en ambas.

SELECT pe.NOMBRE, aa.IDASIGNATURA 
FROM PERSONA pe, ALUMNO al, ALUMNO_ASIGNATURA aa 
WHERE (aa.IDASIGNATURA = '150212'
AND aa.IDALUMNO =al.IDALUMNO 
AND al.DNI = pe.DNI)
OR (aa.IDASIGNATURA = '130113'
AND aa.IDALUMNO =al.IDALUMNO 
AND al.DNI = pe.DNI); 

--16.	Mostrar el nombre de las asignaturas del 2º cuatrimestre que no sean de 6 créditos, 
--junto con el nombre de la titulación a la que pertenece.

SELECT asg.NOMBRE, t.NOMBRE 
FROM ASIGNATURA asg, TITULACION t 
WHERE asg.CUATRIMESTRE = 2
AND asg.CREDITOS != 6
AND asg.IDTITULACION = t.IDTITULACION ;

--17.Mostrar el nombre y el número de horas de todas las asignaturas. (1cred.=10 horas) 
--junto con el dni de los alumnos que están matriculados.

SELECT al.DNI ,asg.NOMBRE, asg.CREDITOS*10 AS NumeroHoras
FROM ASIGNATURA asg, ALUMNO_ASIGNATURA aa, ALUMNO al 
WHERE asg.IDASIGNATURA = aa.IDASIGNATURA 
AND aa.IDALUMNO = al.IDALUMNO;

--18.Mostrar el nombre de todas las mujeres que viven en “Sevilla” y que estén matriculados de alguna asignatura

SELECT pe.NOMBRE 
FROM PERSONA pe, ALUMNO al, ALUMNO_ASIGNATURA aa 
WHERE pe.VARON = 0
AND pe.CIUDAD LIKE 'Sevilla'
AND pe.DNI =al.DNI 
AND al.IDALUMNO = aa.IDALUMNO
AND aa.NUMEROMATRICULA > 0; 

--19.	Mostrar el nombre de la asignatura de primero y que lo imparta el profesor con identificador p101.

SELECT asg.NOMBRE 
FROM ASIGNATURA asg, PROFESOR pr 
WHERE asg.CURSO = 1
AND asg.IDPROFESOR = pr.IDPROFESOR 
AND pr.IDPROFESOR = 'P101';

--20.	Mostrar el nombre de los alumnos que se ha matriculado tres o más veces en alguna asignatura.

SELECT pe.NOMBRE 
FROM PERSONA pe, ALUMNO al, ALUMNO_ASIGNATURA aa 
WHERE aa.NUMEROMATRICULA >= 3
AND aa.IDALUMNO = al.IDALUMNO 
AND al.DNI = pe.DNI;





