--1. Número de clientes que tienen alguna factura con IVA 16%.

SELECT COUNT(c.CODCLI)
FROM CLIENTES c 
WHERE c.CODCLI IN (SELECT f.CODCLI 
				  FROM FACTURAS f
				  WHERE f.IVA=16);
				 
SELECT COUNT(f.CODCLI)
FROM FACTURAS f
WHERE f.IVA =16;

--2. Número de clientes que no tienen ninguna factura con un 16% de IVA.
				 
SELECT COUNT(c.CODCLI) 
FROM CLIENTES c
WHERE c.CODCLI IN (SELECT f.CODCLI 
				  FROM FACTURAS f
				  WHERE f.IVA!=16);
				 
SELECT COUNT(f.CODCLI)
FROM FACTURAS f
WHERE f.IVA !=16;

--3. Número de clientes que en todas sus facturas tienen un 16% de IVA (los clientes deben tener al 
--menos una factura).

SELECT COUNT(c.CODCLI)
FROM CLIENTES c 
WHERE c.CODCLI IN (SELECT f.CODCLI 
				  FROM FACTURAS f
				  WHERE f.IVA=16);
				 
--4. Fecha de la factura con mayor importe (sin tener en cuenta descuentos ni impuestos).

SELECT f.FECHA 
FROM FACTURAS f, LINEAS_FAC lf
WHERE f.CODFAC = lf.CODFAC
AND lf.PRECIO = (SELECT MAX(lf2.PRECIO)
				 FROM LINEAS_FAC lf2);

--5. Número de pueblos en los que no tenemos clientes.
				 
SELECT COUNT(p.CODPUE)
FROM PUEBLOS p 
WHERE p.CODPUE NOT IN (SELECT c.CODPUE 
				       FROM CLIENTES c);
				      

SELECT COUNT(p.CODPUE)
FROM PUEBLOS p, CLIENTES c
WHERE p.CODPUE = c.CODPUE(+)
AND c.CODPUE IS NULL;


--6. Número de artículos cuyo stock supera las 20 unidades, con precio superior a 15 euros 
--y de los que no hay ninguna factura en el último trimestre del año pasado.

SELECT COUNT(a.CODART) 
FROM ARTICULOS a 
WHERE a.STOCK > 20
AND a.PRECIO > 15
AND a.CODART NOT IN (SELECT lf.CODART  
				  FROM LINEAS_FAC lf, FACTURAS f 
				  WHERE lf.CODFAC=f.CODFAC
				  AND  (EXTRACT (YEAR  FROM f.FECHA))=(EXTRACT (YEAR  FROM sysdate)-1)
				  AND (EXTRACT (MONTH FROM f.FECHA))>=10);---algo hay raro
	
				 


--7. Obtener el número de clientes que en todas las facturas del año pasado han pagado IVA 
--(no se ha pagado IVA si es cero o nulo).
SELECT COUNT(c.CODCLI)
FROM CLIENTES c 
WHERE c.CODCLI IN (SELECT f.CODCLI  
				  FROM FACTURAS f 
				  WHERE (EXTRACT (YEAR FROM SYSDATE) -1) = EXTRACT(YEAR FROM f.FECHA)
				  AND (f.IVA != 0
				  AND f.IVA  IS NOT NULL));

--8. Clientes (código y nombre) que fueron preferentes durante el mes de noviembre del año pasado y 
--que en diciembre de ese mismo año no tienen ninguna factura. Son clientes preferentes de un mes 
--aquellos que han solicitado más de 60,50 euros en facturas durante ese mes, sin tener en cuenta 
--descuentos ni impuestos.

SELECT c.CODCLI, c.NOMBRE 
FROM CLIENTES c, (SELECT f.CODCLI, f.FECHA
				  FROM LINEAS_FAC lf, FACTURAS f 
				  WHERE lf.CODFAC= f.CODFAC
				  AND EXTRACT(YEAR FROM f.FECHA)=EXTRACT (YEAR FROM SYSDATE)-1
				  AND EXTRACT(MONTH FROM f.FECHA)=11
				  GROUP BY f.CODCLI, f.FECHA
				  HAVING SUM(lf.PRECIO)>60.50) cliente_preferente
