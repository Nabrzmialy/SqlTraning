SELECT 
	DISTINCT prod.[Name] as [Nazwa Produktu]
FROM Sales.CreditCard cc
INNER JOIN sales.SalesOrderHeader soh on cc.CreditCardID = soh.CreditCardID
INNER JOIN sales.SalesOrderDetail sod on soh.SalesOrderID = sod.SalesOrderID
INNER JOIN Production.Product prod on sod.ProductID = prod.ProductID
WHERE 
	cc.CardNumber like '%69%'

	
	