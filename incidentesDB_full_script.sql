-- CREACION DE BASE DE DATOS Y PUESTA EN USO
CREATE DATABASE incidentesDB;
USE incidentesDB;

-- CREACION DE TABLAS
CREATE TABLE Categorias(
id_categoria INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
titulo_categoria VARCHAR(50) NOT NULL
);

CREATE TABLE Grupos(
id_grupo INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
nombre_grupo VARCHAR(30) NOT NULL,
descripcion_grupo VARCHAR(50) NOT NULL
);

CREATE TABLE Usuarios(
id_user INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
user VARCHAR(50) NOT NULL,
pass_user VARCHAR(25) NOT NULL,
mail_user VARCHAR(50) NOT NULL,
nivel_user INT NOT NULL,
id_grupo INT NOT NULL,
FOREIGN KEY (id_grupo) REFERENCES Grupos(id_grupo)
);

CREATE TABLE Incidentes(
id_incidente INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
titulo_incidente VARCHAR(50) NOT NULL,
descripcion VARCHAR(50) NOT NULL,
id_owner INT NOT NULL,
id_asignatario INT NOT NULL,
id_kpi INT NOT NULL,
id_categoria INT NOT NULL,
fecha_creacion DATE NOT NULL,
fecha_cierre DATE NOT NULL,
estado VARCHAR(25)
);

CREATE TABLE KPIS(
id_kpi INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
id_incidente INT NOT NULL,
tiempo_resolucion INT,
puntaje_usuario INT
);

-- AGREGADO DE FOREING KEYS
ALTER TABLE Incidentes
ADD FOREIGN KEY (id_categoria) REFERENCES Categorias(id_categoria),
ADD FOREIGN KEY (id_kpi) REFERENCES KPIS(id_kpi),
ADD FOREIGN KEY (id_owner) REFERENCES Usuarios(id_user),
ADD FOREIGN KEY (id_asignatario) REFERENCES Usuarios(id_user);

-- CARGA DE DATOS

INSERT INTO Categorias(titulo_categoria)
VALUES
	('WINDOWS'),
	('LINUX'),
    ('BASE DE DATOS');

INSERT INTO Grupos(nombre_grupo, descripcion_grupo)
VALUES
	('DevOps', 'DevOps'),
    ('DBA', 'SQL Administrators'),
    ('Networking', 'Related to networks'),
    ('Customers', 'Normal users' );
    
INSERT INTO usuarios(user, pass_user, mail_user, nivel_user, id_grupo)
VALUES
	('gjejer', '864315', 'gjjejer@gmail.com', '0', '2'),
    ('ndiem', '357519', 'ndiem@gmail.com', '1', '3'),
    ('dhermann', '568152', 'dhermann@gmail.com', '1', '1'),
    ('normaluser', '123456', 'normaluser@gmail.com', '2', '4');


INSERT INTO kpis(id_incidente, puntaje_usuario, tiempo_resolucion)
VALUES
	('1','5', '8'),
    ('2','2','9'),
    ('3','3','10');


INSERT INTO incidentes(titulo_incidente, descripcion, id_owner, id_asignatario, id_kpi, id_categoria, fecha_creacion, fecha_cierre, estado)
VALUES
	('Linux VM falla', 'La VM no responde', '4', '3', '1', '2', '2022-01-09', '2022-01-10', 'Validation'),
	('Windows VM falla', 'Servicios fallando', '4', '2', '2', '1', '2021-12-21', '2021-12-27', 'Solved'),
	('Replicar DB a PROD', 'Pase a PROD de BD', '1', '1', '3', '3', '2022-01-05', '2022-01-05', 'Solved');
    
    
-- CREACION DE VISTAS
CREATE VIEW KPIBajaPuntuacion AS SELECT puntaje_usuario FROM kpis WHERE puntaje_usuario < 6;
CREATE VIEW TicketsSinResolver AS SELECT titulo_incidente, descripcion, estado FROM incidentes WHERE estado <> "Solved";
CREATE VIEW ContarUsuariosPorGrupos AS SELECT g.nombre_grupo, g.id_grupo,(SELECT COUNT(*) FROM usuarios WHERE id_grupo = g.id_grupo) UsuariosxGrupo FROM grupos g;
CREATE VIEW ContarTicketsPorCategorias AS SELECT c.id_categoria, c.titulo_categoria, (SELECT COUNT(*) FROM incidentes WHERE id_categoria = c.id_categoria) TicketsxCategoria FROM categorias c;
CREATE VIEW TicketsPorUserAsignado AS SELECT i.titulo_incidente, i.descripcion, i.estado, u.id_user, u.user FROM incidentes i INNER JOIN usuarios u ON i.id_owner = u.id_user;

-- tabla que contendra los datos ORIGINALES de los incidentes apenas son creados
CREATE TABLE bkpincidentes(
	id_incidente INT PRIMARY KEY,
    fecha_creacion DATE,
    fecha_cierre DATE,
    estado VARCHAR(20),
    id_owner INT,
    id_asignatario INT
);

-- tabla para almacenar los usuarios que se eliminan
CREATE TABLE  bkpusers(
	id_user INT PRIMARY KEY,
    user VARCHAR(50),
    pass_user VARCHAR(25),
    nivel_user INT,
    id_grupo INT
);

