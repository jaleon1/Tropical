use tropical;
-- borrar el sp
 -- drop procedure spUpdateSaldosPromedioInsumoBodegaEntrada;
DELIMITER //
CREATE PROCEDURE `spUpdateSaldosPromedioInsumoBodegaEntrada`(
	-- IN mid char(36),
	IN nidproducto char(36),
	IN nidbodega char(36),
	IN ncantidad DECIMAL(10,0),
    IN ncosto DECIMAL(20,10)
)
BEGIN
	DECLARE msaldocantidad  decimal(10,0) DEFAULT NULL;
    DECLARE msaldocosto  decimal(20,10) DEFAULT 0;
    DECLARE mcostopromedio  decimal(20,10)DEFAULT 0;
    DECLARE esVenta  int DEFAULT 0;
    DECLARE porcion int DEFAULT 0;
	-- verifica si el insumo se encuentra en el inventario.
	SELECT ib.saldocantidad, ib.saldocosto
	INTO msaldocantidad, msaldocosto
	FROM insumosXBodega ib
	WHERE idproducto= nidproducto AND idBodega= nidbodega;
    -- porcion.    
    SELECT p.esVenta
	INTO esVenta
	FROM producto p
	WHERE p.id= nidproducto;
    IF esVenta=0 THEN
		SET porcion=1;
	ELSEIF esVenta=1 THEN
		SET porcion=10;
	ELSEIF esVenta=2 THEN
		SET porcion=20;
	END IF;
    -- si no hay saldo de cantidad debe crear el insumo.
	IF msaldocantidad is null THEN
		SET msaldocantidad= 0;
        SET msaldocosto= 0;
        SET mcostopromedio= 0;   
		INSERT INTO insumosXBodega VALUES (uuid(), nidproducto, nidbodega, msaldocantidad, msaldocosto, mcostopromedio); 
	END IF;
	-- Calculo de saldos y promedio
	set msaldocantidad= msaldocantidad + (ncantidad*porcion);
	set msaldocosto=  msaldocosto + ncosto;
	set mcostopromedio= msaldocosto / msaldocantidad;
	--
	UPDATE insumosXBodega
	SET saldocantidad=msaldocantidad, saldocosto=msaldocosto, costopromedio = mcostopromedio
	WHERE idproducto= nidproducto AND idBodega= nidbodega;
END; //
DELIMITER ;


-- Ejemplo de como llamar al sp
-- CALL spUpdateSaldosPromedioInsumoBodegaEntrada('a2876212-77fb-11e8-abed-f2f00eda9788', 'e8b47412-75be-11e8-abed-f2f00eda9788',150, 100.0000000000);
