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
    DECLARE msaldocosto  decimal(20,10) DEFAULT 0;
    DECLARE mcostopromedio  decimal(20,10)DEFAULT 0;
	-- verifica si el insumo se encuentra en el inventario.
	SELECT saldoCantidad, saldoCosto
	INTO msaldocantidad, msaldocosto
	FROM insumosxbodega
	WHERE idproducto= nidproducto AND idbodega= nidbodega;
    -- si no hay saldo de cantidad debe crear el insumo
	IF msaldocantidad is null THEN
		SET msaldocantidad= 0;
        SET msaldocosto= 0;
        SET mcostopromedio= 0;   
		INSERT INTO insumosxbodega VALUES (uuid(), nidproducto, nidbodega, msaldocantidad, msaldocosto, mcostopromedio);          
	END IF;
	-- Calculo de saldos y promedio
	set msaldocantidad= msaldocantidad + ncantidad;
	set msaldocosto=  msaldocosto + ncosto;
	set mcostopromedio= msaldocosto / msaldocantidad;
	--
	UPDATE insumosxbodega
	SET saldoCantidad=msaldocantidad, saldoCosto=msaldocosto, costoPromedio = mcostopromedio
	WHERE idproducto= nidproducto AND idbodega= nidbodega;
END; //
DELIMITER ;


-- Ejemplo de como llamar al sp
-- CALL spUpdateSaldosPromedioInsumoBodegaEntrada('a2876212-77fb-11e8-abed-f2f00eda9788', 'e8b47412-75be-11e8-abed-f2f00eda9788',150, 100.0000000000);
