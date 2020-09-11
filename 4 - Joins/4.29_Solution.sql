SELECT * FROM Sales.SalesOrderHeader soh 
inner join (
SELECT OrderDate, max(SalesOrderID) as [LastOrder] FROM Sales.SalesOrderHeader
GROUP BY OrderDate
) INN ON soh.SalesOrderID = inn.LastOrder and soh.OrderDate = inn.OrderDate

---
SELECT * FROM
(
	SELECT
		Max(SalesOrderID) OVER(PARTITION BY OrderDate) as [LastOrder], 
		*
	FROM Sales.SalesOrderHeader
) INN 
WHERE INN.[LastOrder] = inn.SalesOrderID

---
SELECT * FROM
(
	SELECT
		ROW_NUMBER() OVER(PARTITION BY OrderDate ORDER BY SalesOrderID DESC) AS 'Rank',
		*
	FROM Sales.SalesOrderHeader
) INN 
WHERE INN.[Rank] = 1

