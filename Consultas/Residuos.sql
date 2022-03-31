--1. Muestra el nombre de las empresas productoras de Huelva o Málaga ordenadas por el
--nombre en orden alfabético inverso.

SELECT e.NOMBRE_EMPRESA, e.CIUDAD_EMPRESA 
FROM EMPRESAPRODUCTORA e 
WHERE UPPER(e.CIUDAD_EMPRESA) = 'MALAGA' 
OR UPPER(e.CIUDAD_EMPRESA) = 'MÁLAGA' 
OR UPPER(e.CIUDAD_EMPRESA) = 'HUELVA'
ORDER BY e.NOMBRE_EMPRESA DESC; 

--2. Mostrar los nombres de los destinos cuya ciudad contenga una b mayúscula o minúscula.

SELECT d.NOMBRE_DESTINO 
FROM DESTINO d 
WHERE UPPER(d.CIUDAD_DESTINO) LIKE '%B%'

--3. Obtener el código de los residuos con una cantidad superior a 4 del constituyente 116.

SELECT rc.COD_RESIDUO
FROM RESIDUO_CONSTITUYENTE rc
WHERE rc.CANTIDAD > 4
AND rc.COD_CONSTITUYENTE = 116;

--4. Muestra el tipo de transporte, los kilómetros y el coste de los traslados realizados en
--diciembre de 1994.

SELECT TIPO_TRANSPORTE, KMS, COSTE
FROM TRASLADO t 
WHERE EXTRACT(YEAR FROM FECHA_ENVIO) = 1994
AND EXTRACT(MONTH FROM FECHA_ENVIO) = 12;

--5. Mostrar el código del residuo y el número de constituyentes de cada residuo.

SELECT DISTINCT COD_RESIDUO, count(COD_CONSTITUYENTE) 
FROM RESIDUO_CONSTITUYENTE rc 
GROUP BY rc.COD_RESIDUO;

--6. Mostrar la cantidad media de residuo vertida por las empresas durante el año 1994.

SELECT NVL(AVG(NVL(re.CANTIDAD,0)),0)
FROM RESIDUO_EMPRESA re 
WHERE EXTRACT(YEAR FROM FECHA)=1994;

--7. Mostrar el mayor número de kilómetros de un traslado realizado el mes de marzo.

SELECT MAX(KMS)
FROM TRASLADO t 
WHERE EXTRACT(MONTH FROM t.FECHA_ENVIO)=3;

--8. Mostrar el número de constituyentes distintos que genera cada empresa, mostrando también
--el nif de la empresa, para aquellas empresas que generen más de 4 constituyentes.

SELECT COUNT(DISTINCT rc.COD_CONSTITUYENTE), re.NIF_EMPRESA 
FROM RESIDUO_EMPRESA re, RESIDUO r, RESIDUO_CONSTITUYENTE rc 
WHERE re.COD_RESIDUO = r.COD_RESIDUO 
AND r.COD_RESIDUO = rc.COD_RESIDUO 
GROUP BY re.NIF_EMPRESA
HAVING COUNT(rc.COD_CONSTITUYENTE)>4;

--9. Mostrar el nombre de las diferentes empresas que han enviado residuos que contenga la
--palabra metales en su descripción.

SELECT e.NOMBRE_EMPRESA 
FROM EMPRESAPRODUCTORA e, TRASLADO t, RESIDUO r 
WHERE e.NIF_EMPRESA = t.NIF_EMPRESA
AND t.COD_RESIDUO = r.COD_RESIDUO
AND t.COD_DESTINO IS NOT NULL
AND UPPER(r.OD_RESIDUO) LIKE '%METALES%';--??DESCRIPCION??

--10. Mostrar el número de envíos que se han realizado entre cada ciudad, indicando también la
--ciudad origen y la ciudad destino.

SELECT COUNT(d.COD_DESTINO), e.CIUDAD_EMPRESA AS CIUDAD_ORIGEN, d.CIUDAD_DESTINO 
FROM DESTINO d, TRASLADO t, EMPRESAPRODUCTORA e 
WHERE d.COD_DESTINO = t.COD_DESTINO 
AND t.NIF_EMPRESA = e.NIF_EMPRESA
GROUP BY e.CIUDAD_EMPRESA, d.CIUDAD_DESTINO;

--11. Mostrar el nombre de la empresa transportista que ha transportado para una empresa que
--esté en Málaga o en Huelva un residuo que contenga Bario o Lantano. Mostrar también la
--fecha del transporte.

SELECT DISTINCT et.NOMBRE_EMPTRANSPORTE, t.FECHA_ENVIO 
FROM EMPRESATRANSPORTISTA et, TRASLADO t, EMPRESAPRODUCTORA ep, RESIDUO_EMPRESA re ,RESIDUO r, RESIDUO_CONSTITUYENTE rc, CONSTITUYENTE c 
WHERE et.NIF_EMPTRANSPORTE = t.NIF_EMPTRANSPORTE 
AND t.NIF_EMPRESA = ep.NIF_EMPRESA 
AND ep.NIF_EMPRESA = re.NIF_EMPRESA 
AND re.COD_RESIDUO = r.COD_RESIDUO
AND r.COD_RESIDUO = rc.COD_RESIDUO 
AND rc.COD_CONSTITUYENTE = c.COD_CONSTITUYENTE 
AND (UPPER(ep.CIUDAD_EMPRESA) LIKE 'HUELVA'
OR UPPER(ep.CIUDAD_EMPRESA) LIKE 'MALAGA')
AND UPPER(c.NOMBRE_CONSTITUYENTE) LIKE 'BARIO' 
OR UPPER(c.NOMBRE_CONSTITUYENTE) LIKE 'LANTANO';

--12. Mostrar el coste por kilómetro del total de traslados encargados por la empresa productora
--Carbonsur.

SELECT round (sum(t.COSTE) /sum(t.KMS),2)
FROM TRASLADO t, EMPRESAPRODUCTORA e 
WHERE t.NIF_EMPRESA = e.NIF_EMPRESA 
AND UPPER(e.NOMBRE_EMPRESA) LIKE 'CARBONSUR';

--13. Mostrar el número de constituyentes de cada residuo.

SELECT COUNT(rc.COD_CONSTITUYENTE)
FROM RESIDUO_CONSTITUYENTE rc 
GROUP BY rc.COD_RESIDUO ;

--14. Mostrar la descripción de los residuos y la fecha que se generó el residuo, para aquellos
--residuos que se han generado en los últimos 30 días por una empresa cuyo nombre tenga una
--c. La consulta debe ser válida para cualquier fecha y el listado debe aparecer ordenado por la
--descripción del residuo y la fecha.


SELECT r.OD_RESIDUO, re.FECHA 
FROM RESIDUO r, RESIDUO_EMPRESA re, EMPRESAPRODUCTORA e 
WHERE r.COD_RESIDUO =re.COD_RESIDUO 
AND re.NIF_EMPRESA = e.NIF_EMPRESA 
AND re.FECHA > SYSDATE -30
AND UPPER(e.NOMBRE_EMPRESA) LIKE '%C%'
ORDER BY r.OD_RESIDUO, re.FECHA;



