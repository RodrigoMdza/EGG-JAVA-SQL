# EJERCICIO 1

# A) Crear las tablas.
SELECT * FROM superheroes.creador;
INSERT INTO superheroes.creador VALUES (2,'DC Comics');
INSERT INTO superheroes.personajes VALUES (1,'Bruce Banner','Hulk',160,'600 mil',75,98,1962,'Fisico Nuclear',1);
DELETE FROM superheroes.personajes where id_personaje=2;
INSERT INTO superheroes.personajes values (2,'Barry Allen','Flash',160,'10 mil',120,168,1956,'Cientifico Forense',2);
SELECT * FROM superheroes.personajes;

# B) Cambiar en la tabla personajes el año de aparición a 1938 del personaje Superman.
# A continuación, realizar un listado de toda la tabla para verificar que el personaje haya sido actualizado.
UPDATE superheroes.personajes 
SET aparicion='1938'
WHERE id_personaje=3;
SELECT * FROM superheroes.personajes;

# C) Eliminar el registro que contiene al personaje Flash. A continuación, mostrar toda la tabla
# para verificar que el registro haya sido eliminado.
DELETE FROM superheroes.personajes
WHERE id_personaje=2;

# D) Eliminar la base de datos superhéroes.
DROP schema superheroes; 