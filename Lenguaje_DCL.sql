use mysql;

-- Creo el primer usuario
CREATE USER 'prueba'@'localhost' identified BY 'ejercicio1';

-- Creo el segundo usuario
CREATE USER 'prueba1'@'localhost' identified BY 'ejercicio2';


-- Agrego permisos solo de lectura al primer usuario
GRANT SELECT ON incidentes.* TO 'prueba'@'localhost';

-- Agrego permisos de lectura, inserción y modificación al segundo usuario
GRANT SELECT, INSERT, UPDATE ON incidentes.* TO 'prueba1'@'localhost';
