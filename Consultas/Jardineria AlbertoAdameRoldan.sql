--1 Obt�n un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.
SELECT c.NOMBRE_CLIENTE, e.NOMBRE || ' ' ||  e.APELLIDO1 NOMBRECOMPLETO_EMPLEADO 
FROM CLIENTE c, EMPLEADO e 
WHERE c.CODIGO_EMPLEADO_REP_VENTAS = e.CODIGO_EMPLEADO; 


--2 Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus representantes de ventas.

SELECT DISTINCT  c.NOMBRE_CLIENTE, e.NOMBRE
FROM CLIENTE c, EMPLEADO e, pago p
WHERE c.CODIGO_EMPLEADO_REP_VENTAS = e.CODIGO_EMPLEADO
AND c.CODIGO_CLIENTE = p.CODIGO_CLIENTE;

--3 Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de sus representantes de ventas.

SELECT DISTINCT  c.NOMBRE_CLIENTE, e.NOMBRE
FROM CLIENTE c, EMPLEADO e
WHERE c.CODIGO_EMPLEADO_REP_VENTAS  = e.CODIGO_EMPLEADO
AND c.CODIGO_CLIENTE  NOT IN (SELECT cl.CODIGO_CLIENTE
								FROM CLIENTE cl, PAGO p 
								WHERE cl.CODIGO_CLIENTE =p.CODIGO_CLIENTE);
 
--OTRA FORMA SIN SUBCONSULTAS
							
SELECT DISTINCT  c.NOMBRE_CLIENTE, e.NOMBRE
FROM CLIENTE c, EMPLEADO e, PAGO p 
WHERE c.CODIGO_EMPLEADO_REP_VENTAS = e.CODIGO_EMPLEADO 
AND c.CODIGO_CLIENTE =p.CODIGO_CLIENTE(+)
AND p.CODIGO_CLIENTE IS NULL; 

--4 Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus 
--representantes junto con la ciudad de la oficina a la que pertenece el representante.

SELECT DISTINCT c.NOMBRE_CLIENTE, c.NOMBRE_CONTACTO, o.CIUDAD
FROM EMPLEADO e,OFICINA o, CLIENTE c,PAGO p
WHERE e.CODIGO_OFICINA=o.CODIGO_OFICINA
AND e.CODIGO_EMPLEADO = c.CODIGO_EMPLEADO_REP_VENTAS 
AND c.CODIGO_CLIENTE=p.CODIGO_CLIENTE;

--5 Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.

SELECT DISTINCT c.NOMBRE_CLIENTE,c.NOMBRE_CONTACTO,o.CIUDAD
FROM CLIENTE c,PAGO p,OFICINA o,EMPLEADO e
WHERE e.CODIGO_OFICINA=o.CODIGO_OFICINA
AND c.CODIGO_CLIENTE!=p.CODIGO_CLIENTE; --capt

--6 Lista la direcci�n de las oficinas que tengan clientes en Fuenlabrada.

SELECT DISTINCT o.CIUDAD, o.PAIS, o.REGION, o.LINEA_DIRECCION1, o.LINEA_DIRECCION2
FROM OFICINA o, CLIENTE c, EMPLEADO e
WHERE c.CODIGO_EMPLEADO_REP_VENTAS=e.CODIGO_EMPLEADO 
AND e.CODIGO_OFICINA=o.CODIGO_OFICINA
AND (UPPER(c.LINEA_DIRECCION2) LIKE '%FUENLABRADA%'
OR UPPER(c.LINEA_DIRECCION1) LIKE '%FUENLABRADA%'
OR UPPER(c.CIUDAD) LIKE '%FUENLABRADA%'
OR UPPER(o.LINEA_DIRECCION1) LIKE '%FUENLABRADA%'
OR UPPER(o.LINEA_DIRECCION2) LIKE '%FUENLABRADA%'
OR UPPER(o.CIUDAD) LIKE '%FUENLABRADA%'); 

--7 Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.

SELECT DISTINCT c.NOMBRE_CLIENTE,c.NOMBRE_CONTACTO, o.CIUDAD
FROM CLIENTE c,EMPLEADO e,OFICINA o
WHERE e.CODIGO_OFICINA=o.CODIGO_OFICINA
AND c.CODIGO_EMPLEADO_REP_VENTAS=e.CODIGO_EMPLEADO;  

--8 Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.

SELECT DISTINCT e.NOMBRE,e2.NOMBRE nombre_jefe
FROM EMPLEADO e, EMPLEADO e2
WHERE e.CODIGO_EMPLEADO=e2.CODIGO_JEFE;

--9 Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.

