-- SP ejercicio 1 lista por columna y orden
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ordenarinc`(IN campo VARCHAR(30), IN orden VARCHAR(4))
BEGIN
	--    DECLARE clausula varchar(50);
    DECLARE clausula varchar(50);
	-- @clausula ES LA CLAUSULA FINAL A EJECUTAR, EN LA QUE SE ENCADENAN LA SENTENCIA SQL Y LAS VARIABLES
    SET @clausula = concat('SELECT * FROM incidentes ORDER BY ', campo , ' ', orden);
    -- SE PREPARA, EJECUTA Y CIERRA LA SENTENCIA
    PREPARE ejecutar FROM @clausula;
    EXECUTE ejecutar;
    DEALLOCATE PREPARE ejecutar;
END

--SP ejercicio 2 - actualiza estado de incidente
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_updateincestado`(IN i_id INT, IN i_estado varchar(25))
BEGIN
	UPDATE incidentes
    SET
    estado = i_estado WHERE id_incidente = i_id;
END
