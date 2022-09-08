/* 
	
	UPDATE ShipDate (+1 DAY) for all SalesOrderHeader
	
	WHERE the ship method name = 'CARGO TRANSPORT 5' 
	
	Tables:
	a) Sales.SalesOrderHeader
	b) Purchasing.ShipMethod

*/

SELECT DATEADD(day, 1, GETDATE())
SELECT DATEADD(month, 1, GETDATE())
SELECT DATEADD(year, 1, GETDATE())

BEGIN TRAN

ROLLBACK TRAN

-- 3806 rows should be affected