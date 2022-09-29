/*
Find orders ids where sales person and customer person were:
a) from same territory
b) different teritory
c) find customers from germany + show full name as

tables:
Sales.SalesOrderHeader soh
Sales.Customer
Sales.SalesPerson
Person.Person
Sales.SalesTerritory
Sales.SalesTerritory

Make query with joins and extract data to temp table.
Then make queries below operational.
*/


SELECT * FROM #TempSales
WHERE Customer_TerritoryID <> Seller_TerritoryID

SELECT * FROM #TempSales
WHERE Customer_TerritoryID = Seller_TerritoryID

select distinct [CustomerName], Customer_Territory 
from #TempSales WHERE Customer_Territory = 'Germany'