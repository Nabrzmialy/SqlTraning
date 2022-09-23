DROP TABLE IF EXISTS Sales 
CREATE TABLE [dbo].[Sales](
	[Region] [varchar](50) ,
	[Country] [varchar](50) ,
	[ItemType] [varchar](50) NULL,
	[OrderPriority] [varchar](50) NULL,
	[OrderDate]  datetime,
	[OrderID] bigint NULL,
)

SELECT count(*) FROM Sales
BULK INSERT Sales
FROM 'C:\_GIT\SqlFan\8- Performance\Exercise_Sales Records2.csv'
WITH (FIRSTROW = 8,
	KEEPNULLS,
    FIELDTERMINATOR = ';',
	MAXERRORS = 15,
	ROWTERMINATOR='\r' );



