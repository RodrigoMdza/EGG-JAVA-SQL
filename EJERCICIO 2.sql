# EJERCICIO 2

# 1) Obtener los datos completos de los empleados
SELECT * FROM personal.empleados;

# 2) Obtener los datos completos de los departamentos
SELECT * FROM personal.departamentos;

# 3) Listar el nombre de los departamentos.
SELECT nombre_depto FROM personal.departamentos;

# 4) Obtener el nombre y salario de todos los empleados.
SELECT nombre,sal_emp FROM empleados;

# 5) Listar todas las comisiones.
SELECT comision_emp FROM empleados;

# 6) Obtener los datos de los empleados cuyo cargo sea ‘Secretaria’
SELECT * FROM empleados WHERE cargo_emp='Secretaria';

# 7) Obtener los datos de los empleados vendedores, ordenados por nombre alfabéticamente.
SELECT * FROM empleados WHERE cargo_emp='Vendedor' ORDER BY nombre;

#8) Obtener el nombre y cargo de todos los empleados, ordenados por salario de menor a mayor.
SELECT nombre,cargo_emp FROM empleados ORDER BY sal_emp;

# 9) Elabore un listado donde para cada fila, figure el alias ‘Nombre’ y ‘Cargo’ para
# las respectivas tablas de empleados
SELECT nombre AS 'NOMBRE', cargo_emp AS 'CARGO' FROM empleados;

# 10) Listar los salarios y comisiones de los empleados del departamento 2000, ordenado por 
# comisión de menor a mayor
SELECT sal_emp,comision_emp FROM empleados WHERE id_depto=2000;

# 11) Obtener el valor total a pagar que resulta de sumar el salario y la comisión de los
# empleados del departamento 3000 una bonificación de 500, en orden alfabético del empleado
SELECT nombre, sal_emp + comision_emp +500 AS 'salariototal' FROM empleados WHERE id_depto=3000 ORDER BY nombre;

# 12) Muestra los empleados cuyo nombre empiece con la letra J.
SELECT nombre FROM empleados WHERE nombre LIKE 'j%';

# 13) . Listar el salario, la comisión, el salario total (salario + comisión) y nombre, de
# aquellos empleados que tienen comisión superior a 1000.
SELECT nombre, sal_emp as 'salario', comision_emp AS 'comision', sal_emp + comision_emp AS 'salariototal' FROM empleados WHERE comision_emp>1000;

# 14) Obtener un listado similar al anterior, pero de aquellos empleados que NO tienen comisión.
SELECT nombre, sal_emp as 'salario', comision_emp AS 'comision', sal_emp + comision_emp AS 'salariototal' FROM empleados WHERE comision_emp=0;

# 15) Obtener la lista de los empleados que ganan una comisión superior a su sueldo.
SELECT * FROM empleados WHERE comision_emp>sal_emp;

# 16) Listar los empleados cuya comisión es menor o igual que el 30% de su sueldo.
SELECT * FROM empleados WHERE comision_emp<=(sal_emp*30/100);

# 17) Hallar los empleados cuyo nombre no contiene la cadena “MA”
SELECT * FROM empleados WHERE nombre NOT LIKE '%MA%';

# 18) Obtener los nombres de los departamentos que sean “Ventas” ni “Investigación” ni ‘Mantenimiento
SELECT nombre_depto FROM departamentos WHERE nombre_depto IN ('Ventas','Investigacion','Mantenimiento');

# 19) Ahora obtener los nombres de los departamentos que no sean “Ventas” ni “Investigación” ni ‘Mantenimiento
SELECT nombre_depto FROM departamentos WHERE nombre_depto NOT IN ('Ventas','Investigacion','Mantenimiento');

# 20) Mostrar el salario más alto de la empresa
SELECT * FROM empleados WHERE sal_emp = (SELECT max(sal_emp) FROM empleados);

# 21) Mostrar el nombre del último empleado de la lista por orden alfabético.
SELECT nombre FROM empleados ORDER BY nombre desc LIMIT 1;

# 22) Hallar el salario más alto, el más bajo y la diferencia entre ellos.
SELECT Max(sal_emp), Min(sal_emp), Max(sal_emp) - Min(sal_emp) AS 'DIFERENCIASALARIOS' FROM empleados;

# 23) Hallar el salario promedio por departamento.
SELECT avg(sal_emp) , d.nombre_depto
FROM empleados e, departamentos d
WHERE e.id_depto = d.id_depto
GROUP BY d.nombre_depto;

# 24) Hallar los departamentos que tienen más de tres empleados. Mostrar el número
# de empleados de esos departamentos.
SELECT COUNT(d.id_depto), d.nombre_depto
FROM departamentos d, empleados e
WHERE e.id_depto = d.id_depto
group by d.nombre_depto
HAVING COUNT(d.id_depto)>2;

# 25) Mostrar el código y nombre de cada jefe, junto al número de empleados que
# dirige. Solo los que tengan más de dos empleados (2 incluido).
select e.cod_jefe, e.nombre, count(*) as 'Numero de Empleados' 
from empleados e, departamentos d 
where e.id_depto = d.id_depto
group by e.cod_jefe
having count(*) >=2;

# 26) Hallar los departamentos que no tienen empleados
SELECT nombre_depto, COUNT(e.id_depto)
FROM departamentos d, empleados e
WHERE e.id_depto = d.id_depto
HAVING COUNT(e.id_depto)=0;

# 27) . Mostrar la lista de los empleados cuyo salario es mayor o igual que el promedio
# de la empresa. Ordenarlo por departamento.
SELECT AVG(sal_emp) FROM empleados;
SELECT * FROM empleados 
WHERE sal_emp > (SELECT AVG (sal_emp) FROM empleados);