use tropical;
-- borrar el sp
-- drop procedure spUpdateSaldosPromedioProductoSalida;
DELIMITER //
CREATE PROCEDURE `spUpdateSaldosPromedioProductoSalida`(
	IN mid char(36),
	IN ncantidad DECIMAL(10,0)
)
BEGIN
	DECLARE msaldocantidad  decimal(10,0) DEFAULT null;
    DECLARE msaldocosto  decimal(18,5) DEFAULT null;
    DECLARE mcostopromedio  decimal(18,5)DEFAULT null;
    --
	SELECT saldocantidad, costopromedio
	INTO msaldocantidad, mcostopromedio
	FROM producto
	WHERE id= mid;
	-- Calculo de saldos y promedio
	set msaldocantidad = msaldocantidad - ncantidad;
	set msaldocosto= mcostopromedio * msaldocantidad;
	--
	UPDATE producto
	SET saldocantidad=msaldocantidad, saldocosto=msaldocosto 
	WHERE id= mid; 
END//
DELIMITER ;