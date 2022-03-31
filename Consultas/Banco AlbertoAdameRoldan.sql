--1.Mostrar el saldo medio de todas las cuentas de la entidad bancaria con dos decimales y
--la suma de los saldos de todas las cuentas bancarias.
SELECT AVG(NVL(SALDO,0)), SUM(SALDO) 
FROM CUENTA c 
WHERE SALDO LIKE '%.__';-----

SELECT SALDO d FROM CUENTA c; 
--2. Mostrar el saldo mínimo, máximo y medio de todas las cuentas bancarias.
SELECT MAX(SALDO), MIN(SALDO), AVG(SALDO) 
FROM CUENTA c;

--3. Mostrar la suma de los saldos y el saldo medio de las cuentas bancarias por cada
--código de sucursal.
SELECT SUM(SALDO), AVG(NVL(SALDO,0))
FROM CUENTA c;

--4. Para cada cliente del banco se desea conocer su código, la cantidad total que tiene
--depositada en la entidad y el número de cuentas abiertas.

SELECT cl.COD_CLIENTE , cu.SALDO, COUNT(cu.COD_CUENTA) 
FROM CLIENTE cl, CUENTA cu 
WHERE cl.COD_CLIENTE = cu.COD_CLIENTE
GROUP BY cl.COD_CLIENTE, cu.SALDO;

--5. Retocar la consulta anterior para que aparezca el nombre y apellidos de cada cliente en
--vez de su código de cliente.

SELECT DISTINCT cl.NOMBRE, cl.APELLIDOS  , cu.SALDO, COUNT(cu.COD_CUENTA) 
FROM CLIENTE cl, CUENTA cu 
WHERE cl.COD_CLIENTE = cu.COD_CLIENTE
GROUP BY cl.NOMBRE, cl.APELLIDOS , cu.SALDO;

--6. Para cada sucursal del banco se desea conocer su dirección, el número de cuentas que
--tiene abiertas y la suma total que hay en ellas.

SELECT s.DIRECCION, COUNT(c.COD_CUENTA), SUM(c.SALDO)
FROM SUCURSAL s, CUENTA c 
WHERE s.COD_SUCURSAL = c.COD_SUCURSAL
GROUP BY s.DIRECCION;

--7. Mostrar el saldo medio y el interés medio de las cuentas a las que se le aplique un
--interés mayor del 10%, de las sucursales 1 y 2.

SELECT AVG(NVL(c.SALDO,0)), AVG(NVL(c.INTERES ,0))
FROM CUENTA c, SUCURSAL s 
WHERE c.COD_SUCURSAL = s.COD_SUCURSAL 
AND INTERES > 10
AND (s.COD_SUCURSAL = 1
OR s.COD_SUCURSAL = 2);

--8. Mostrar los tipos de movimientos de las cuentas bancarias, sus descripciones y el
--volumen total de dinero que se manejado en cada tipo de movimiento.

SELECT
	m.COD_TIPO_MOVIMIENTO,
	tm.DESCRIPCION,
	SUM(m.IMPORTE)
FROM
	MOVIMIENTO m,
	TIPO_MOVIMIENTO tm
GROUP BY
	m.COD_TIPO_MOVIMIENTO,
	tm.DESCRIPCION;

--9. Mostrar cuál es la cantidad media que los clientes de nuestro banco tienen en el
--epígrafe “Retirada por cajero automático”.

SELECT COUNT(c.COD_CLIENTE)
FROM CLIENTE c, CUENTA cu, MOVIMIENTO m, TIPO_MOVIMIENTO tm 
WHERE c.COD_CLIENTE = cu.COD_CLIENTE 
AND cu.COD_CUENTA = m.COD_CUENTA 
AND m.COD_TIPO_MOVIMIENTO = tm.COD_TIPO_MOVIMIENTO 
AND tm.DESCRIPCION LIKE 'Retirada por cajero automático';

--10. Calcular la cantidad total de dinero que emite la entidad bancaria clasificada según los
--tipos de movimientos de salida.

SELECT 
FROM 
WHERE 
AND

--11. Calcular la cantidad total de dinero que ingresa cada cuenta bancaria clasificada según
--los tipos de movimientos de entrada mostrando además la descripción del tipo de
--movimiento.

SELECT SUM(m.IMPORTE), tm.DESCRIPCION 
FROM CUENTA c, MOVIMIENTO m, TIPO_MOVIMIENTO tm 
WHERE c.COD_CUENTA = m.COD_CUENTA 
AND m.COD_TIPO_MOVIMIENTO = tm.COD_TIPO_MOVIMIENTO 
AND UPPER(tm.DESCRIPCION) LIKE '%INGRESO%'
GROUP BY tm.DESCRIPCION;

--12. Calcular la cantidad total de dinero que sale de la sucursal de Paseo Castellana.

SELECT SUM(c.SALDO)
FROM SUCURSAL s, CUENTA c 
WHERE s.COD_SUCURSAL = c.COD_SUCURSAL 
AND UPPER(s.DIRECCION) LIKE '%PASEO CASTELLANA%';
--13. Mostrar la suma total por tipo de movimiento de las cuentas bancarias de los clientes
--del banco. Se deben mostrar los siguientes campos: apellidos, nombre, cod_cuenta,
--descripción del tipo movimiento y el total acumulado de los movimientos de un
--mismo tipo.