-- Creamos el trigger para que se guarde el valor original de un nuevo incidente dentro de la tabla BKPINCIDENTES
CREATE TRIGGER bkpincidentes
BEFORE INSERT ON incidentes
FOR EACH ROW
INSERT INTO bkpincidentes(id_incidente, fecha_creacion, fecha_cierre, estado, id_owner, id_asignatario)
VALUES(NEW.id_incidente, NEW.fecha_creacion, NEW.fecha_cierre, NEW.estado, NEW.id_owner, NEW.id_asignatario)
;

-- Creamos trigger para guardar los datos del usuario previo a su eliminacion
CREATE TRIGGER bkpusers
AFTER DELETE ON usuarios
FOR EACH ROW
INSERT INTO bkpusers(id_user, user, pass_user, nivel_user, id_grupo)
VALUES(OLD.id_user, OLD.user, OLD.pass_user, OLD.nivel_user, OLD.id_grupo);

-- TEST del trigger
INSERT INTO incidentes(titulo_incidente, descripcion, id_owner, id_asignatario, id_kpi, id_categoria, fecha_creacion, fecha_cierre, estado)
values('probando trigger', 'probando si se copia a tabla de bkp', 1, 2, 3, 1, '2022-01-12', '2022-01-20', 'Nuevo');

-- Agregamos un nuevo usuario a borrar
INSERT INTO usuarios(user, pass_user, mail_user, nivel_user, id_grupo)
values('testinguser', 'qpwoejq', 'opqwe@gmail.com', 3, 4);

-- Quitamos la configuracion de seguridad que por defecto viene e impide eliminar valores de las tablas
SET SQL_SAFE_UPDATES = 0;


-- TEST del trigger
delete from usuarios
where nivel_user = 3;


-- CREANDO FUNCIONES

DELIMITER $$
CREATE FUNCTION `UserLevel` (PARAM1 INT) RETURNS VARCHAR(20)
NO SQL
BEGIN
	DECLARE resultado VARCHAR(20);
    IF PARAM1 > 0 THEN
		SET resultado = 'NO ES ADMIN';
	ELSEIF PARAM1 = 0 THEN
		SET resultado = 'ES ADMIN';
	END IF;
    RETURN resultado;
END$$
DELIMITER ;


DELIMITER $$
CREATE FUNCTION `PromedioKPI` () RETURNS FLOAT
READS SQL DATA
BEGIN
    RETURN (
    SELECT AVG(kpis.puntaje_usuario) AS CONTANDO FROM kpis
    );
END$$
DELIMITER ;


-- CREACION DE SP's
-- SP ejercicio 1 lista por columna y orden

DELIMITER //
CREATE PROCEDURE `SP_ordenarinc`(IN campo VARCHAR(30), IN orden VARCHAR(4))
BEGIN
	--  DECLARE clausula varchar(50);
    DECLARE clausula varchar(50);
	-- @clausula ES LA CLAUSULA FINAL A EJECUTAR, EN LA QUE SE ENCADENAN LA SENTENCIA SQL Y LAS VARIABLES
    SET @clausula = concat('SELECT * FROM incidentes ORDER BY ', campo , ' ', orden);
    -- SE PREPARA, EJECUTA Y CIERRA LA SENTENCIA
    PREPARE ejecutar FROM @clausula;
    EXECUTE ejecutar;
    DEALLOCATE PREPARE ejecutar;
END //
DELIMITER ;


-- SP ejercicio 2 - actualiza estado de incidente

DELIMITER //
CREATE PROCEDURE `SP_updateincestado`(IN i_id INT, IN i_estado varchar(25))
BEGIN
	UPDATE incidentes
    SET
    estado = i_estado WHERE id_incidente = i_id;
END //
DELIMITER ;

-- TRANSACCIONES TCL

SELECT @@AUTOCOMMIT;
SET @@AUTOCOMMIT = 1;

-- Primera transaccion elimina grupo con ID mayor a 1
START TRANSACTION;
DELETE FROM grupos
WHERE id_grupo > 1;
-- ROLLBACK;
-- COMMIT;


-- Segunda transaccion inserta nuevas categorias y establece savepoint's
START TRANSACTION;
INSERT INTO categorias(titulo_categoria) VALUES('SEGURIDAD');
INSERT INTO categorias(titulo_categoria) VALUES('SOPORTE EN SITIO');
INSERT INTO categorias(titulo_categoria) VALUES('TELEFONIA MOVIL');
INSERT INTO categorias(titulo_categoria) VALUES('SISTEMA MATTT');
SAVEPOINT primeras_4;
INSERT INTO categorias(titulo_categoria) VALUES('VPN');
INSERT INTO categorias(titulo_categoria) VALUES('REDES');
INSERT INTO categorias(titulo_categoria) VALUES('AZURE');
INSERT INTO categorias(titulo_categoria) VALUES('GCP');
SAVEPOINT ultimas_4;
RELEASE primeras_4;

-- TRANSACCIONES DCL
-- Utilizamos la BD mysql
use mysql;

-- Creo el primer usuario
CREATE USER 'prueba'@'localhost' identified BY 'ejercicio1';

-- Creo el segundo usuario
CREATE USER 'prueba1'@'localhost' identified BY 'ejercicio2';


-- Agrego permisos solo de lectura al primer usuario
GRANT SELECT ON incidentes.* TO 'prueba'@'localhost';

-- Agrego permisos de lectura, inserción y modificación al segundo usuario
GRANT SELECT, INSERT, UPDATE ON incidentes.* TO 'prueba1'@'localhost';
