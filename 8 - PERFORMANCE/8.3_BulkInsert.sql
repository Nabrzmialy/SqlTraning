--- Simple transaction
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



SET STATISTICS TIME ON

BULK INSERT dbo.Sales
FROM 'C:\_GIT\SqlFan\8- Performance\1500000 Sales Records.csv'
WITH (FIRSTROW = 2,
	KEEPNULLS,
    FIELDTERMINATOR = ',',
	ROWTERMINATOR='\n' );

SELECT COUNT(*) FROM [dbo].[Sales]

-- batch - 300000
TRUNCATE TABLE dbo.Sales


SELECT COUNT(*) FROM [dbo].[Sales]

BULK INSERT Sales
FROM 'C:\_GIT\SqlFan\8- Performance\1500000 Sales Records.csv'
WITH (FIRSTROW = 2,
    FIELDTERMINATOR = ',',
	ROWTERMINATOR='\n' ,
	batchsize=300000 );


-- MAXERRORS - 

BULK INSERT Sales
FROM 'C:\_GIT\SqlFan\8- Performance\1500000 Sales Records.csv'
WITH (FIRSTROW = 2,
    FIELDTERMINATOR = ',',
	ROWTERMINATOR='\n' ,
	MAXERRORS=10);

SELECT COUNT(*) AS [NumberofImportedRow] FROM Sales

-- trigger example
DROP TABLE IF EXISTS SalesLog
CREATE TABLE SalesLog (OrderIDLog bigint)

CREATE TRIGGER OrderLogIns ON Sales
FOR INSERT
AS
	BEGIN 
	SET NOCOUNT ON 
	INSERT INTO SalesLog
	SELECT OrderId from inserted
end

BULK INSERT Sales
FROM 'C:\_GIT\SqlFan\8- Performance\1500000 Sales Records.csv'
WITH (FIRSTROW = 2,
    FIELDTERMINATOR = ',',
	ROWTERMINATOR='\n' ,
	MAXERRORS=10,
	FIRE_TRIGGERS);

select * from SalesLog
select * from Sales

TRUNCATE TABLE Sales

-- constraints
--UNIQUE and PRIMARY KEY constraints are always enforced.

BULK INSERT Sales
FROM 'C:\_GIT\SqlFan\8- Performance\1500000 Sales Records.csv'
WITH (FIRSTROW = 2,
    FIELDTERMINATOR = ',',
	ROWTERMINATOR='\n' ,
	MAXERRORS=10,
	CHECK_CONSTRAINTS);




