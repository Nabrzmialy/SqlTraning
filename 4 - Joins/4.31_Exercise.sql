/*

Write 2 functions as on the screen.

Function calculation no of working days - based only on information if it is
Saturday, Sunday - not working
[dbo].[ufnRetrieveWorkingDays] - parameters @StartDate, @EndDate 

DATEPART(weekday,GETDATE())

table:
Sales.SalesOrderHeader


*/


select 
	SalesOrderID,
	TotalDue,
	OrderDate,
	ShipDate,
	DATEDIFF(day, OrderDate, ShipDate) as [TimeToGet],
	dbo.[ufnRetrieveWorkingDays](OrderDate, ShipDate) as [TimeToGet_WorkDays]
from Sales.SalesOrderHeader
