DROP TABLE #TempSales

SELECT
	soh.SalesOrderID,
	c.CustomerID,
	p1.FirstName + ' ' + p1.LastName as [CustomerName],
	sp.BusinessEntityID,
	ISNULL(c.TerritoryID, 0) as Customer_TerritoryID,
	st2.Name as [Customer_Territory],
	ISNULL(sp.TerritoryID, 0) as Seller_TerritoryID,
	st1.Name as [Seller_Territory]
INTO #TempSales
FROM Sales.SalesOrderHeader soh
inner join Sales.Customer c on soh.CustomerID = c.CustomerID
inner join Sales.SalesPerson sp on soh.SalesPersonID = sp.BusinessEntityID
inner join Person.Person p1 on c.PersonID = p1.BusinessEntityID
LEFT join Sales.SalesTerritory st1 on sp.TerritoryID = st1.TerritoryID
LEFT join Sales.SalesTerritory st2 on c.TerritoryID = st2.TerritoryID

SELECT * FROM #TempSales
WHERE Customer_TerritoryID <> Seller_TerritoryID

SELECT * FROM #TempSales
WHERE Customer_TerritoryID = Seller_TerritoryID


CREATE NONCLUSTERED INDEX [IX_#TempSales_Customer_Territory] ON [dbo].[#TempSales]
(
	[Customer_Territory] ASC
)
INCLUDE([CustomerName])  ON [PRIMARY]

select distinct [CustomerName], Customer_Territory 
from #TempSales WHERE Customer_Territory = 'Germany'




SELECT * FROM #TempSales