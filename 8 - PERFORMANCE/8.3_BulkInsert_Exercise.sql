-- insert rows from Exercise_Sales Records.csv
-- create statistics 
-- a) comparing bulk insert 
-- b) classic inserts
-- c) classic inserts in transaction
-- d) bulk insert with constraints
-- e) bulk insert with added trigger
-- f) bulk insert with constraints and trigger

DROP TABLE IF EXISTS Sales 
CREATE TABLE [dbo].[Sales](
	[Region] [varchar](50) ,
	[SumUp] [varchar](200) NULL,
	[Country] [varchar](50) ,
	[ItemType] [varchar](50) NULL,
	[OrderPriority] [varchar](50) NULL,
	[OrderDate]  datetime,
	[OrderID] bigint NULL,
)

ALTER TABLE [Sales] WITH CHECK ADD CONSTRAINT [CK_Sales_ItemType] 
CHECK ([OrderPriority] in ('M','H','L','C') )

SELECT * FROM Sales

BULK INSERT Sales
FROM 'C:\_GIT\SqlFan\8- Performance\Exercise_Sales Records.csv'

-- Create table SumUpLogs with column SumUp nvarchar(300)
-- save there value: [Region] + '-' +  [Country] + '-' + [ItemType] + '-' + [OrderPriority] via trigger