SELECT DISTINCT c.NOMBRE_CLIENTE
FROM CLIENTE c,PEDIDO p
WHERE c.CODIGO_CLIENTE=p.CODIGO_CLIENTE
AND p.FECHA_ENTREGA>p.FECHA_ESPERADA;

--10 Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.

SELECT DISTINCT p.GAMA  
FROM PRODUCTO p, DETALLE_PEDIDO dp, PEDIDO pe, CLIENTE c
WHERE p.CODIGO_PRODUCTO = dp.CODIGO_PRODUCTO 
AND dp.CODIGO_PEDIDO = pe.CODIGO_PEDIDO
AND pe.CODIGO_CLIENTE = c.CODIGO_CLIENTE;

--Consultas multitabla (composici�n externa)
  
--1 Devuelve un listado que muestre solamente los clientes que no han realizado ning�n pago.

SELECT DISTINCT c.NOMBRE_CLIENTE
FROM CLIENTE c
WHERE c.CODIGO_CLIENTE NOT IN(SELECT p.CODIGO_CLIENTE  FROM pago p);

--2 Devuelve un listado que muestre solamente los clientes que no han realizado ning�n pedido.

SELECT DISTINCT c.NOMBRE_CLIENTE
FROM CLIENTE c,PEDIDO p
WHERE c.CODIGO_CLIENTE!=p.CODIGO_CLIENTE;---

--3 Devuelve un listado que muestre los clientes que no han realizado ning�n pago y los que no han realizado ning�n pedido.

SELECT DISTINCT c.NOMBRE_CLIENTE
FROM CLIENTE c,PAGO p,PEDIDO pe
WHERE c.CODIGO_CLIENTE!=pe.CODIGO_CLIENTE
AND c.CODIGO_CLIENTE!=p.CODIGO_CLIENTE;---

--4 Devuelve un listado que muestre solamente los empleados que no tienen una oficina asociada.

SELECT DISTINCT e.NOMBRE
FROM EMPLEADO e,OFICINA o
WHERE e.CODIGO_OFICINA!=o.CODIGO_OFICINA;

--5 Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado.

SELECT DISTINCT e.NOMBRE
FROM EMPLEADO e 
WHERE e.CODIGO_EMPLEADO NOT IN (SELECT c.CODIGO_EMPLEADO_REP_VENTAS  FROM CLIENTE c);


--6 Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los que no tienen un cliente asociado.

SELECT DISTINCT e.NOMBRE
FROM EMPLEADO e 
WHERE e.CODIGO_EMPLEADO NOT IN (SELECT c.CODIGO_EMPLEADO_REP_VENTAS  FROM CLIENTE c)
AND e.CODIGO_OFICINA NOT IN (SELECT o.CODIGO_OFICINA  FROM OFICINA o);

--7 Devuelve un listado de los productos que nunca han aparecido en un pedido
  

SELECT DISTINCT p.NOMBRE, p.CODIGO_PRODUCTO 
FROM PRODUCTO p, DETALLE_PEDIDO dp
WHERE p.CODIGO_PRODUCTO = dp.CODIGO_PRODUCTO(+)
AND dp.CODIGO_PRODUCTO IS NULL;



--8 Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes de ventas de alg�n cliente que haya realizado la compra de alg�n producto de la gama Frutales.
  
SELECT DISTINCT o.CODIGO_OFICINA
FROM OFICINA o , EMPLEADO e ,CLIENTE c ,PEDIDO p ,DETALLE_PEDIDO dp,PRODUCTO pr
WHERE o.CODIGO_OFICINA(+)=e.CODIGO_OFICINA
AND e.CODIGO_EMPLEADO=c.CODIGO_EMPLEADO_REP_VENTAS
AND c.CODIGO_CLIENTE=p.CODIGO_CLIENTE
AND p.CODIGO_PEDIDO=DP.CODIGO_PEDIDO
AND dp.CODIGO_PRODUCTO=pr.CODIGO_PRODUCTO
AND o.CODIGO_OFICINA IS NULL
AND UPPER(pr.GAMA) LIKE 'FRUTALES';---------

--9 Devuelve un listado con los clientes que han realizado alg�n pedido, pero no han realizado ning�n pago.
  
SELECT DISTINCT c.NOMBRE_CLIENTE
FROM CLIENTE c,PAGO pa, PEDIDO p
WHERE c.CODIGO_CLIENTE=p.CODIGO_CLIENTE
AND c.CODIGO_CLIENTE=pa.CODIGO_CLIENTE(+)
AND pa.CODIGO_CLIENTE IS NULL;

--10 Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el nombre de su jefe asociado.

