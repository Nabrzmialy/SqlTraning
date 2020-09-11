SET NOCOUNT ON; -- show what's that

DECLARE @Start datetime2 = CURRENT_TIMESTAMP  

DECLARE @SalesOrderID INT
DECLARE Sales_Cursor CURSOR FOR
	select TOP 10000 
		SalesOrderID
	from 
		sales.SalesOrderHeader

OPEN Sales_Cursor;
FETCH NEXT FROM Sales_Cursor 
INTO @SalesOrderID

WHILE @@FETCH_STATUS = 0
    BEGIN
        
		PRINT @SalesOrderID
		
		UPDATE sales.SalesOrderHeader SET SubTotal = SubTotal
		WHERE SalesOrderID = @SalesOrderID

		FETCH NEXT FROM Sales_Cursor INTO 
		    @SalesOrderID;
    END;
CLOSE Sales_Cursor;
DEALLOCATE Sales_Cursor;

DECLARE @end datetime2 = CURRENT_TIMESTAMP  
SELECT DATEDIFF(MILLISECOND, @Start, @end) as [Diff]



