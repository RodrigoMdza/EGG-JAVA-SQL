# EJERCICIO 3

# 1) . Lista el nombre de todos los productos que hay en la tabla producto.
SELECT nombre FROM producto;

# 2) Lista los nombres y los precios de todos los productos de la tabla producto
SELECT nombre,precio FROM producto;

# 3) Lista todas las columnas de la tabla producto.
SELECT * FROM producto;

# 4) Lista los nombres y los precios de todos los productos de la tabla producto, redondeando el valor del precio.
SELECT nombre, ROUND(precio) FROM producto;

# 5) Lista el código de los fabricantes que tienen productos en la tabla producto
SELECT f.codigo, codigo_fabricante
FROM fabricante f,producto p 
WHERE f.codigo = p.codigo_fabricante;

# 6) Lista el código de los fabricantes que tienen productos en la tabla producto, sin
# mostrar los repetidos.
SELECT f.codigo, codigo_fabricante
FROM fabricante f,producto p 
WHERE f.codigo = p.codigo_fabricante
GROUP BY codigo_fabricante;

# 7) Lista los nombres de los fabricantes ordenados de forma ascendente.
SELECT nombre FROM fabricante ORDER BY nombre;

# 8) Lista los nombres de los productos ordenados en primer lugar por el nombre de
# forma ascendente y en segundo lugar por el precio de forma descendente.
SELECT nombre FROM producto ORDER BY nombre;
SELECT nombre,precio FROM producto ORDER BY precio DESC;

# 9) Devuelve una lista con las 5 primeras filas de la tabla fabricante.
SELECT * FROM fabricante LIMIT 5;

# 10) Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas
# ORDER BY y LIMIT)
SELECT nombre,precio FROM producto ORDER BY precio LIMIT 1;

# 11) Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas ORDER BY y LIMIT)
SELECT nombre,precio FROM producto ORDER BY precio DESC LIMIT 1;

# 12) Lista el nombre de los productos que tienen un precio menor o igual a $120.
SELECT * FROM producto WHERE precio<=120;

# 13) Lista todos los productos que tengan un precio entre $60 y $200. Utilizando el operador BETWEEN.
SELECT * FROM producto WHERE precio BETWEEN 60 AND 120;

# 14) . Lista todos los productos donde el código de fabricante sea 1, 3 o 5. Utilizando el operador IN.
SELECT * FROM producto WHERE codigo_fabricante IN (1,3,5);

# 15) . Devuelve una lista con el nombre de todos los productos que contienen la cadena Portátil en el nombre.
SELECT * FROM producto WHERE nombre LIKE '%Portátil%';

# CONSULTAS MULTITABLAS

# 1) Devuelve una lista con el código del producto, nombre del producto, código del
# fabricante y nombre del fabricante, de todos los productos de la base de datos.
# PRIMERA ALTERNATIVA CON WHERE Y SEGUNDA CON INNER JOIN
SELECT p.codigo, p.nombre, p.codigo_fabricante,f.nombre
FROM fabricante f, producto p
WHERE f.codigo = p.codigo_fabricante;

SELECT p.codigo, p.nombre, p.codigo_fabricante,f.nombre
FROM fabricante f INNER JOIN producto p
ON f.codigo = p.codigo_fabricante;

# 2) Devuelve una lista con el nombre del producto, precio y nombre de fabricante de
# todos los productos de la base de datos. Ordene el resultado por el nombre del
# fabricante, por orden alfabético.
SELECT p.nombre, p.precio, p.codigo_fabricante,f.nombre
FROM fabricante f, producto p
WHERE f.codigo = p.codigo_fabricante
ORDER BY f.nombre;

# 3) Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato. 
SELECT p.nombre, min(p.precio), f.nombre
FROM fabricante f INNER JOIN producto p
ON f.codigo = p.codigo_fabricante;

# 4) Devuelve una lista de todos los productos del fabricante Lenovo.
SELECT * 
FROM fabricante f INNER JOIN producto p
ON f.codigo = p.codigo_fabricante
WHERE f.nombre LIKE 'Lenovo';

# 5) Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que $200.
SELECT * 
FROM fabricante f INNER JOIN producto p
ON f.codigo = p.codigo_fabricante
WHERE f.nombre LIKE 'Crucial' AND precio>200;

# 6) Devuelve un listado con todos los productos de los fabricantes Asus, HewlettPackard. Utilizando el 
# operador IN
SELECT * 
FROM fabricante f INNER JOIN producto p
ON f.codigo = p.codigo_fabricante
WHERE f.nombre IN ('Asus','Hewlett-Packard');

# 7) Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de
# todos los productos que tengan un precio mayor o igual a $180. Ordene el resultado
# en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente)
SELECT p.nombre, p.precio, f.nombre
FROM fabricante f INNER JOIN producto p
ON f.codigo = p.codigo_fabricante
WHERE p.precio>180
ORDER BY p.precio DESC;

SELECT p.nombre, p.precio, f.nombre
FROM fabricante f INNER JOIN producto p
ON f.codigo = p.codigo_fabricante
WHERE p.precio>180
ORDER BY p.nombre;

# 8) Devuelve un listado de todos los fabricantes que existen en la base de datos, junto
# con los productos que tiene cada uno de ellos. El listado deberá mostrar también
# aquellos fabricantes que no tienen productos asociados.
SELECT f.codigo, f.nombre, p.nombre
FROM fabricante f LEFT JOIN producto p
ON f.codigo = p.codigo_fabricante;

# 9) Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen ningún producto asociado.
SELECT f.codigo, f.nombre, p.nombre
FROM fabricante f LEFT JOIN producto p
ON f.codigo = p.codigo_fabricante
WHERE f.codigo > 7;

# SUBCONSULTAS
# 1) Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN).
SELECT *
FROM producto 
WHERE codigo_fabricante LIKE (SELECT codigo_fabricante FROM producto WHERE codigo_fabricante=2 group by codigo_fabricante);

# CON EL INNER JOIN
SELECT f.nombre, p.nombre
FROM fabricante f INNER JOIN producto p
ON f.codigo = p.codigo_fabricante
WHERE f.nombre LIKE 'Lenovo';

# 2) Devuelve todos los datos de los productos que tienen el mismo precio que el
# producto más caro del fabricante Lenovo. (Sin utilizar INNER JOIN).
SELECT * 
FROM producto
WHERE precio = (SELECT precio FROM producto WHERE codigo_fabricante=2 ORDER BY precio DESC LIMIT 1);

# 3) Lista el nombre del producto más caro del fabricante Lenovo.
SELECT nombre
FROM producto
WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre LIKE 'Lenovo')
ORDER BY precio DESC LIMIT 1;

# 4) Lista todos los productos del fabricante Asus que tienen un precio superior al precio
# medio de todos sus productos
SELECT * FROM producto
WHERE codigo_fabricante=1
AND precio > (SELECT AVG(precio) from producto WHERE codigo_fabricante=1);

# 5) Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando IN o NOT IN).
SELECT nombre FROM fabricante
WHERE codigo IN (SELECT codigo_fabricante FROM producto); 

# 6) Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando IN o NOT IN).
SELECT nombre FROM fabricante
WHERE codigo NOT IN (SELECT codigo_fabricante FROM producto); 

# 7) . Devuelve un listado con todos los nombres de los fabricantes que tienen el mismo
# número de productos que el fabricante Lenovo.
SELECT f.nombre, COUNT(p.codigo_fabricante) 
FROM fabricante f, producto p
GROUP BY p.codigo_fabricante
HAVING COUNT(p.codigo_fabricante)>1;