SELECT e.NOMBRE, e2.NOMBRE JEFE
FROM EMPLEADO e , CLIENTE c, EMPLEADO e2 
WHERE e.CODIGO_EMPLEADO!=c.CODIGO_EMPLEADO_REP_VENTAS;---

--Consultas resumen


--1 �Cu�ntos empleados hay en la compa��a?
  
SELECT DISTINCT  COUNT (NVL(e.NOMBRE,0)) 
FROM EMPLEADO e;-- SI ES PRIMARY KEY NO HACE FALTA COUNT

--2 �Cu�ntos clientes tiene cada pa�s?
  
SELECT COUNT(c.NOMBRE_CLIENTE), c.PAIS
FROM CLIENTE c
GROUP BY c.PAIS;

--3 �Cu�l fue el pago medio en 2009?

SELECT AVG(nvL(p.TOTAL,0)) 
FROM PAGO p
WHERE EXTRACT(YEAR FROM p.FECHA_PAGO)=2009;

--4 �Cu�ntos pedidos hay en cada estado? Ordena el resultado de forma descendente por el n�mero de pedidos.
  
SELECT COUNT(p.CODIGO_PEDIDO), p.ESTADO
FROM PEDIDO p
GROUP BY p.ESTADO
ORDER BY COUNT(p.CODIGO_PEDIDO) DESC;

--5 Calcula el precio de venta del producto m�s caro y m�s barato en una misma consulta.
  
SELECT MAX(PRECIO_VENTA), MIN(PRECIO_VENTA) 
FROM PRODUCTO;

--6 Calcula el n�mero de clientes que tiene la empresa.
  
SELECT DISTINCT  COUNT (NVL(c.NOMBRE_CLIENTE,0)) CLIENTE_EMPRESA
FROM CLIENTE c;

--7 �Cu�ntos clientes tiene la ciudad de Madrid?
  
SELECT COUNT(c.NOMBRE_CLIENTE)
FROM CLIENTE c
WHERE UPPER(c.CIUDAD) LIKE 'MADRID';

--8 �Calcula cu�ntos clientes tiene cada una de las ciudades que empiezan por M?
  
SELECT COUNT(c.NOMBRE_CLIENTE), c.CIUDAD
FROM CLIENTE c
WHERE UPPER(c.CIUDAD) LIKE 'M%'
GROUP BY c.CIUDAD;

--9 Devuelve el c�digo de empleado y el n�mero de clientes al que atiende cada representante de ventas.
  
SELECT c.CODIGO_EMPLEADO_REP_VENTAS  ,COUNT(NVL(c.NOMBRE_CLIENTE,0))
FROM CLIENTE c
GROUP BY c.CODIGO_EMPLEADO_REP_VENTAS ;

--10 Calcula el n�mero de clientes que no tiene asignado representante de ventas.
  
SELECT COUNT(NVL(c.NOMBRE_CLIENTE,0))
FROM CLIENTE c
WHERE c.CODIGO_EMPLEADO_REP_VENTAS IS NULL;

--11 Calcula la fecha del primer y �ltimo pago realizado por cada uno de los clientes.
  
SELECT DISTINCT c.NOMBRE_CLIENTE, MIN(p.FECHA_PAGO) ,MAX(p.FECHA_PAGO) 
FROM PAGO p , CLIENTE c 
GROUP BY p.CODIGO_CLIENTE, c.NOMBRE_CLIENTE ;----------

--12 Calcula el n�mero de productos diferentes que hay en cada uno de los pedidos.

SELECT COUNT(DISTINCT dp.CODIGO_PRODUCTO), dp.CODIGO_PEDIDO 
FROM DETALLE_PEDIDO dp
GROUP BY dp.CODIGO_PEDIDO;

--13 Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de los pedidos.

SELECT SUM(dp.CANTIDAD) , dp.CODIGO_PEDIDO 
FROM DETALLE_PEDIDO dp
GROUP BY dp.CODIGO_PEDIDO;

--14 Devuelve un listado de los 20 c�digos de productos m�s vendidos y el n�mero total de unidades que se han vendido de cada uno. El listado deber� estar ordenado por el n�mero total de unidades vendidas.

SELECT * FROM(
SELECT dp.CODIGO_PRODUCTO, sum(dp.CANTIDAD)
FROM DETALLE_PEDIDO dp
GROUP BY dp.CODIGO_PRODUCTO
ORDER BY sum(dp.CANTIDAD) DESC)
WHERE rownum<=20;

--15 La facturaci�n que ha tenido la empresa en toda la historia, indicando la base imponible, el IVA y el total facturado. La base imponible se calcula sumando el coste del producto por el n�mero de unidades vendidas de la tabla detalle_pedido. El IVA es el 21 % de la base imponible, y el total la suma de los dos campos anteriores.

