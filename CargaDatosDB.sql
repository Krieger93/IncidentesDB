SELECT *
FROM Categorias;

INSERT INTO Categorias(titulo_categoria)
VALUES
	('WINDOWS'),
	('LINUX'),
    ('BASE DE DATOS');

SELECT *
FROM Grupos;

INSERT INTO Grupos(nombre_grupo, descripcion_grupo)
VALUES
	('DevOps', 'DevOps'),
    ('DBA', 'SQL Administrators'),
    ('Networking', 'Related to networks'),
    ('Customers', 'Normal users' );
    
SELECT *
FROM usuarios;

INSERT INTO usuarios(user, pass_user, mail_user, nivel_user, id_grupo)
VALUES
	('gjejer', '864315', 'gjjejer@gmail.com', '0', '2'),
    ('ndiem', '357519', 'ndiem@gmail.com', '1', '3'),
    ('dhermann', '568152', 'dhermann@gmail.com', '1', '1'),
    ('normaluser', '123456', 'normaluser@gmail.com', '2', '4');


SELECT *
FROM kpis;


INSERT INTO kpis(id_incidente, puntaje_usuario, tiempo_resolucion)
VALUES
	('1','5', '8'),
    ('2','2','9'),
    ('3','3','10');

SELECT *
FROM incidentes;

INSERT INTO incidentes(titulo_incidente, descripcion, id_owner, id_asignatario, id_kpi, id_categoria, fecha_creacion, fecha_cierre, estado)
VALUES
	('Linux VM falla', 'La VM no responde', '4', '3', '1', '2', '2022-01-09', '2022-01-10', 'Validation'),
	('Windows VM falla', 'Servicios fallando', '4', '2', '2', '1', '2021-12-21', '2021-12-27', 'Solved'),
	('Replicar DB a PROD', 'Pase a PROD de BD', '1', '1', '3', '3', '2022-01-05', '2022-01-05', 'Solved');
