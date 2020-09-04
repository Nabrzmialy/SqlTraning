/* 
  Truncate - minimally logged operation.
 - Check transaction logs for 10 rows
 - What happens with identity after truncate?
 - Are triggers executed for truncate?
 - Can you rollback truncate? If yes/no why?
 - Truncate with WHERE yes/no?
*/


DROP TABLE IF EXISTS Sales 
CREATE TABLE [dbo].[Sales](
	[Region] [nvarchar](255) ,
	[SumUp] [nvarchar](255) NULL,
	[Country] [nvarchar](255) ,
	[ItemType] [nvarchar](255) NULL,
	[OrderPriority] [nvarchar](255) NULL,
	[OrderDate]  datetime,
	[OrderID] bigint NULL,
)

SELECT * FROM Sales
INSERT INTO Sales 
VALUES ('Europe', 'Whatever', 'Poland', 'ShortName23', 'M', '2020-09-01 12:18:42.120', 69)

CHECKPOINT

select
	[Current LSN], [Description], [Operation], [Transaction ID], [Page ID], [log record Length],
	convert(int, convert(varbinary, '0x' + SUBSTRING([Page ID], 6, 8), 1)) as [Page ID], 
	[Slot ID], 
	[Transaction SID], [Begin Time], [End Time],
	[Num Elements], [AllocUnitName], 
	[Log Record], [RowLog Contents 0], [RowLog Contents 1], [RowLog Contents 2], [RowLog Contents 3], [RowLog Contents 4]
	,[RowLog Contents 5]
from fn_dblog(null, null)

--- 

DECLARE @SupName nvarchar(255) = 'EXTREMELY IMPORTANT SUPPLIER!!!'
DECLARE @SupName2 varbinary(max) = (SELECT cast(@SupName as varbinary))
select @SupName2
select 
	[Current LSN], [Operation], [Transaction ID], [Page ID],
	convert(int, convert(varbinary, '0x' + SUBSTRING([Page ID], 6, 8), 1)) as [Page ID], 
	[Slot ID], 
	[Transaction SID], [Begin Time], [End Time],
	[Num Elements], [AllocUnitName], 
	[Log Record]
from fn_dblog(null, null)
where charindex(@SupName2, [Log Record]) > 0;