SELECT SUM(dp.PRECIO_UNIDAD*dp.CANTIDAD) BASE_IMPONIBLE, (SUM(dp.PRECIO_UNIDAD*dp.CANTIDAD))*0.21+ SUM(dp.PRECIO_UNIDAD*dp.CANTIDAD) IVA 
FROM DETALLE_PEDIDO dp;--- FALTA EL TOTAL_fACTURADO

--16 La misma informaci�n que en la pregunta anterior, pero agrupada por c�digo de producto.

SELECT SUM(dp.PRECIO_UNIDAD*dp.CANTIDAD) BASE_IMPONIBLE,(SUM(dp.PRECIO_UNIDAD*DP.CANTIDAD))*0.21+ SUM(dp.PRECIO_UNIDAD*DP.CANTIDAD) IVA
FROM DETALLE_PEDIDO dp
GROUP BY dp.CODIGO_PRODUCTO;--IFUAL FALTA

--17 La misma informaci�n que en la pregunta anterior, pero agrupada por c�digo de producto filtrada por los c�digos que empiecen por OR.

SELECT dp.CODIGO_PRODUCTO, SUM(dp.PRECIO_UNIDAD*DP.CANTIDAD) BASE_IMPONIBLE,(SUM(dp.PRECIO_UNIDAD*dp.CANTIDAD))*0.21+ SUM(dp.PRECIO_UNIDAD*DP.CANTIDAD) IVA
FROM DETALLE_PEDIDO dp
WHERE UPPER(dp.CODIGO_PRODUCTO) LIKE 'OR%'
GROUP BY DP.CODIGO_PRODUCTO;--falta total_factura

--18 Lista las ventas totales de los productos que hayan facturado m�s de 3000 euros. Se mostrar� el nombre, unidades vendidas, total facturado y total facturado con impuestos (21% IVA).

--capt


--Subconsultas

--1 Devuelve el nombre del cliente con mayor l�mite de cr�dito.

SELECT c.NOMBRE_CLIENTE 
FROM CLIENTE c
WHERE c.LIMITE_CREDITO = (SELECT MAX(cl.LIMITE_CREDITO) FROM CLIENTE cl);

--2 Devuelve el nombre, apellido1 y cargo de los empleados que no representen a ning�n cliente.

SELECT DISTINCT e.NOMBRE,e.APELLIDO1  ,e.PUESTO 
FROM EMPLEADO e
WHERE e.CODIGO_EMPLEADO NOT IN
(SELECT e2.CODIGO_EMPLEADO  FROM CLIENTE c, EMPLEADO e2 
WHERE e2.CODIGO_EMPLEADO = c.CODIGO_EMPLEADO_REP_VENTAS);


--3 Devuelve el nombre del producto que tenga el precio de venta m�s caro.

SELECT p.NOMBRE  
FROM PRODUCTO p 
WHERE p.PRECIO_VENTA = (SELECT MAX(pr.PRECIO_VENTA)  FROM PRODUCTO pr);

--4 Devuelve el nombre del producto del que se han vendido m�s unidades. 
--(Ten en cuenta que tendr�s que calcular cu�l es el n�mero total de unidades que se han 
--vendido de cada producto a partir de los datos de la tabla detalle_pedido. 
--Una vez que sepas cu�l es el c�digo del producto, puedes obtener su nombre f�cilmente.)

SELECT p.n
FROM PRODUCTO p , DETALLE_PEDIDO dp 
WHERE p.CODIGO_PRODUCTO = dp.CODIGO_PRODUCTO 
GROUP BY dp.CODIGO_PRODUCTO , p.NOMBRE ;
---------capt

--5 Los clientes cuyo l�mite de cr�dito sea mayor que los pagos que haya realizado.

SELECT c.NOMBRE_CLIENTE 
FROM CLIENTE c
WHERE c.LIMITE_CREDITO > (SELECT SUM(p.TOTAL) 
						  FROM PAGO p 
						  WHERE p.FORMA_PAGO=c.CODIGO_CLIENTE);

--6 El producto que m�s unidades tiene en stock y el que menos unidades tiene.

SELECT p.NOMBRE
FROM PRODUCTO p
WHERE p.CANTIDAD_EN_STOCK = (SELECT MAX(CANTIDAD_EN_STOCK) 
							 FROM PRODUCTO)
OR p.CANTIDAD_EN_STOCK = (SELECT MIN(CANTIDAD_EN_STOCK) 
						  FROM PRODUCTO);

