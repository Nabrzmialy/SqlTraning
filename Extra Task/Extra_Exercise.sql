/*
Find products with:
a) NoOfSoldProducts in all orders
b) list of all promotions which products participated
c) Name
d) Color
e) ModelName
f) Category Name
*/
EXEC Extra_Solution 


-- Helping queries
SELECT * FROM sales.SalesOrderDetail where ProductID=782

-- Check sum of sold product for product id 782
SELECT 
	SUM(OrderQty) as SumFor782 
FROM sales.SalesOrderDetail where ProductID=782

-- check in what promotions orders with product 782 participated
select distinct ProductID, ReasonType from [Sales].[SalesOrderHeaderSalesReason] [sales]
inner join [Sales].[SalesReason] reason on sales.SalesReasonID=reason.SalesReasonID
inner join Sales.SalesOrderDetail details on sales.SalesOrderID=details.SalesOrderID
where details.ProductID= 782