WHERE c.CODCLI  = cliente_preferente.CODCLI
AND EXTRACT(YEAR FROM cliente_preferente.FECHA)=EXTRACT (YEAR FROM SYSDATE)-1
AND EXTRACT(MONTH FROM cliente_preferente.FECHA)=12;---ESTÁ BIEN , PENSAR PQ

--9. Código, descripción y precio de los diez artículos más caros.

SELECT CODART, DESCRIP, PRECIO  
FROM (SELECT a.CODART, a.DESCRIP, a.PRECIO  
	  FROM ARTICULOS a 
	  ORDER BY a.PRECIO DESC) 
WHERE ROWNUM <= 10;

--10. Nombre de la provincia con mayor número de clientes.

SELECT NOMBRE 
FROM (SELECT COUNT(c.CODCLI), pr.NOMBRE 
	  FROM PROVINCIAS pr, PUEBLOS p, CLIENTES c
	  WHERE pr.CODPRO = p.CODPRO 
	  AND p.CODPUE = c.CODPUE 
	  GROUP BY pr.NOMBRE  
	  ORDER BY COUNT(c.CODCLI) DESC) 
WHERE ROWNUM =1;
				  
				  
--11. Código y descripción de los artículos cuyo precio es mayor de 90,15 euros y se han vendido 
--menos de 10 unidades (o ninguna) durante el año pasado.

SELECT DISTINCT a.CODART, a.DESCRIP 
FROM ARTICULOS a, LINEAS_FAC lf
WHERE lf.CODART =a.CODART 
AND a.PRECIO > 90.15
AND lf.CANT < 10
AND lf.CODFAC in (SELECT f.CODFAC 
				  FROM FACTURAS f 
				  WHERE (EXTRACT(YEAR FROM SYSDATE)-1) = 2021);--MIRAR EN CAPTURAS

--12. Código y descripción de los artículos cuyo precio es más de tres mil veces mayor que el precio 
--mínimo de cualquier artículo.

SELECT DISTINCT a.CODART, a.DESCRIP 
FROM ARTICULOS a 
WHERE a.PRECIO > (SELECT (MIN(a2.PRECIO)*3000)
					     FROM ARTICULOS a2);

--13. Nombre del cliente con mayor facturación.
				 
SELECT c.NOMBRE 
FROM CLIENTES c, FACTURAS f, LINEAS_FAC lf  
WHERE c.CODCLI = f.CODCLI 
AND f.CODFAC = lf.CODFAC 
GROUP BY c.NOMBRE 
HAVING SUM(lf.PRECIO)=(SELECT MAX(SUM(lf2.PRECIO))
					   FROM LINEAS_FAC lf2, FACTURAS f2
					   WHERE lf2.CODFAC = f2.CODFAC  
					   GROUP BY f2.CODCLI);--podría hacerse mejor


--14. Código y descripción de aquellos artículos con un precio superior a la media y que hayan sido 
--comprados por más de 5 clientes.

SELECT a.CODART, a.DESCRIP 
FROM ARTICULOS a, LINEAS_FAC lf, FACTURAS f 
WHERE a.CODART = lf.CODART 
AND lf.CODFAC = f.CODFAC 
AND a.PRECIO > (SELECT AVG(NVL(a2.PRECIO,0)) 
				  FROM ARTICULOS a2)
AND f.CODCLI IN (SELECT f2.CODCLI  
				 FROM FACTURAS f2, LINEAS_FAC lf2
				 WHERE f2.CODFAC= lf2.CODFAC
				 GROUP BY lf2.CODART ,f2.CODCLI
				 HAVING COUNT(f2.CODCLI)>5);
	
				 

