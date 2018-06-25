use tropical;
-- borrar el sp
-- drop procedure spUpdateSaldosPromedioInsumoBodegaEntrada;
DELIMITER //
CREATE PROCEDURE spUpdateSaldosPromedioInsumoBodegaEntrada(
	-- IN mid char(36),
	IN nidproducto char(36),
	IN nidbodega char(36),
	IN ncantidad DECIMAL(10,0),
    IN ncosto DECIMAL(20,10)
)
BEGIN
	DECLARE msaldocantidad  decimal(10,0) DEFAULT null;
    DECLARE msaldocosto  decimal(20,10) DEFAULT null;
    DECLARE mcostopromedio  decimal(20,10)DEFAULT null;
	-- verifica si el insumo se encuentra en el inventario.
	SELECT saldocantidad, costopromedio
	INTO msaldocantidad, mcostopromedio
	FROM insumosxbodega
	WHERE idproducto= nidproducto AND idbodega= nidbodega;
	IF msaldocantidad is null THEN
		INSERT INTO insumosxbodega VALUES (uuid(), nidproducto, nidbodega, 0, 0,0);
        SET msaldocantidad= 0;
        SET mcostopromedio= 0;
	END IF;
	-- Calculo de saldos y promedio
	set msaldocantidad = msaldocantidad + ncantidad;
	set msaldocosto=  msaldocosto + ncosto;
	set mcostopromedio= msaldocosto / msaldocantidad;
	--
	UPDATE insumosxbodega
	SET saldocantidad=msaldocantidad, saldocosto=msaldocosto, costopromedio = mcostopromedio
	WHERE id= mid; 
END; //
DELIMITER ;


-- Ejemplo de como llamar al sp
-- CALL spUpdateSaldosPromedioInsumo('554ddad3-74b6-11e8-abed-f2f00eda9788', 1, 100);
-- CALL spUpdateSaldosPromedioProductoSalida('3b31b046-75eb-11e8-abed-f2f00eda9788', 1000);
