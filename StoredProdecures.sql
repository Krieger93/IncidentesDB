-- SP ejercicio 1
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ordenarinc`(IN $columna VARCHAR(30), IN $orden VARCHAR(4))
BEGIN
    DECLARE order_by varchar(50);
    SET @order_by = CONCAT_WS(' ','`columna`', '`orden`');
    SELECT * FROM `incidentes` ORDER BY @order_by;
END


--SP ejercicio 2 - actualiza estado de incidente
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_updateincestado`(IN i_id INT, IN i_estado varchar(25))
BEGIN
	UPDATE incidentes
    SET
    estado = i_estado WHERE id_incidente = i_id;
END
