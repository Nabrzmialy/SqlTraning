SELECT * FROM [Sales].SalesOrderHeader

SELECT 
	COUNT(SalesOrderID) as [Liczba Zamowien] 
FROM [Sales].SalesOrderHeader

SELECT 
	MIN(TotalDue) as [Minimalne Zamowienie] 
FROM [Sales].SalesOrderHeader

SELECT 
	MAX(TotalDue) as [Maksymalne Zamowienie] 
FROM [Sales].SalesOrderHeader

SELECT 
	SUM(TotalDue) as [Suma Zamowien] 
FROM [Sales].SalesOrderHeader

SELECT 
	AVG(TotalDue) as [Srednia kwota zamowien] 
FROM [Sales].SalesOrderHeader

----

SELECT 
	SalesPersonID,
	COUNT(SalesOrderID) as [Liczba Zamowien], 
	MIN(TotalDue) as [Minimalne Zamowienie], 
	MAX(TotalDue) as [Maksymalne Zamowienie],
	SUM(TotalDue) as [Suma Zamowien],
	AVG(TotalDue) as [Srednia kwota zamowien]
FROM [Sales].SalesOrderHeader
GROUP BY SalesPersonID


-- Filtering aggregate operations
SELECT 
	SalesPersonID,
	COUNT(SalesOrderID) as [Liczba Zamowien], 
	MIN(TotalDue) as [Minimalne Zamowienie], 
	MAX(TotalDue) as [Maksymalne Zamowienie],
	SUM(TotalDue) as [Suma Zamowien],
	AVG(TotalDue) as [Srednia kwota zamowien]
FROM [Sales].SalesOrderHeader
GROUP BY SalesPersonID
HAVING (COUNT(SalesOrderID) > 100)

-- Finding only orders with person who sold product
SELECT 
	SalesPersonID,
	COUNT(SalesOrderID) as [Liczba Zamowien], 
	MIN(TotalDue) as [Minimalne Zamowienie], 
	MAX(TotalDue) as [Maksymalne Zamowienie],
	SUM(TotalDue) as [Suma Zamowien],
	AVG(TotalDue) as [Srednia kwota zamowien]
FROM [Sales].SalesOrderHeader
WHERE SalesPersonID IS NOT NULL
GROUP BY SalesPersonID
HAVING (COUNT(SalesOrderID) > 100)

-- Show details of people with statistics -- impossible
SELECT 
	sp.*,
	soh.SalesPersonID,
	COUNT(soh.SalesOrderID) as [Liczba Zamowien], 
	MIN(soh.TotalDue) as [Minimalne Zamowienie], 
	MAX(soh.TotalDue) as [Maksymalne Zamowienie],
	SUM(soh.TotalDue) as [Suma Zamowien],
	AVG(soh.TotalDue) as [Srednia kwota zamowien]
FROM [Sales].SalesOrderHeader soh
INNER JOIN [Sales].SalesPerson sp on soh.SalesPersonID = sp.BusinessEntityID
WHERE SalesPersonID IS NOT NULL
GROUP BY SalesPersonID
HAVING (COUNT(SalesOrderID) > 100)

-- Show details of people with statistics -- impossible
SELECT 
	sp.*,
	soh.SalesPersonID,
	COUNT(soh.SalesOrderID) as [Liczba Zamowien], 
	MIN(soh.TotalDue) as [Minimalne Zamowienie], 
	MAX(soh.TotalDue) as [Maksymalne Zamowienie],
	SUM(soh.TotalDue) as [Suma Zamowien],
	AVG(soh.TotalDue) as [Srednia kwota zamowien]
FROM [Sales].SalesOrderHeader soh
INNER JOIN [Sales].SalesPerson sp on soh.SalesPersonID = sp.BusinessEntityID
WHERE SalesPersonID IS NOT NULL
GROUP BY SalesPersonID
HAVING (COUNT(SalesOrderID) > 100)

-- There's need to introduce inner table

SELECT T.* FROM 
(
	SELECT 
		soh.SalesPersonID,
		COUNT(soh.SalesOrderID) as [Liczba Zamowien], 
		MIN(soh.TotalDue) as [Minimalne Zamowienie], 
		MAX(soh.TotalDue) as [Maksymalne Zamowienie],
		SUM(soh.TotalDue) as [Suma Zamowien],
		AVG(soh.TotalDue) as [Srednia kwota zamowien]
	FROM [Sales].SalesOrderHeader soh
	WHERE SalesPersonID IS NOT NULL
	GROUP BY SalesPersonID
	HAVING (COUNT(SalesOrderID) > 100)
) T

-- After inner table we can have sales person details
SELECT 
	person.*, 
	T.* 
FROM 
(
	SELECT 
		soh.SalesPersonID,
		COUNT(soh.SalesOrderID) as [Liczba Zamowien], 
		MIN(soh.TotalDue) as [Minimalne Zamowienie], 
		MAX(soh.TotalDue) as [Maksymalne Zamowienie],
		SUM(soh.TotalDue) as [Suma Zamowien],
		AVG(soh.TotalDue) as [Srednia kwota zamowien]
	FROM [Sales].SalesOrderHeader soh
	WHERE SalesPersonID IS NOT NULL
	GROUP BY SalesPersonID
	HAVING (COUNT(SalesOrderID) > 100)
) T
INNER JOIN Sales.SalesPerson sp on T.SalesPersonID = sp.BusinessEntityID
INNER JOIN HumanResources.Employee e on sp.BusinessEntityID = e.BusinessEntityID
INNER JOIN Person.Person person on person.BusinessEntityID = e.BusinessEntityID