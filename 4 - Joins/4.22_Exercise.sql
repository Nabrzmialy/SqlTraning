DROP TABLE IF EXISTS Sales 
CREATE TABLE [dbo].[Sales](
	[Region] [varchar](50) ,
	[OrderDate]  datetime,
	[OrderID] bigint NULL,
)

-- insert bulk file not touching table definition