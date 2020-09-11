SET STATISTICS IO ON
SET STATISTICS TIME ON

--check performance
SELECT INN.MaxLineTotal, sod.* FROM Sales.SalesOrderDetail sod
inner join
(
	SELECT Max(LineTotal) as [MaxLineTotal], SalesOrderID
	FROM Sales.SalesOrderDetail
	GROUP BY SalesOrderID
) INN on inn.MaxLineTotal = sod.LineTotal and inn.SalesOrderID = sod.SalesOrderID

--check performance
SELECT * FROM
(
	SELECT
		Max(LineTotal) OVER(PARTITION BY SalesOrderID) as [MaxLineTotal], 
		*
	FROM Sales.SalesOrderDetail
) INN 
WHERE INN.MaxLineTotal = inn.LineTotal


-- check perfomrance
SELECT * FROM
(
	SELECT
		ROW_NUMBER() OVER(PARTITION BY SalesOrderID ORDER BY LineTotal DESC) AS 'Rank',
		*
	FROM Sales.SalesOrderDetail
) INN 
WHERE INN.[Rank] = 1


