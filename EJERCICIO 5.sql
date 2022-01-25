# EJERCICIO 5

# 1) Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.
SELECT codigo_oficina, ciudad FROM oficina;

# 2) Devuelve un listado con la ciudad y el teléfono de las oficinas de España.
SELECT ciudad, telefono FROM oficina WHERE pais LIKE 'España';

# 3) Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe
# tiene un código de jefe igual a 7.
SELECT nombre, apellido1, apellido2, email,codigo_jefe FROM empleado WHERE codigo_jefe=7;

# 4) Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa.
SELECT puesto, nombre, apellido1, apellido2, email FROM empleado WHERE codigo_jefe IS NULL;

# 5) Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que
# no sean representantes de ventas.
SELECT nombre, apellido1, apellido2, puesto FROM empleado WHERE puesto NOT LIKE 'Repre%';

# 6) Devuelve un listado con el nombre de los todos los clientes españoles
SELECT * FROM cliente WHERE pais LIKE 'Spain';

# 7) Devuelve un listado con los distintos estados por los que puede pasar un pedido.
SELECT estado FROM pedido GROUP BY estado;

# 8) Devuelve un listado con el código de cliente de aquellos clientes que realizaron
# algún pago en 2008. Tenga en cuenta que deberá eliminar aquellos códigos de
# cliente que aparezcan repetidos. Resuelva la consulta:
# o Utilizando la función YEAR de MySQL.
# o Utilizando la función DATE_FORMAT de MySQL.
# o Sin utilizar ninguna de las funciones anteriores
SELECT codigo_cliente FROM pago WHERE fecha_pago LIKE '2008%' GROUP BY codigo_cliente;
SELECT codigo_cliente, fecha_pago FROM pago WHERE EXTRACT(YEAR FROM fecha_pago) AND fecha_pago=2008;

# 9) Devuelve un listado con el código de pedido, código de cliente, fecha esperada y
# fecha de entrega de los pedidos que no han sido entregados a tiempo.
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega FROM pedido
WHERE fecha_entrega>fecha_esperada;

# 11) Devuelve un listado de todos los pedidos que fueron rechazados en 2009
SELECT * FROM pedido WHERE estado LIKE 'Rechazado' AND fecha_pedido LIKE '2008%';

# 12) Devuelve un listado de todos los pedidos que han sido entregados en el mes de enero de cualquier año.
SELECT * FROM pedido WHERE fecha_entrega LIKE '%01%-%';

# 13) Devuelve un listado con todos los pagos que se realizaron en el año 2008 mediante
# Paypal. Ordene el resultado de mayor a menor
SELECT * FROM pago WHERE forma_pago LIKE 'Pay%' AND fecha_pago LIKE '2008%';

# 14) Devuelve un listado con todas las formas de pago que aparecen en la tabla pago.
# Tenga en cuenta que no deben aparecer formas de pago repetidas.
SELECT forma_pago FROM pago GROUP BY forma_pago;

# 15) Devuelve un listado con todos los productos que pertenecen a la gama
# Ornamentales y que tienen más de 100 unidades en stock. El listado deberá estar
# ordenado por su precio de venta, mostrando en primer lugar los de mayor precio.
SELECT * FROM producto WHERE gama LIKE 'Ornamentales' AND cantidad_en_stock > 100 
ORDER BY precio_venta DESC;

# 16) Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y cuyo
# representante de ventas tenga el código de empleado 11 o 30.
SELECT * FROM cliente WHERE ciudad LIKE 'Madrid' AND codigo_empleado_rep_ventas IN (11,30);

# MULTITABA (COMPOSICION INTERNA)

# 1) Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.
SELECT c.nombre_cliente,
	   e.nombre,e.apellido1,e.apellido2
FROM cliente c INNER JOIN empleado e
WHERE c.codigo_empleado_rep_ventas = e.codigo_empleado;

# 2) . Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de 
# sus representantes de ventas.
SELECT c.nombre_cliente, e.nombre, e.apellido1
FROM cliente c INNER JOIN empleado e
ON c.codigo_empleado_rep_ventas = e.codigo_empleado
INNER JOIN pago p
ON c.codigo_cliente = p.codigo_cliente
GROUP BY c.nombre_cliente;

