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
