	SELECT * FROM
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
	) T
order by SalesPersonId


