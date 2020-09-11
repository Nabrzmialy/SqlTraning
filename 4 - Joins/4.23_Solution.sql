WITH CTE_DATA
	 AS
	 (
		SELECT 
	        soh.[SalesPersonID],
			p.[FirstName] + ' ' + COALESCE(p.[MiddleName], '') + ' ' + p.[LastName] AS [FullName],
			case 
				when (prod.color is null) then 'Unknown'
				else prod.Color
			end as Color,
			sod.OrderQty
	    FROM [Sales].[SalesPerson] sp 
	        INNER JOIN [Sales].[SalesOrderHeader] soh 
	        ON sp.[BusinessEntityID] = soh.[SalesPersonID]
			INNER JOIN [Person].[Person] p
			ON p.[BusinessEntityID] = sp.[BusinessEntityID]
			INNER JOIN Sales.SalesOrderDetail sod on soh.SalesOrderID = sod.SalesOrderID
			inner join Production.Product prod on sod.ProductID = prod.ProductID
		 
	)
	 
	 SELECT 
	    pvt.[SalesPersonID],
	    pvt.[FullName],
		pvt.[Black], 
		pvt.[Red], 
		pvt.[White], 
		pvt.[Blue], 
		pvt.[Multi], 
		pvt.[Silver], 
		pvt.[Yellow], 
		pvt.[Unknown], 
		pvt.[Silver/Black]
	FROM ( SELECT * FROM CTE_DATA ) as col
	PIVOT 
	(
	    SUM([OrderQty]) 
	    FOR [Color] 
	    IN ([Black], [Red], [White], [Blue], [Multi], [Silver], [Yellow], [Unknown], [Silver/Black])
	) AS pvt;

-- different approach

 CREATE VIEW SoldProductsByColor
 AS

	 WITH CTE_DATA
	 AS
	 (
		SELECT 
	        soh.[SalesPersonID],
			p.[FirstName] + ' ' + COALESCE(p.[MiddleName], '') + ' ' + p.[LastName] AS [FullName],
	        soh.[SubTotal],
			sod.ProductID,
			case 
				when (prod.color is null) then 'Unknown'
				else prod.Color
			end as Color,
			sod.OrderQty,
			YEAR([OrderDate]) AS [FiscalYear] 
	    FROM [Sales].[SalesPerson] sp 
	        INNER JOIN [Sales].[SalesOrderHeader] soh 
	        ON sp.[BusinessEntityID] = soh.[SalesPersonID]
			INNER JOIN [Person].[Person] p
			ON p.[BusinessEntityID] = sp.[BusinessEntityID]
			INNER JOIN Sales.SalesOrderDetail sod on soh.SalesOrderID = sod.SalesOrderID
			inner join Production.Product prod on sod.ProductID = prod.ProductID
		 
	),
	CTE_BY_COLOR
	AS
	(
		select 
			SalesPersonId, Color, 
			SUM([OrderQty]) as [NoSoldProduct], 
			max([FullName]) as FullName from CTE_DATA
		group by SalesPersonId, Color
	)
	 
	 SELECT 
	    pvt.[SalesPersonID],
	    pvt.[FullName],
		pvt.[Black], 
		pvt.[Red], 
		pvt.[White], 
		pvt.[Blue], 
		pvt.[Multi], 
		pvt.[Silver], 
		pvt.[Yellow], 
		pvt.[Unknown], 
		pvt.[Silver/Black]
	FROM ( SELECT * FROM CTE_BY_COLOR ) as col
	PIVOT 
	(
	    SUM([NoSoldProduct]) 
	    FOR [Color] 
	    IN ([Black], [Red], [White], [Blue], [Multi], [Silver], [Yellow], [Unknown], [Silver/Black])
	) AS pvt;

SET STATISTICS TIME ON
select * from SoldProductsByColor

--- different approach



---
DROP VIEW SoldProductsByColorPlusTotalsInYears
 CREATE VIEW SoldProductsByColorPlusTotalsInYears
 AS
	 WITH CTE_DATA
	 AS
	 (
		SELECT 
	        soh.[SalesPersonID],
			soh.SalesOrderID,
			p.[FirstName] + ' ' + COALESCE(p.[MiddleName], '') + ' ' + p.[LastName] AS [FullName],
	        soh.[SubTotal],
			YEAR([OrderDate]) AS [FiscalYear] 
	    FROM [Sales].[SalesPerson] sp 
	        INNER JOIN [Sales].[SalesOrderHeader] soh 
	        ON sp.[BusinessEntityID] = soh.[SalesPersonID]
			INNER JOIN [Person].[Person] p
			ON p.[BusinessEntityID] = sp.[BusinessEntityID]
	),
	CTE_DATA_WITH_COLOR AS
	(
		SELECT 
	        soh.*,
			sod.ProductID,
			case 
				when (prod.color is null) then 'Unknown'
				else prod.Color
			end as Color,
			sod.OrderQty
	    FROM CTE_DATA soh
			INNER JOIN Sales.SalesOrderDetail sod on soh.SalesOrderID = sod.SalesOrderID
			inner join Production.Product prod on sod.ProductID = prod.ProductID
	),
	CTE_BY_COLOR
	AS
	(
		select 
			SalesPersonId, 
			Color, 
			sum ([OrderQty]) as [NoSoldProduct], 
			max([FullName]) as FullName from CTE_DATA_WITH_COLOR
		group by SalesPersonId, Color
	),
	CTE_BY_YEAR
	AS
	(
		select 
			SalesPersonId,
			sum (SubTotal) as [MoneySold], 
			FiscalYear from CTE_DATA
		group by SalesPersonId, FiscalYear
	),
	CTE_COLOR_PVT
	AS
	(
		SELECT 
			pvt.[SalesPersonID],
			pvt.[FullName],
			pvt.[Black], 
			pvt.[Red], 
			pvt.[White], 
			pvt.[Blue], 
			pvt.[Multi], 
			pvt.[Silver], 
			pvt.[Yellow], 
			pvt.[Unknown], 
			pvt.[Silver/Black]
		FROM ( SELECT * FROM CTE_BY_COLOR ) as col
		PIVOT 
		(
		    SUM([NoSoldProduct]) 
		    FOR [Color] 
		    IN ([Black], [Red], [White], [Blue], [Multi], [Silver], [Yellow], [Unknown], [Silver/Black])
		) AS pvt
	),
	CTE_BY_YEAR_PVT
	AS
	(
		select 
			pvt.SalesPersonID,
			pvt.[2011],
			pvt.[2012],
			pvt.[2013],
			pvt.[2014] 
		FROM ( SELECT * FROM CTE_BY_YEAR ) as col
		PIVOT ( 
			SUM([MoneySold]) 
			FOR [FiscalYear] 
			IN ([2011], [2012], [2013], [2014])
		) as pvt
	)

	select 
		[color].*,
		[SUM].[2011],
		[SUM].[2012],
		[SUM].[2013],
		[SUM].[2014]
		from CTE_COLOR_PVT [color]
	left join CTE_BY_YEAR_PVT [sum] on color.SalesPersonID = [sum].SalesPersonID
	
select * from SoldProductsByColorPlusTotalsInYears