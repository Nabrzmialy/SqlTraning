/* 
	
	Introduce CTE for "nested queries"

*/

SELECT 
  sp.FirstName + ' ' + sp.LastName AS FullName, sp.City, ts.NetSales, td.SalesQuota, td.QuotaDiff
FROM Sales.vSalesPerson AS sp
  INNER JOIN  
  (
	SELECT 
		SalesPersonID, 
		SUM(SubTotal) as [NetSales]
    FROM Sales.SalesOrderHeader
    WHERE SalesPersonID IS NOT NULL
    GROUP BY SalesPersonID
  ) AS ts ON sp.BusinessEntityID = ts.SalesPersonID
  INNER JOIN 
  (
	 SELECT ts.SalesPersonID,
      CASE 
        WHEN sp.SalesQuota IS NULL THEN 0
        ELSE sp.SalesQuota
      END AS SalesQuota, 
      CASE 
        WHEN sp.SalesQuota IS NULL THEN ts.NetSales
        ELSE ts.NetSales - sp.SalesQuota
      END AS QuotaDiff
    FROM 
	(
		SELECT 
			SalesPersonID, 
			SUM(SubTotal) as [NetSales]
		FROM Sales.SalesOrderHeader
		WHERE SalesPersonID IS NOT NULL
		GROUP BY SalesPersonID
	)
	AS ts
      INNER JOIN Sales.SalesPerson AS sp
      ON ts.SalesPersonID = sp.BusinessEntityID
  ) td ON sp.BusinessEntityID = td.SalesPersonID
ORDER BY ts.NetSales DESC
