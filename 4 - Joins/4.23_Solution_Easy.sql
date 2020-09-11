WITH 
CTE_DATA
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
		 
	),
	CTE_GROUPED_BY_COLOR as
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
		FROM ( SELECT * FROM CTE_DATA ) as col
		PIVOT 
		(
		    SUM([OrderQty]) 
		    FOR [Color] 
		    IN ([Black], [Red], [White], [Blue], [Multi], [Silver], [Yellow], [Unknown], [Silver/Black])
		) AS pvt
	),
	CTE_GROUPED_BY_FISCAL_YEAR as
	(
				SELECT 
		    pvt.[SalesPersonID]
		    ,pvt.[FullName]
			,pvt.[2011]
		    ,pvt.[2012]
		    ,pvt.[2013]
		    ,pvt.[2014] 
		FROM (SELECT 
		        soh.[SalesPersonID]
		        ,p.[FirstName] + ' ' + COALESCE(p.[MiddleName], '') + ' ' + p.[LastName] AS [FullName]
		        ,soh.[SubTotal]
		        ,YEAR([OrderDate]) AS [FiscalYear] 
		    FROM [Sales].[SalesPerson] sp 
		        INNER JOIN [Sales].[SalesOrderHeader] soh 
		        ON sp.[BusinessEntityID] = soh.[SalesPersonID]
				INNER JOIN [Person].[Person] p
				ON p.[BusinessEntityID] = sp.[BusinessEntityID]
			 ) AS soh 
		PIVOT 
		(
		    SUM([SubTotal]) 
		    FOR [FiscalYear] 
		    IN ([2011], [2012], [2013], [2014])
		) AS pvt
	)
	
	select * from CTE_GROUPED_BY_FISCAL_YEAR [year]
	left join CTE_GROUPED_BY_COLOR [color] on [year].SalesPersonID = color.SalesPersonID

	