SELECT SUM(m.IMPORTE), cl.NOMBRE, cl.APELLIDOS, c.COD_CUENTA 
FROM CLIENTE cl,CUENTA c, MOVIMIENTO m, TIPO_MOVIMIENTO tm 
WHERE cl.COD_CLIENTE = c.COD_CLIENTE 
AND c.COD_CUENTA = m.COD_CUENTA 
AND m.COD_TIPO_MOVIMIENTO = tm.COD_TIPO_MOVIMIENTO 
GROUP BY cl.NOMBRE, cl.APELLIDOS, c.COD_CUENTA ;

--14. Contar el número de cuentas bancarias que no tienen asociados movimientos.

SELECT COUNT(c.COD_CUENTA) 
FROM CUENTA c, MOVIMIENTO m 
WHERE c.COD_CUENTA = m.COD_CUENTA 
AND m.NUM_MOV_MES =0;

--15. Por cada cliente, contar el número de cuentas bancarias que posee sin movimientos. Se
--deben mostrar los siguientes campos: cod_cliente, num_cuentas_sin_movimiento.

SELECT COUNT(c.COD_CUENTA), cl.NOMBRE 
FROM CLIENTE cl, CUENTA c, MOVIMIENTO m 
WHERE cl.COD_CLIENTE = c.COD_CLIENTE 
AND c.COD_CUENTA = m.COD_CUENTA 
AND m.NUM_MOV_MES =0
GROUP BY cl.NOMBRE;

--16. Mostrar el código de cliente, la suma total del dinero de todas sus cuentas y el número
--de cuentas abiertas, sólo para aquellos clientes cuyo capital supere los 35.000 euros.

SELECT c.COD_CLIENTE, SUM(c.SALDO)
FROM CUENTA c 
HAVING SUM(c.SALDO)>35.000
GROUP BY c.COD_CLIENTE ;

--17. Mostrar los apellidos, el nombre y el número de cuentas abiertas sólo de aquellos
--clientes que tengan más de 2 cuentas.

SELECT cl.APELLIDOS, cl.NOMBRE, COUNT(c.COD_CUENTA)
FROM CLIENTE cl, CUENTA c 
WHERE cl.COD_CLIENTE = c.COD_CLIENTE
GROUP BY cl.APELLIDOS, cl.NOMBRE
HAVING COUNT(c.COD_CUENTA)>=2;

--18. Mostrar el código de sucursal, dirección, capital del año anterior y la suma de los
--saldos de sus cuentas, sólo de aquellas sucursales cuya suma de los saldos de las
--cuentas supera el capital del año anterior ordenadas por sucursal.

SELECT s.COD_SUCURSAL, s.DIRECCION, s.CAPITAL_ANIO_ANTERIOR, SUM(c.SALDO)
FROM SUCURSAL s, CUENTA c 
WHERE s.COD_SUCURSAL = c.COD_SUCURSAL 
GROUP BY s.COD_SUCURSAL, s.DIRECCION, s.CAPITAL_ANIO_ANTERIOR 
HAVING SUM(c.SALDO)>s.CAPITAL_ANIO_ANTERIOR;

--19. Mostrar el código de cuenta, su saldo, la descripción del tipo de movimiento y la suma
--total de dinero por movimiento, sólo para aquellas cuentas cuya suma total de dinero
--por movimiento supere el 20% del saldo.

SELECT c.COD_CUENTA, c.SALDO, tm.DESCRIPCION , MAX(m.IMPORTE)
FROM CUENTA c , MOVIMIENTO m, TIPO_MOVIMIENTO tm 
WHERE c.COD_CUENTA = m.COD_CUENTA 
AND m.COD_TIPO_MOVIMIENTO = tm.COD_TIPO_MOVIMIENTO 
GROUP BY c.COD_CUENTA, c.SALDO, tm.DESCRIPCION
HAVING MAX(m.IMPORTE)>(c.SALDO*0.2);

--20. Mostrar los mismos campos del ejercicio anterior pero ahora sólo de aquellas cuentas
--cuya suma de importes por movimiento supere el 10% del saldo y no sean de la
--sucursal 4.

SELECT c.COD_CUENTA, c.SALDO, tm.DESCRIPCION , MAX(m.IMPORTE)
FROM CUENTA c , SUCURSAL s, MOVIMIENTO m, TIPO_MOVIMIENTO tm 
WHERE c.COD_CUENTA = m.COD_CUENTA 
AND s.COD_SUCURSAL = c.COD_SUCURSAL 
AND m.COD_TIPO_MOVIMIENTO = tm.COD_TIPO_MOVIMIENTO 
AND s.COD_SUCURSAL !=4
GROUP BY c.COD_CUENTA, c.SALDO, tm.DESCRIPCION
HAVING MAX(m.IMPORTE)>(c.SALDO*0.1);

--21. Mostrar los datos de aquellos clientes para los que el saldo de sus cuentas suponga al
--menos el 20% del capital del año anterior de su sucursal.

SELECT cl.*
FROM CLIENTE cl, CUENTA c, SUCURSAL s 
WHERE  cl.COD_CLIENTE = c.COD_CLIENTE 
AND c.COD_SUCURSAL = s.COD_SUCURSAL 
AND c.SALDO < s.CAPITAL_ANIO_ANTERIOR * 0.2;
