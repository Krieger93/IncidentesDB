CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_ordenarinc`(IN $columna VARCHAR(30), IN $orden VARCHAR(4))
BEGIN
    DECLARE order_by varchar(50);
    SET @order_by = CONCAT_WS(' ','`columna`', '`orden`');
    SELECT * FROM `incidentes` ORDER BY @order_by;
END