# 3) Muestra el nombre de los clientes que no hayan realizado pagos junto con el
# nombre de sus representantes de ventas.
SELECT c.nombre_cliente, e.nombre, e.apellido1
FROM cliente c INNER JOIN empleado e
ON c.codigo_empleado_rep_ventas = e.codigo_empleado
LEFT JOIN pago p
ON c.codigo_cliente = p.codigo_cliente
WHERE p.codigo_cliente is null;

# 4) Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus
# representantes junto con la ciudad de la oficina a la que pertenece el representante.
SELECT c.nombre_cliente, e.nombre, e.apellido1, o.ciudad
FROM cliente c INNER JOIN empleado e
ON c.codigo_empleado_rep_ventas = e.codigo_empleado
INNER JOIN pago p
ON c.codigo_cliente = p.codigo_cliente
INNER JOIN oficina o
ON e.codigo_oficina = o.codigo_oficina
GROUP BY c.nombre_cliente;

# 5) Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus
# representantes junto con la ciudad de la oficina a la que pertenece el representante
SELECT c.nombre_cliente, e.nombre, e.apellido1, o.ciudad
FROM cliente c INNER JOIN empleado e
ON c.codigo_empleado_rep_ventas = e.codigo_empleado
LEFT JOIN pago p
ON c.codigo_cliente = p.codigo_cliente
INNER JOIN oficina o
ON e.codigo_oficina = o.codigo_oficina
WHERE p.codigo_cliente is null;

# 6) Lista la dirección de las oficinas que tengan clientes en Fuenlabrada
SELECT o.linea_direccion1
FROM oficina o INNER JOIN empleado e
ON o.codigo_oficina = e.codigo_oficina
INNER JOIN cliente c
ON e.codigo_empleado = c.codigo_empleado_rep_ventas
GROUP BY o.linea_direccion1;

# 7) Devuelve el nombre de los clientes y el nombre de sus representantes junto con la
# ciudad de la oficina a la que pertenece el representante.
SELECT c.nombre_cliente, e.nombre, e.apellido1, o.ciudad
FROM cliente c INNER JOIN empleado e
ON c.codigo_empleado_rep_ventas = e.codigo_empleado
INNER JOIN oficina o
ON e.codigo_oficina = o.codigo_oficina
GROUP BY c.nombre_cliente;

# 8) Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes
SELECT  (a.nombre + a.apellido1) AS empleado, b.nombre AS jefe FROM empleado a, empleado b
WHERE a.codigo_empleado = b.codigo_jefe;

# 9) Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.
SELECT c.nombre_cliente
FROM cliente c INNER JOIN pedido p
ON c.codigo_cliente = p.codigo_cliente
WHERE fecha_entrega > fecha_esperada;

# 10) Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.
SELECT c.nombre_cliente, pr.gama
FROM cliente c INNER JOIN pedido pe
ON c.codigo_cliente = pe.codigo_cliente
INNER JOIN detalle_pedido dp
ON pe.codigo_pedido = dp.codigo_pedido
INNER JOIN producto pr
ON dp.codigo_producto = pr.codigo_producto;

# CONSULTA MILTITABA (COMPOSICION EXTERNA)

# 1) Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
SELECT nombre_cliente 
FROM cliente c LEFT JOIN pago p
ON c.codigo_cliente = p.codigo_cliente
WHERE p.codigo_cliente is null;

# 2) Devuelve un listado que muestre solamente los clientes que no han realizado ningún pedido.
SELECT * FROM cliente c LEFT JOIN pedido p
ON c.codigo_cliente = p.codigo_cliente
WHERE p.codigo_cliente is null;

# 3) Devuelve un listado que muestre los clientes que no han realizado ningún pago y
# los que no han realizado ningún pedido.
SELECT * 
FROM cliente c LEFT JOIN pago pa
ON c.codigo_cliente = pa.codigo_cliente
LEFT JOIN pedido pe
ON c.codigo_cliente = pe.codigo_cliente
WHERE pa.codigo_cliente is null AND pe.codigo_cliente is null;

# 4) Devuelve un listado que muestre solamente los empleados que no tienen una oficina asociada.
SELECT * FROM empleado	e LEFT JOIN oficina o
ON e.codigo_oficina = o.codigo_oficina
WHERE e.codigo_oficina is null;

# 5) Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado.
SELECT * FROM empleado e LEFT JOIN cliente c
ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE c.codigo_empleado_rep_ventas is null;

