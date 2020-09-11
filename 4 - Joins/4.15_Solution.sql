WITH 
  CTE_Sales
  AS
  (
    SELECT 
		SalesPersonID, 
		SUM(SubTotal) as [NetSales]
    FROM Sales.SalesOrderHeader
    WHERE SalesPersonID IS NOT NULL
    GROUP BY SalesPersonID
  ),
  CTE_Diff
  AS
  (
    SELECT ts.SalesPersonID,
      CASE 
        WHEN sp.SalesQuota IS NULL THEN 0
        ELSE sp.SalesQuota
      END AS QuotaDiff, 
      CASE 
        WHEN sp.SalesQuota IS NULL THEN ts.NetSales
        ELSE ts.NetSales - sp.SalesQuota
      END AS SalesQuota
    FROM CTE_Sales AS ts
      INNER JOIN Sales.SalesPerson AS sp
      ON ts.SalesPersonID = sp.BusinessEntityID
  )
SELECT 
  sp.FirstName + ' ' + sp.LastName AS FullName,
  sp.City,
  ts.NetSales,
  td.SalesQuota,
  td.QuotaDiff
FROM Sales.vSalesPerson AS sp
  INNER JOIN CTE_Sales AS ts
    ON sp.BusinessEntityID = ts.SalesPersonID
  INNER JOIN CTE_Diff AS td
    ON sp.BusinessEntityID = td.SalesPersonID
ORDER BY ts.NetSales DESC