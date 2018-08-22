use tropical;
-- borrar el sp
-- drop procedure spUpdateSaldosPromedioInsumoEntrada;
DELIMITER //
CREATE PROCEDURE `spUpdateSaldosPromedioInsumoEntrada`(
	IN mid char(36),
	IN ncantidad DECIMAL(10,0),
    IN ncosto DECIMAL(18,5)
)
BEGIN
	DECLARE msaldocantidad  decimal(10,0) DEFAULT null;
    DECLARE msaldocosto  decimal(18,5) DEFAULT 0;
    DECLARE mcostopromedio  decimal(18,5)DEFAULT 0;
    --
	SELECT saldocantidad, saldocosto 
	INTO msaldocantidad, msaldocosto
	FROM insumo
	WHERE id= mid;
	-- Calculo de saldos y promedio
    IF msaldocantidad is not null THEN
		set msaldocantidad = msaldocantidad + ncantidad;
		set msaldocosto=  msaldocosto + ncosto;
		set mcostopromedio= msaldocosto / msaldocantidad;
		--
		UPDATE insumo
		SET saldocantidad=msaldocantidad, saldocosto=msaldocosto, costopromedio = mcostopromedio
		WHERE id= mid;  
	ELSE 
		CALL spUpdateSaldosPromedioArticuloEntrada(mid, ncantidad, ncosto);
	END IF;
END//
DELIMITER ;