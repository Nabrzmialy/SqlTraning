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

DROP TABLE IF EXISTS Sales_INDEX 
CREATE TABLE [dbo].[Sales_INDEX](
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

	
BULK INSERT Sales_INDEX
FROM 'C:\_GIT\SqlFan\8- Performance\1500000 Sales Records.csv'
WITH (FIRSTROW = 2,
	KEEPNULLS,
    FIELDTERMINATOR = ',',
	ROWTERMINATOR='\n' );

-- remove duplicates
delete from Sales where OrderID in
(
	select OrderID from sales
	group by OrderID
	having count(*) > 1
)

delete from Sales_INDEX where OrderID in
(
	select OrderID from Sales_INDEX
	group by OrderID
	having count(*) > 1
)


-- add primary key
ALTER TABLE Sales
ADD CONSTRAINT PK_Sales PRIMARY KEY (OrderID);

ALTER TABLE Sales_INDEX
ADD CONSTRAINT PK_Sales_INDEX PRIMARY KEY (OrderID);

-- add non-clustered index
CREATE NONCLUSTERED INDEX [IX_Sales_Region] ON [dbo].[Sales_INDEX]
(
	[Region] ASC
)
INCLUDE([Country])  ON [PRIMARY]

--

SELECT top 100000
	region,
	[Country]
from [dbo].Sales
where region = 'Sub-Saharan Africa'

SELECT top 100000
	region,
	[Country] 
from [dbo].Sales_INDEX
where region = 'Sub-Saharan Africa'

--

SELECT top 100000
	region,
	[Country],
	OrderID
from [dbo].Sales
where region = 'Sub-Saharan Africa'

SELECT top 100000
	region,
	[Country],
	OrderID
from [dbo].Sales_INDEX
where region = 'Sub-Saharan Africa'

--

SELECT top 100000
	region,
	[Country],
	[OrderDate]
from [dbo].Sales
where region = 'Sub-Saharan Africa'

SELECT top 100000
	region,
	[Country],
	[OrderDate]
from [dbo].Sales_INDEX
where region = 'Sub-Saharan Africa'


--- show query performance difference
set STATISTICS IO ON
set STATISTICS TIME ON
declare @SalesVariable table (
	Id bigint
)

insert into @SalesVariable
select top 1000000 OrderID from Sales

SELECT count(1) FROM Sales [s]
inner join @SalesVariable sv on s.OrderID = sv.Id


SELECT top 1000000 OrderID INTO #SalesVariable
FROM Sales 

SELECT count(1) FROM Sales [s]
inner join #SalesVariable sv on s.OrderID = sv.OrderID

DROP TABLE #SalesVariable
-- 29.23