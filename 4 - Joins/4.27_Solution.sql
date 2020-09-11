DECLARE @ProductName VARCHAR(50) 
DECLARE @OrderId bigint
DECLARE @Sum bigint = 0;
DECLARE @Receipt VARCHAR(max) = '';

DECLARE cursor_product CURSOR FOR
	SELECT TOP 20000
        ItemType, 
        OrderID
    FROM 
        Sales;

OPEN cursor_product;
FETCH NEXT FROM cursor_product 
INTO @ProductName, @OrderId;

WHILE @@FETCH_STATUS = 0
    BEGIN
        
		DECLARE @Price varchar(50) = 0;

		IF(@ProductName = 'Snacks' 
			OR @ProductName = 'Fruits' 
			OR @ProductName = 'Cereal'
			OR @ProductName = 'Clothes')
		BEGIN
			SET @Price = SUBSTRING(CAST(@OrderId AS varchar(50)), 1, LEN(@ProductName))

			SET @Receipt = @Receipt + @ProductName + ' - ' + @Price + Char(13)
			SET @Sum = @Sum + CAST(@Price AS bigint)
		END

	FETCH NEXT FROM cursor_product INTO 
        @ProductName,
		@OrderId;
    END;
CLOSE cursor_product;
DEALLOCATE cursor_product;

PRINT @Sum
PRINT @Receipt

