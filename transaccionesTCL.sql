SELECT @@AUTOCOMMIT;
SET @@AUTOCOMMIT = 1;

--Primera transaccion elimina grupo con ID mayor a 1
START TRANSACTION;
DELETE FROM grupos
WHERE id_grupo > 1;
-- ROLLBACK;
-- COMMIT;


--Segunda transaccion inserta nuevas categorias y establece savepoint's
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
