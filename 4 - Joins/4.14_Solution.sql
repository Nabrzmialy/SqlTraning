SELECT 
	c.CustomerID as [Id Klienta],
	count(soh.customerId) as [Liczba zamowien],
	CASE
		WHEN avg(soh.TotalDue) is null THEN 0
		ELSE avg(soh.TotalDue)
	END as [Srednia wartosc zamowien],
	year(soh.OrderDate) as [Rok]
FROM Sales.Customer c
LEFT JOIN Sales.SalesOrderHeader soh on c.CustomerID = soh.CustomerID
GROUP by c.customerId, year(soh.OrderDate)
having count(soh.customerId) > 1
order by c.CustomerID
