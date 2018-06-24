CREATE DEFINER=`storydb`@`%` TRIGGER `tropical`.`distribucion_BEFORE_INSERT` BEFORE INSERT ON `distribucion` FOR EACH ROW
BEGIN
	-- ultima orden
	SELECT orden
	INTO @norden
	FROM distribucion
	ORDER BY orden DESC LIMIT 1;
    IF @norden IS NULL then
		set @norden=1;
	END IF;
	-- asigna nuevo valor    
	SET NEW.orden = @norden+1;
END