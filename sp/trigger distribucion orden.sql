CREATE DEFINER = CURRENT_USER TRIGGER `tropical`.`distribucion_BEFORE_UPDATE` BEFORE UPDATE ON `distribucion` FOR EACH ROW
BEGIN
	-- ultima orden
	SELECT orden
	INTO @nnumeroorden
	FROM distribucion
	ORDER BY orden DESC LIMIT 1;
    IF @nnumeroorden IS NULL then
		set @nnumeroorden=0;
	END IF;
	-- asigna nuevo valor    
	SET NEW.orden = @nnumeroorden+1;
END
