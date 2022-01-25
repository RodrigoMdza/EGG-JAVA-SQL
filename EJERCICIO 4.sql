# EJERCICIO 4

# 1) Mostrar el nombre de todos los jugadores ordenados alfabéticamente
SELECT nombre FROM jugadores ORDER BY nombre;
 
# 2) Mostrar el nombre de los jugadores que sean pivots (‘C’) y que pesen más de 200
# libras, ordenados por nombre alfabéticamente.
SELECT * FROM jugadores
WHERE Posicion like 'C' AND Peso>200;
  
# 3) Mostrar el nombre de todos los equipos ordenados alfabéticamente.
SELECT Nombre FROM equipos ORDER BY nombre;
 
# 4) Mostrar el nombre de los equipos del este (East).
SELECT Nombre FROM equipos WHERE Conferencia LIKE 'East';

# 5) Mostrar los equipos donde su ciudad empieza con la letra ‘c’, ordenados por nombre
SELECT nombre FROM equipos WHERE nombre LIKE 'C%' ORDER BY nombre; 

# 6) Mostrar todos los jugadores y su equipo ordenados por nombre del equipo.
SELECT nombre, nombre_equipo FROM jugadores ORDER BY nombre_equipo;

# 7) Mostrar todos los jugadores del equipo “Raptors” ordenados por nombre.
SELECT nombre, nombre_equipo FROM jugadores WHERE Nombre_equipo LIKE 'Raptors' order by Nombre;

# 8) Mostrar los puntos por partido del jugador ‘Pau Gasol’
SELECT Puntos_por_partido, j.Nombre, e.temporada
FROM estadisticas e INNER JOIN jugadores j
ON e.jugador = j.codigo
WHERE j.Nombre LIKE 'PAU GASOL';

# 9) Mostrar los puntos por partido del jugador ‘Pau Gasol’ en la temporada ’04/05′
SELECT Puntos_por_partido, j.Nombre, e.temporada
FROM estadisticas e INNER JOIN jugadores j
ON e.jugador = j.codigo
WHERE j.Nombre LIKE 'PAU GASOL' AND e.temporada = '04/05';

# 10) Mostrar el número de puntos de cada jugador en toda su carrera. 
SELECT SUM(Puntos_por_partido), j.Nombre
FROM estadisticas e INNER JOIN jugadores j
ON e.jugador = j.codigo
GROUP BY j.Nombre;

# 11) Mostrar el número de jugadores de cada equipo
SELECT COUNT(nombre), Nombre_equipo FROM jugadores GROUP BY Nombre_equipo;

# 12) Mostrar el jugador que más puntos ha realizado en toda su carrera.
SELECT MAX(puntos_por_partido), jugador FROM estadisticas 
ORDER BY Puntos_por_partido DESC LIMIT 1;

# 13) Mostrar el nombre del equipo, conferencia y división del jugador más alto de la NBA.
SELECT e.Nombre, e.Conferencia, e.Division, MAX(j.Altura), j.Nombre
FROM equipos e INNER JOIN jugadores j
ON e.Nombre = j.Nombre_equipo
GROUP BY j.Altura
ORDER BY j.Altura DESC LIMIT 1;

# 14) Mostrar la media de puntos en partidos de los equipos de la división Pacific.
SELECT AVG(p.puntos_local), 
	   e.Division,
       e.Nombre
FROM partidos p INNER JOIN equipos e   
ON p.equipo_local = e.Nombre
WHERE e.Division like 'Pacific'
GROUP BY e.nombre;   

# 15) . Mostrar el partido o partidos (equipo_local, equipo_visitante y diferencia) con mayor diferencia de puntos.
SELECT equipo_local, equipo_visitante, MAX(puntos_local - puntos_visitante) AS 'DIFERENCIA PUNTOS' FROM partidos;

# 16) Mostrar la media de puntos en partidos de los equipos de la división Pacific.
SELECT AVG(p.puntos_visitante), 
	   e.Division,
       e.Nombre
FROM partidos p INNER JOIN equipos e   
ON p.equipo_local = e.Nombre
WHERE e.Division like 'Pacific'
GROUP BY e.nombre;   

# 17) Mostrar los puntos de cada equipo en los partidos, tanto de local como de visitante. 
SELECT equipo_local, SUM(puntos_local), SUM(puntos_visitante) FROM partidos
GROUP BY equipo_local;

# 18) Mostrar quien gana en cada partido (codigo, equipo_local, equipo_visitante,
# equipo_ganador), en caso de empate sera null.
SELECT codigo, equipo_local, equipo_visitante; 