DROP TABLE IF EXISTS Sales 
CREATE TABLE [dbo].[Sales](
	[Region] [varchar](50) ,
	[SumUp] [varchar](200) NULL,
	[Country] [varchar](50) ,
	[ItemType] [varchar](50) NULL,
	[OrderPriority] [varchar](50) NULL,
	[OrderDate]  datetime,
	[OrderID] bigint NULL,
	[RandomInt] int null,
	[NewName] [varchar](50) null,
)

-- insert bulk file not touching table definition
drop VIEW NewSales
CREATE VIEW NewSales
AS
SELECT 
	[Region Name],
	[SumUp],
	[Country Name],
	[ItemType],
	[OrderPriority],
	[OrderDate],
	[OrderID]
FROM Sales

BULK INSERT NewSales
FROM 'C:\_GIT\SqlFan\8- Performance\1500000 Sales Records.csv'
WITH (FIRSTROW = 2,
	KEEPNULLS,
    FIELDTERMINATOR = ',',
	ROWTERMINATOR='\n' );

