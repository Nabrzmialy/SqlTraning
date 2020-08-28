-- Simple selects

SELECT * FROM Purchasing.ShipMethod
SELECT * FROM Sales.SalesOrderHeader

SELECT 
	SalesOrderId,
	ShipMethodID, 
	TotalDue
FROM Sales.SalesOrderHeader

--  INNER JOIN
SELECT 
	soh.SalesOrderId,
	soh.ShipMethodID, 
	soh.TotalDue,
	sm.[Name]
FROM Sales.SalesOrderHeader soh
INNER JOIN Purchasing.ShipMethod sm on soh.ShipMethodID = sm.ShipMethodID

--  LEFT JOIN
SELECT 
	soh.SalesOrderId,
	soh.ShipMethodID, 
	soh.TotalDue,
	sm.[Name]
FROM Sales.SalesOrderHeader soh
LEFT JOIN Purchasing.ShipMethod sm on soh.ShipMethodID = sm.ShipMethodID

SELECT 
	soh.SalesOrderId,
	soh.ShipMethodID, 
	soh.TotalDue,
	sm.[Name]
FROM Purchasing.ShipMethod sm
LEFT JOIN Sales.SalesOrderHeader soh  on soh.ShipMethodID = sm.ShipMethodID

--  RIGHT JOIN
SELECT 
	soh.SalesOrderId,
	soh.ShipMethodID, 
	soh.TotalDue,
	sm.[Name]
FROM Sales.SalesOrderHeader soh
RIGHT JOIN Purchasing.ShipMethod sm on soh.ShipMethodID = sm.ShipMethodID

-- SEMI JOIN
SELECT 
	sm.*
 FROM Purchasing.ShipMethod sm
WHERE EXISTS (SELECT 1
 FROM Sales.SalesOrderHeader soh
 WHERE soh.ShipMethodID = sm.ShipMethodID
 );

 -- ANTI SEMI JOIN
 SELECT 
	sm.*
 FROM Purchasing.ShipMethod sm
WHERE NOT EXISTS (SELECT 1
 FROM Sales.SalesOrderHeader soh
 WHERE soh.ShipMethodID = sm.ShipMethodID
 );


 -- only in first table not in...
  SELECT 
	sm.*
FROM Purchasing.ShipMethod sm
where sm.ShipMethodID not in (SELECT ShipMethodID FROM Sales.SalesOrderHeader)

 SELECT 
	soh.SalesOrderId,
	soh.ShipMethodID, 
	soh.TotalDue,
	sm.[Name]
FROM Purchasing.ShipMethod sm
LEFT JOIN Sales.SalesOrderHeader soh ON soh.ShipMethodID = sm.ShipMethodID 
WHERE soh.ShipMethodID is null

 -- only in second table -- not in...
SELECT 
	soh.SalesOrderId,
	soh.ShipMethodID, 
	soh.TotalDue,
	sm.[Name]
FROM Sales.SalesOrderHeader soh
RIGHT JOIN Purchasing.ShipMethod sm on soh.ShipMethodID = sm.ShipMethodID
where soh.ShipMethodID is null



select * from  Sales.SalesOrderDetail
SELECT * FROM Sales.Customer
SELECT * FROM Purchasing.ShipMethod