--7 Devuelve el nombre, los apellidos y el email de los empleados a cargo de Alberto Soria.

SELECT e.NOMBRE, e.APELLIDO1, e.APELLIDO2, e.EMAIL
FROM EMPLEADO e
WHERE e.CODIGO_JEFE=(SELECT CODIGO_EMPLEADO 
					FROM EMPLEADO
					WHERE UPPER(NOMBRE)='%ALBERTO%'
					AND UPPER(APELLIDO1) LIKE '%SORIA%');--------

--Consultas variadas
 
--1 Devuelve el listado de clientes indicando el nombre del cliente y cu�ntos pedidos ha realizado. Tenga en cuenta que pueden existir clientes que no han realizado ning�n pedido.

SELECT DISTINCT c.NOMBRE_CLIENTE, dp.CANTIDAD 
FROM CLIENTE c ,PEDIDO p ,DETALLE_PEDIDO dp
WHERE c.CODIGO_CLIENTE=p.CODIGO_CLIENTE
AND (p.CODIGO_PEDIDO=dp.CODIGO_PEDIDO
OR c.CODIGO_CLIENTE!=P.CODIGO_CLIENTE);----capt

--2 Devuelve un listado con los nombres de los clientes y el total pagado por cada uno de ellos. Tenga en cuenta que pueden existir clientes que no han realizado ning�n pago.

SELECT c.NOMBRE_CLIENTE CLIENTE ,NVL(SUM(p.TOTAL),0) TOTAL_PAGADO 
FROM CLIENTE c, PAGO p
WHERE c.CODIGO_CLIENTE=p.CODIGO_CLIENTE(+)
GROUP BY c.NOMBRE_CLIENTE;

--3 Devuelve el nombre de los clientes que hayan hecho pedidos en 2008 ordenados alfab�ticamente de menor a mayor.

SELECT DISTINCT c.NOMBRE_CLIENTE CLIENTE
FROM CLIENTE c,PEDIDO p
WHERE c.CODIGO_CLIENTE=p.CODIGO_CLIENTE
AND EXTRACT(YEAR FROM FECHA_PEDIDO)=2008
ORDER BY c.NOMBRE_CLIENTE;

--4 Devuelve el nombre del cliente, el nombre y primer apellido de su representante de ventas y el n�mero de tel�fono de la oficina del representante de ventas, de aquellos clientes que no hayan realizado ning�n pago.

SELECT DISTINCT c.NOMBRE_CLIENTE, c.NOMBRE_CONTACTO, c.APELLIDO_CONTACTO, o.TELEFONO 
FROM EMPLEADO e, OFICINA o, CLIENTE c,PAGO p
WHERE e.CODIGO_OFICINA=o.CODIGO_OFICINA
AND e.CODIGO_EMPLEADO=c.CODIGO_EMPLEADO_REP_VENTAS
AND c.CODIGO_CLIENTE=p.CODIGO_CLIENTE(+)
AND p.CODIGO_CLIENTE IS NULL;

--5 Devuelve el listado de clientes donde aparezca el nombre del cliente, el nombre y primer apellido de su representante de ventas y la ciudad donde esta? su oficina.

SELECT DISTINCT c.NOMBRE_CLIENTE, c.NOMBRE_CONTACTO, c.APELLIDO_CONTACTO, o.CIUDAD 
FROM EMPLEADO e, OFICINA o, CLIENTE c
WHERE e.CODIGO_OFICINA=o.CODIGO_OFICINA
AND e.CODIGO_EMPLEADO=c.CODIGO_EMPLEADO_REP_VENTAS;

--6 Devuelve el nombre, apellidos, puesto y tel�fono de la oficina de aquellos empleados que no sean representante de ventas de ning�n cliente.

SELECT DISTINCT e.NOMBRE, e.APELLIDO1, e.APELLIDO2, e.PUESTO, o.TELEFONO 
FROM EMPLEADO e, OFICINA o,CLIENTE c
WHERE e.CODIGO_OFICINA=o.CODIGO_OFICINA
AND e.CODIGO_EMPLEADO=c.CODIGO_EMPLEADO_REP_VENTAS(+)
AND c.CODIGO_EMPLEADO_REP_VENTAS IS NULL;

--7 Devuelve un listado indicando todas las ciudades donde hay oficinas y el n�mero de empleados que tiene.
SELECT COUNT(NVL(e.CODIGO_EMPLEADO,0)) NUMERO_EMPLEADOS, o.CIUDAD
FROM EMPLEADO e, OFICINA o
WHERE e.CODIGO_OFICINA=o.CODIGO_OFICINA
GROUP BY o.CIUDAD;


