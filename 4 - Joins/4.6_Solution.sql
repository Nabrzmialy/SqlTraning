	SELECT 
		distinct soh.SalesOrderID
	FROM sales.SalesOrderHeader soh
	INNER JOIN sales.SalesOrderHeaderSalesReason sohsr on sohsr.SalesOrderID = soh.SalesOrderID
	INNER JOIN sales.SalesReason sr on sohsr.SalesReasonID = sr.SalesReasonID
	INNER JOIN sales.SalesOrderDetail sod on soh.SalesOrderID = sod.SalesOrderID
	INNER JOIN Production.Product prod on prod.ProductID = sod.ProductID
	WHERE 
		sr.[Name] IN ('Magazine Advertisement', 'Television  Advertisement')
		OR
		prod.ProductNumber = 'LJ-0192-M'
