use tropical;
-- borrar el sp
-- drop procedure spUpdateSaldosPromedioArticuloEntrada;
DELIMITER //
CREATE PROCEDURE `spUpdateSaldosPromedioArticuloEntrada`(
	IN mid char(36),
	IN ncantidad DECIMAL(10,0),
    IN ncosto DECIMAL(18,5)
)
BEGIN
	DECLARE msaldocantidad decimal(10,0) DEFAULT null;
    DECLARE msaldocosto  decimal(18,5) DEFAULT null;
    DECLARE mcostopromedio  decimal(18,5) DEFAULT null;
    --
	SELECT saldocantidad, saldocosto 
	INTO msaldocantidad, msaldocosto
	FROM producto
	WHERE id= mid;
	-- Calculo de saldos y promedio    
	set msaldocantidad = msaldocantidad + ncantidad;
	set msaldocosto=  msaldocosto + ncosto;
	set mcostopromedio= msaldocosto / msaldocantidad;
	--
	UPDATE producto
	SET saldocantidad=msaldocantidad, saldocosto=msaldocosto, costopromedio = mcostopromedio
	WHERE id= mid;  
	
END//
DELIMITER ;