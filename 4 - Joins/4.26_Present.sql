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

BULK INSERT Sales
FROM 'C:\_GIT\SqlFan\8- Performance\1500000 Sales Records.csv'
WITH (FIRSTROW = 2,
	KEEPNULLS,
    FIELDTERMINATOR = ',',
	ROWTERMINATOR='\n' );



SELECT TOP 10000 * 
INTO #SalesTemporary
FROM Sales

SELECT * FROM #SalesTemporary

SELECT TOP 10000 * 
INTO ##SalesTemporary
FROM Sales

-- Show names of generated tables.
--------------------------------------------------------------------------------------------
DROP TABLE #SalesTemporary
DROP TABLE ##SalesTemporary


CREATE TABLE #SalesTemporary(
	[Region] [varchar](50) ,
	[SumUp] [varchar](200) NULL,
	[Country] [varchar](50) ,
	[ItemType] [varchar](50) NULL,
	[OrderPriority] [varchar](50) NULL,
	[OrderDate]  datetime,
	[OrderID] bigint NULL,
)

INSERT INTO #SalesTemporary
SELECT TOP 10000 * FROM Sales

SELECT * FROM #SalesTemporary
-- check accessibility of global and local temp tables