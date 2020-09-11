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