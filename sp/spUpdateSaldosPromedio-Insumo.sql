use tropical;
-- borrar el sp
-- drop procedure spUpdateSaldosPromedioInsumo;
-- drop procedure spUpdateSaldosPromedioArticulo;
DELIMITER //
CREATE PROCEDURE spUpdateSaldosPromedioInsumo(
	IN mid char(36),
	IN ncantidad DECIMAL(10,0),
    IN ncosto DECIMAL(15,10)
)
BEGIN
	DECLARE msaldocantidad  decimal(10,0) DEFAULT null;
    DECLARE msaldocosto  decimal(15,10) DEFAULT null;
    DECLARE mcostopromedio  decimal(15,10)DEFAULT null;
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
		CALL spUpdateSaldosPromedioArticulo(mid, ncantidad, ncosto);
	END IF;
END; //
CREATE PROCEDURE spUpdateSaldosPromedioArticulo(
	IN mid char(36),
	IN ncantidad DECIMAL(10,0),
    IN ncosto DECIMAL(15,10)
)
BEGIN
	DECLARE msaldocantidad decimal(10,0) DEFAULT null;
    DECLARE msaldocosto  decimal(15,10) DEFAULT null;
    DECLARE mcostopromedio  decimal(15,10) DEFAULT null;
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
	
END; //
DELIMITER ;


-- Ejemplo de como llamar al sp
-- CALL spUpdateSaldosPromedioInsumo('554ddad3-74b6-11e8-abed-f2f00eda9788', 1, 100);
-- CALL spUpdateSaldosPromedioInsumo('7885f6f5-6f99-11e8-abed-f2f00eda9788', 3, 100);
