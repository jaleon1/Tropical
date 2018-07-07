use tropical;
-- borrar el sp
-- drop procedure spUpdateSaldosPromedioProductoSalida;
DELIMITER //
CREATE PROCEDURE spUpdateSaldosPromedioProductoSalida(
	IN mid char(36),
	IN ncantidad DECIMAL(10,0)
)
BEGIN
	DECLARE msaldocantidad  decimal(10,0) DEFAULT null;
    DECLARE msaldocosto  decimal(20,10) DEFAULT null;
    DECLARE mcostopromedio  decimal(20,10)DEFAULT null;
    --
	SELECT saldoCantidad, costoPromedio
	INTO msaldocantidad, mcostopromedio
	FROM producto
	WHERE id= mid;
	-- Calculo de saldos y promedio
	set msaldocantidad = msaldocantidad - ncantidad;
	set msaldocosto= mcostopromedio * msaldocantidad;
	--
	UPDATE producto
	SET saldoCantidad=msaldocantidad, saldoCosto=msaldocosto 
	WHERE id= mid; 
END; //
DELIMITER ;


-- Ejemplo de como llamar al sp
-- CALL spUpdateSaldosPromedioInsumo('554ddad3-74b6-11e8-abed-f2f00eda9788', 1, 100);
-- CALL spUpdateSaldosPromedioProductoSalida('3b31b046-75eb-11e8-abed-f2f00eda9788', 1000);
