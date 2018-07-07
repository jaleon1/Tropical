use tropical;
-- borrar el sp
-- drop procedure spUpdateSaldosPromedioInsumo;
-- drop procedure spUpdateSaldosPromedioArticulo;
DELIMITER //
CREATE PROCEDURE spUpdateSaldosPromedioInsumoEntrada(
	IN mid char(36),
	IN ncantidad DECIMAL(10,0),
    IN ncosto DECIMAL(20,10)
)
BEGIN
	DECLARE msaldocantidad  decimal(10,0) DEFAULT null;
    DECLARE msaldocosto  decimal(20,10) DEFAULT null;
    DECLARE mcostopromedio  decimal(20,10)DEFAULT null;
    --
	SELECT saldoCantidad, saldoCosto 
	INTO msaldocantidad, msaldocosto
	FROM insumos
	WHERE id= mid;
	-- Calculo de saldos y promedio
    IF msaldocantidad is not null THEN
		set msaldocantidad = msaldocantidad + ncantidad;
		set msaldocosto=  msaldocosto + ncosto;
		set mcostopromedio= msaldocosto / msaldocantidad;
		--
		UPDATE insumo
		SET saldoCantidad=msaldocantidad, saldoCosto=msaldocosto, costoPromedio = mcostopromedio
		WHERE id= mid;  
	ELSE 
		CALL spUpdateSaldosPromedioArticuloEntrada(mid, ncantidad, ncosto);
	END IF;
END; //
CREATE PROCEDURE spUpdateSaldosPromedioArticuloEntrada(
	IN mid char(36),
	IN ncantidad DECIMAL(10,0),
    IN ncosto DECIMAL(15,10)
)
BEGIN
	DECLARE msaldocantidad decimal(10,0) DEFAULT null;
    DECLARE msaldocosto  decimal(20,10) DEFAULT null;
    DECLARE mcostopromedio  decimal(20,10) DEFAULT null;
    --
	SELECT saldoCantidad, saldoCosto 
	INTO msaldocantidad, msaldocosto
	FROM producto
	WHERE id= mid;
	-- Calculo de saldos y promedio    
	set msaldocantidad = msaldocantidad + ncantidad;
	set msaldocosto=  msaldocosto + ncosto;
	set mcostopromedio= msaldocosto / msaldocantidad;
	--
	UPDATE producto
	SET saldoCantidad=msaldocantidad, saldoCosto=msaldocosto, costoPromedio = mcostopromedio
	WHERE id= mid;  
	
END; //
DELIMITER ;


-- Ejemplo de como llamar al sp
-- CALL spUpdateSaldosPromedioInsumo('554ddad3-74b6-11e8-abed-f2f00eda9788', 1, 100);
-- CALL spUpdateSaldosPromedioInsumo('7885f6f5-6f99-11e8-abed-f2f00eda9788', 3, 100);