# 6) Devuelve un listado que muestre los empleados que no tienen una oficina asociada
# y los que no tienen un cliente asociado
SELECT * FROM empleado e LEFT JOIN cliente c
ON e.codigo_empleado = c.codigo_empleado_rep_ventas
LEFT JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE c.codigo_empleado_rep_ventas is null AnD o.codigo_oficina is null;

# 7) Devuelve un listado de los productos que nunca han aparecido en un pedido.
SELECT * FROM producto p LEFT JOIN detalle_pedido d
ON p.codigo_producto = d.codigo_producto
WHERE d.codigo_producto is null;

# 8) Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido
# los representantes de ventas de algún cliente que haya realizado la compra de
# algún producto de la gama Frutales.
SELECT o.codigo_oficina FROM oficina o INNER JOIN empleado e
ON o.codigo_oficina = e.codigo_oficina
INNER JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
INNER JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
INNER JOIN detalle_pedido de ON p.codigo_pedido = de.codigo_pedido
LEFT JOIN  producto pr ON de.codigo_producto = pr.codigo_producto
WHERE pr.gama NOT LIKE 'Frutales'
GROUP BY o.codigo_oficina;

# 9) Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago.
SELECT * FROM cliente c LEFT JOIN pedido pe
ON c.codigo_cliente = pe.codigo_cliente
LEFT JOIN pago p ON pe.codigo_cliente = p.codigo_cliente
WHERE p.codigo_cliente is null
GROUP BY p.codigo_cliente;

# CONSULTAS RESUMEN

# 1) . ¿Cuántos empleados hay en la compañía?
SELECT COUNT(codigo_empleado) FROM empleado;

# 2) ¿Cuántos clientes tiene cada país?
SELECT pais, COUNT(pais) FROM CLIENTE GROUP BY pais;

# 3) ¿Cuál fue el pago medio en 2009?
SELECT AVG(total) FROM pago WHERE fecha_pago LIKE '2009%';

# 4) ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el número de pedidos.
SELECT estado,COUNT(estado) FROM pedido GROUP BY estado;

# 5) Calcula el precio de venta del producto más caro y más barato en una misma consulta.
SELECT MIN(precio_venta), MAX(precio_venta) FROM producto;

# 6) Calcula el número de clientes que tiene la empresa.
SELECT COUNT(codigo_cliente) FROM cliente;

# 7) ¿Cuántos clientes tiene la ciudad de Madrid?
SELECT COUNT(codigo_cliente) FROM cliente WHERE ciudad LIKE 'Madrid';

# 8) ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan por M?
SELECT ciudad, COUNT(codigo_cliente) FROM cliente WHERE ciudad LIKE 'M%' GROUP BY ciudad;

# 9) Devuelve el nombre de los representantes de ventas y el número de clientes al que atiende cada uno.
SELECT e.nombre, e.apellido1, COUNT(c.codigo_empleado_rep_ventas)
FROM empleado e INNER JOIN cliente c
ON e.codigo_empleado = c.codigo_empleado_rep_ventas
GROUP BY e.nombre;

# 10) Calcula el número de clientes que no tiene asignado representante de ventas.
SELECT COUNT(codigo_cliente) FROM cliente c WHERE c.codigo_empleado_rep_ventas is null;

# 11) Calcula la fecha del primer y último pago realizado por cada uno de los clientes. El
# listado deberá mostrar el nombre y los apellidos de cada cliente
SELECT c.nombre_contacto, c.apellido_contacto, MIN(p.fecha_pago), MAX(fecha_pago)
FROM cliente c, pago p
WHERE c.codigo_cliente = p.codigo_cliente
GROUP BY c.nombre_contacto;

# 12) Calcula el número de productos diferentes que hay en cada uno de los pedidos.
SELECT codigo_pedido, COUNT(codigo_producto) FROM detalle_pedido GROUP BY codigo_pedido;

# 13) Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de los pedidos
SELECT codigo_pedido, SUM(cantidad) FROM detalle_pedido GROUP BY codigo_pedido;

# 14) Devuelve un listado de los 20 productos más vendidos y el número total de
# unidades que se han vendido de cada uno. El listado deberá estar ordenado por el
# número total de unidades vendidas.
SELECT codigo_producto, SUM(cantidad) FROM detalle_pedido GROUP BY codigo_producto 
ORDER BY SUM(cantidad) DESC limit 20;

