-- PREPARE DATA --

DROP TABLE IF EXISTS Sales 
CREATE TABLE [dbo].[Sales](
	[Region] [varchar](50) ,
	[SumUp] [varchar](200) NULL,
	[Country] [varchar](50) ,
	[ItemType] [varchar](50) NULL,
	[OrderPriority] [varchar](50) NULL,
	[OrderDate]  datetime,
	[OrderID] bigint NOT NULL,
)

BULK INSERT Sales
FROM 'C:\_GIT\SqlFan\8- Performance\1500000 Sales Records.csv'
WITH (FIRSTROW = 2,
	KEEPNULLS,
    FIELDTERMINATOR = ',',
	ROWTERMINATOR='\n' );

delete from Sales where OrderID in
(
	select OrderID from sales
	group by OrderID
	having count(*) > 1
)

SELECT * FROM [Sales]
SELECT COUNT(*) FROM [Sales]

--- HEAP TABLE --

SET STATISTICS IO ON

select * from [sales] 
select * from [sales] where OrderID=484937655

SELECT * FROM sys.dm_db_index_physical_stats 
(DB_ID(N'AdventureWorks2012'), OBJECT_ID(N'sales'), NULL, NULL , 'DETAILED')

SELECT *
FROM sys.dm_db_database_page_allocations 
    (DB_ID(N'AdventureWorks2012'), 
         OBJECT_ID(N'sales'), null, NULL, 'DETAILED')

DBCC SHOWCONTIG('sales') WITH ALL_LEVELS, TABLERESULTS, NO_INFOMSGS

SELECT (8993 * 8000)
select (83.317 * 848572)

ALTER TABLE dbo.Sales REBUILD


select * from [sales] where OrderID=484937655

-- Table with primary key --
ALTER TABLE Sales
ADD CONSTRAINT PK_Sales PRIMARY KEY (OrderID);

select * from [sales] where OrderID=484937655

SELECT * FROM sys.dm_db_index_physical_stats 
(DB_ID(N'AdventureWorks2012'), OBJECT_ID(N'sales'), NULL, NULL , 'DETAILED')

SELECT x.page_level,*
FROM sys.dm_db_database_page_allocations 
    (DB_ID(N'AdventureWorks2012'), 
         OBJECT_ID(N'sales'), null, NULL, 'DETAILED') x
order by x.page_level

DBCC PAGE('AdventureWorks2012',1,48674,3) WITH TABLERESULTS
DBCC PAGE('AdventureWorks2012',1,48688,3) WITH TABLERESULTS
DBCC PAGE('AdventureWorks2012',1,59076,3) WITH TABLERESULTS



-- Non-clustered index seek --

CREATE NONCLUSTERED INDEX [IX_Sales_Country] ON [dbo].[Sales]
(
	[Country] ASC
)
INCLUDE([Region]) 

SELECT Country, Region FROM dbo.Sales where Country = 'Poland'


SELECT * FROM sys.dm_db_index_physical_stats 
(DB_ID(N'AdventureWorks2012'), OBJECT_ID(N'sales'), NULL, NULL , 'DETAILED')

SELECT x.page_level,*
FROM sys.dm_db_database_page_allocations 
    (DB_ID(N'AdventureWorks2012'), 
         OBJECT_ID(N'sales'), null, NULL, 'DETAILED') x
order by x.page_level

DBCC PAGE('AdventureWorks2012',1,67578,3) WITH TABLERESULTS
DBCC PAGE('AdventureWorks2012',1,67596,3) WITH TABLERESULTS
DBCC PAGE('AdventureWorks2012',1,72156,3) WITH TABLERESULTS

-- Key Lookup


SELECT Country, Region, ItemType FROM dbo.Sales 
where Country = 'Poland'

SELECT Country, Region, ItemType FROM dbo.Sales 
WITH (INDEX([IX_Sales_Country]))
where Country = 'Poland'

-- Sort

SELECT Country, Region, ItemType, OrderDate FROM dbo.Sales 
where Country = 'Poland'
ORDER BY OrderDate desc

-- Group by - Aggregate 

SELECT MAX(OrderId) as [MaxOrderId], Country FROM dbo.Sales 
GROUP BY Country
order by MAX(OrderId)


SELECT avg(OrderId) as [AvgOrderId], Country FROM dbo.Sales 
GROUP BY Country

-- Compute Scalar

SELECT 
	OrderId,
	Country + ' - ' + ItemType as [Summary]
FROM dbo.Sales 

-- Concatenation + Top 

SELECT top 100 *
FROM dbo.Sales  AS P1
UNION ALL
SELECT top 100 *
FROM dbo.Sales  AS P2

-- Hash JOIN

select h.salesorderid, d.salesorderDetailid from sales.salesorderHeader h
inner join sales.salesorderDetail d on h.salesorderID = d.salesOrderId

-- Merge JOIN

select h.salesorderid, d.salesorderDetailid from sales.salesorderHeader h
inner merge join sales.salesorderDetail d on h.salesorderID = d.salesOrderId

-- Nested Loop 

select h.salesorderid, d.salesorderDetailid from sales.salesorderHeader h
inner LOOP  join sales.salesorderDetail d on h.salesorderID = d.salesOrderId

-- group by without index -- hash match -- aggregate

SELECT country, count(*) From sales
group by country

-- filter operator

SELECT country, count(*) From sales
group by country
having count (*) > 4566

-- Force paralelism --

select h.salesorderid, d.salesorderDetailid from sales.salesorderHeader h
inner   join sales.salesorderDetail d on h.salesorderID = d.salesOrderId
OPTION (QUERYTRACEON 8649)


