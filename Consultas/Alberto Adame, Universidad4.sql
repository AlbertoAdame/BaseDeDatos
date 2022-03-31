--1. Mostrar el identificador de los alumnos matriculados en cualquier asignatura excepto la '150212' y la '130113'.

SELECT aa.IDALUMNO 
FROM ALUMNO_ASIGNATURA aa 
WHERE aa.IDASIGNATURA !='150212'
AND aa.IDASIGNATURA != '130113';

--2. Mostrar el nombre de las asignaturas que tienen más créditos que "Seguridad Vial". 
SELECT a.NOMBRE 
FROM ASIGNATURA a 
WHERE a.CREDITOS > (SELECT a2.CREDITOS  
					FROM ASIGNATURA a2 
					WHERE UPPER(a2.NOMBRE) LIKE '%SEGURIDAD VIAL%');---faltan datos
--3. Obtener el Id de los alumnos matriculados en las asignaturas "150212" y "130113" a la vez. 
				
SELECT aa.IDALUMNO 
FROM ALUMNO_ASIGNATURA aa, ALUMNO_ASIGNATURA aa2  
WHERE aa.IDASIGNATURA = aa2.IDASIGNATURA  
AND (aa.IDASIGNATURA ='150212'
AND aa2.IDASIGNATURA = '130113');---faltan datos

--4. Mostrar el Id de los alumnos matriculados en las asignatura "150212" ó "130113", en una o en otra pero 
--no en ambas a la vez. 
SELECT DISTINCT aa.IDALUMNO 
FROM ALUMNO_ASIGNATURA aa 
WHERE (aa.IDASIGNATURA ='150212'
OR aa.IDASIGNATURA = '130113');-------
--5. Mostrar el nombre de las asignaturas de la titulación "130110" cuyos costes básicos sobrepasen el 
--coste básico promedio por asignatura en esa titulación.

SELECT a.NOMBRE 
FROM ASIGNATURA a
WHERE a.IDTITULACION = '130110' 
AND a.COSTEBASICO > (SELECT AVG(NVL(a2.COSTEBASICO,0))  
					  FROM ASIGNATURA a2 
					  WHERE a2.IDTITULACION = '130110');

--6. Mostrar el identificador de los alumnos matriculados en cualquier asignatura excepto la "150212" 
--y la "130113”

SELECT aa.IDALUMNO 
FROM ALUMNO_ASIGNATURA aa 
WHERE aa.IDASIGNATURA != '150212'
AND  aa.IDASIGNATURA != '130113';

--7. Mostrar el Id de los alumnos matriculados en la asignatura "150212" pero no en la "130113". 

SELECT aa.IDALUMNO 
FROM ALUMNO_ASIGNATURA aa 
WHERE aa.IDASIGNATURA = '150212'
AND  aa.IDASIGNATURA != '130113';

--8. Mostrar el nombre de las asignaturas que tienen más créditos que "Seguridad Vial". 

SELECT a.NOMBRE 
FROM ASIGNATURA a 
WHERE a.CREDITOS > (SELECT a2.CREDITOS  
					  FROM ASIGNATURA a2 
					  WHERE UPPER(a2.NOMBRE) LIKE 'SEGURIDAD VIAL');


--9. Mostrar las personas que no son ni profesores ni alumnos.

SELECT p.NOMBRE 
FROM PERSONA p
WHERE p.DNI NOT IN (SELECT DNI FROM PROFESOR)
AND p.DNI NOT IN (SELECT DNI FROM ALUMNO);


--10. Mostrar el nombre de las asignaturas que tengan más créditos. 

SELECT a.NOMBRE 
FROM ASIGNATURA a 
WHERE a.CREDITOS = (SELECT MAX(a2.CREDITOS)  
					FROM ASIGNATURA a2);

--11. Lista de asignaturas en las que no se ha matriculado nadie. 

SELECT a.NOMBRE 
FROM ASIGNATURA a, ALUMNO_ASIGNATURA aa 
WHERE a.IDASIGNATURA = aa.IDASIGNATURA(+) 
AND aa.IDASIGNATURA IS NULL;

--12. Ciudades en las que vive algún profesor y también algún alumno.

SELECT DISTINCT p.CIUDAD 
FROM PERSONA p 
WHERE p.CIUDAD  IN (SELECT p2.CIUDAD  
			  FROM ALUMNO a, PERSONA p2
			  WHERE a.DNI=p2.DNI)
AND p.CIUDAD IN (SELECT p3.CIUDAD  
			  FROM PROFESOR pR, PERSONA p3
			  WHERE pr.DNI=p3.DNI);