# SUBCONSULTAS CON OPERADORES BASICOS DE COMPARACION

# 1) Devuelve el nombre del cliente con mayor límite de crédito 
SELECT nombre_cliente FROM cliente WHERE limite_credito = (SELECT MAX(limite_credito) FROM cliente);

# 2) Devuelve el nombre del producto que tenga el precio de venta más caro.
SELECT nombre FROM producto WHERE precio_venta = (SELECT MAX(precio_venta) FROM producto);

# 3) Devuelve el nombre del producto del que se han vendido más unidades. (Tenga en
# cuenta que tendrá que calcular cuál es el número total de unidades que se han
# vendido de cada producto a partir de los datos de la tabla detalle_pedido. Una vez
# que sepa cuál es el código del producto, puede obtener su nombre fácilmente.)
SELECT p.nombre FROM producto p INNER JOIN detalle_pedido d
ON p.codigo_producto = d.codigo_producto
WHERE MAX(d.cantidad);

# 4) Los clientes cuyo límite de crédito sea mayor que los pagos que haya realizado. (Sin
# utilizar INNER JOIN).
SELECT c.nombre_cliente, c.limite_credito, p.total FROM cliente c, pago p 
WHERE c.codigo_cliente = p.codigo_cliente
AND c.limite_credito > p.total
GROUP BY c.codigo_cliente;

# 5) Devuelve el producto que más unidades tiene en stock.
SELECT * FROM producto WHERE cantidad_en_stock = (SELECT MAX(cantidad_en_stock) FROM producto);

# 6) Devuelve el producto que menos unidades tiene en stock.
SELECT * FROM producto WHERE cantidad_en_stock = (SELECT MIN(cantidad_en_stock) FROM producto);

# 7) Devuelve el nombre, los apellidos y el email de los empleados que están a cargo de Alberto Soria.
SELECT nombre, apellido1, email FROM empleado WHERE codigo_jefe = 2;

# SUBCONSULTAS CON ALL Y ANY

# 1) Devuelve el nombre del cliente con mayor límite de crédito.
SELECT * FROM cliente WHERE limite_credito > ALL (SELECT limite_credito from cliente);

# SUBCONSULTAS CON IN y NOT IN

# 1) Devuelve el nombre, apellido1 y cargo de los empleados que no representen a ningún cliente.
SELECT nombre, apellido1, codigo_empleado, puesto FROM empleado WHERE codigo_empleado 
NOT IN (SELECT codigo_empleado_rep_ventas FROM cliente);

# 2) Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
SELECT nombre_cliente FROM cliente WHERE codigo_cliente NOT IN (SELECT codigo_cliente FROM pago);

# 3) Devuelve un listado que muestre solamente los clientes que sí han realizado ningún pago.
SELECT nombre_cliente FROM cliente WHERE codigo_cliente IN (SELECT codigo_cliente FROM pago);

# 4) Devuelve un listado de los productos que nunca han aparecido en un pedido
SELECT nombre FROM producto WHERE codigo_producto NOT IN (SELECT codigo_producto FROM detalle_pedido);

# 5) Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos
# empleados que no sean representante de ventas de ningún cliente.
SELECT e.nombre, e.apellido1, e.puesto, o.telefono FROM empleado e, oficina o 
WHERE e.codigo_empleado NOT IN (SELECT codigo_empleado_rep_ventas FROM cliente)
GROUP BY e.nombre;

# SUBCONSULTAS CON EXISTS Y NO EXISTS

# 1) Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
SELECT * FROM cliente c WHERE NOT EXISTS (SELECT codigo_cliente FROM pago WHERE codigo_cliente=c.codigo_cliente);

# 2) Devuelve un listado que muestre solamente los clientes que sí han realizado ningún pago.
SELECT * FROM cliente c WHERE EXISTS (SELECT codigo_cliente FROM pago WHERE codigo_cliente=c.codigo_cliente);

# 3) Devuelve un listado de los productos que nunca han aparecido en un pedido.
SELECT * FROM producto p WHERE NOT EXISTS (SELECT codigo_producto FROM detalle_pedido
WHERE p.codigo_producto = codigo_producto);

# 4) . Devuelve un listado de los productos que han aparecido en un pedido alguna vez.
SELECT * FROM producto p WHERE EXISTS (SELECT codigo_producto FROM detalle_pedido
WHERE p.codigo_producto = codigo_producto);