--SET STATISTICS IO OFF
--SET STATISTICS TIME ON

SELECT 
	soh.SalesPersonID as [Sprzedawca],
	soh.TotalDue as [Kwota],
	T.* 
FROM [Sales].SalesOrderHeader soh 
INNER JOIN
(
	SELECT 
		sod.SalesOrderID,
		COUNT(sod.SalesOrderID) as [Liczba Pozycji]
	FROM [Sales].SalesOrderHeader soh
	INNER JOIN [Sales].SalesOrderDetail sod on soh.SalesOrderID = sod.SalesOrderID
	GROUP BY sod.SalesOrderID
	HAVING (COUNT(sod.SalesOrderID) > 10)
) T ON soh.SalesOrderID = T.SalesOrderID
order by salesorderId

-- CPU time = 46 ms,  elapsed time = 153 ms.

Select soh.SalesOrderID,count(soh.SalesOrderId) as [Number of orders], soh.TotalDue from [Sales].SalesOrderHeader soh
inner join [Sales].SalesOrderDetail sod on sod.SalesOrderID = soh.SalesOrderID
group by soh.SalesOrderID, soh.TotalDue
having (count(soh.SalesOrderId) > 10)
-- CPU time = 46 ms,  elapsed time = 163 ms.

SELECT MAX(soh.SalesPersonID) AS Sprzedawca, MAX(soh.TotalDue) AS Kwota, sod.SalesOrderID, COUNT(soh.SalesOrderID) AS [Suma pozycji]
FROM [Sales].SalesOrderHeader soh
INNER JOIN [Sales].SalesOrderDetail sod
ON soh.SalesOrderID = sod.SalesOrderID
GROUP BY sod.SalesOrderID
HAVING COUNT(soh.SalesOrderID) > 10

--SQL Server Execution Times:
--   CPU time = 94 ms,  elapsed time = 223 ms.