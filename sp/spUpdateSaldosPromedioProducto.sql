use tropical;
-- borrar el sp
-- drop procedure spUpdateSaldosPromedioProducto;
DELIMITER //
CREATE PROCEDURE `spUpdateSaldosPromedioProducto`(
	IN nidproducto char(36),
	IN ncantidad DECIMAL(18,5),
    IN ncosto DECIMAL(18,5)
)
BEGIN
	DECLARE msaldocantidad  decimal(18,5) DEFAULT null;
    DECLARE msaldocosto  decimal(18,5) DEFAULT null;
    DECLARE mcostopromedio  decimal(18,5)DEFAULT null;
	-- verifica si el producto se encuentra en el inventario.
	SELECT saldocantidad, costopromedio, saldocosto
	INTO msaldocantidad, mcostopromedio, msaldocosto
	FROM producto
	WHERE id= nidproducto;
	
	-- Calculo de saldos y promedio
	set msaldocantidad = msaldocantidad + ncantidad;
	set msaldocosto=  msaldocosto + ncosto;
	set mcostopromedio= msaldocosto / msaldocantidad;
	--
	UPDATE producto
	SET saldocantidad=msaldocantidad, saldocosto=msaldocosto, costopromedio = mcostopromedio
	WHERE id= nidproducto;
END//
DELIMITER ;