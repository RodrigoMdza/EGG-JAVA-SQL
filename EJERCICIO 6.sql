# EJERCICIO 6

# 1) Mostrar el nombre de todos los pokemon.
SELECT nombre FROM pokemon;

# 2) Mostrar los pokemon que pesen menos de 10k.
SELECT * FROM pokemon WHERE peso<10;

# 3) Mostrar los pokemon de tipo agua.
SELECT po.nombre FROM pokemon po INNER JOIN pokemon_tipo ti
ON po.numero_pokedex = ti.numero_pokedex
INNER JOIN tipo tip 
ON ti.id_tipo = tip.id_tipo
WHERE tip.nombre LIKE 'Agua';

# 4) Mostrar los pokemon de tipo agua, fuego o tierra ordenados por tipo.
SELECT po.nombre, tip.nombre FROM pokemon po INNER JOIN pokemon_tipo ti
ON po.numero_pokedex = ti.numero_pokedex
INNER JOIN tipo tip 
ON ti.id_tipo = tip.id_tipo
WHERE tip.nombre LIKE 'Agua' OR tip.nombre LIKE 'Fuego' OR tip.nombre LIKE 'Tierra'
ORDER BY tip.nombre;

# 5) Mostrar los pokemon que son de tipo fuego y volador
SELECT po.nombre, tip.nombre FROM pokemon po INNER JOIN pokemon_tipo ti
ON po.numero_pokedex = ti.numero_pokedex
INNER JOIN tipo tip 
ON ti.id_tipo = tip.id_tipo
WHERE tip.nombre LIKE 'Fuego' OR tip.nombre LIKE 'Volador'
ORDER BY tip.nombre;

# 6) Mostrar los pokemon con una estadística base de ps mayor que 200.
SELECT p.nombre FROM pokemon p INNER JOIN estadisticas_base es
ON p.numero_pokedex = es.numero_pokedex
WHERE es.ps>200;

 # 7) Mostrar los datos (nombre, peso, altura) de la prevolución de Arbok.
SELECT * from pokemon p INNER JOIN evoluciona_de e
On p.numero_pokedex = e.pokemon_evolucionado
WHERE p.nombre LIKE 'Arbok';

# 8) Mostrar aquellos pokemon que evolucionan por intercambio.
SELECT * FROM pokemon p INNER JOIN pokemon_forma_evolucion po
ON p.numero_pokedex = po.numero_pokedex
INNER JOIN forma_evolucion fo ON po.id_forma_evolucion = fo.id_forma_evolucion
INNER JOIN tipo_evolucion ti ON fo.tipo_evolucion = ti.id_tipo_evolucion
WHERE ti.tipo_evolucion LIKE 'Intercambio';

# 9) Mostrar el nombre del movimiento con más prioridad.
SELECT nombre FROM movimiento WHERE prioridad = (SELECT MAX(prioridad) FROM movimiento);

# 10) Mostrar el pokemon más pesado.
SELECT * FROM pokemon WHERE peso = (SELECT MAX(peso) FROM pokemon);

# 11) Mostrar el nombre y tipo del ataque con más potencia.
SELECT m.nombre, t.nombre FROM movimiento m INNER JOIN tipo t
ON m.id_tipo = t.id_tipo
ORDER BY m.potencia DESC LIMIT 1;

# 12) . Mostrar el número de movimientos de cada tipo.
SELECT COUNT(id_movimiento), id_tipo FROM movimiento GROUP BY id_tipo;

# 13) Mostrar todos los movimientos que puedan envenenar.
SELECT nombre FROM movimiento WHERE descripcion LIKE '%envenena%';

# 14) . Mostrar todos los movimientos que causan daño, ordenados alfabéticamente por nombre.
SELECT nombre FROM movimiento WHERE descripcion LIKE '%daño%' ORDER BY nombre;

# 15)
