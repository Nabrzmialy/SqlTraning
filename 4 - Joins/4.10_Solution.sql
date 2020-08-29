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
