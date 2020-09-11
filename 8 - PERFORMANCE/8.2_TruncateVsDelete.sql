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
INSERT INTO Sales 
VALUES ('Europe', 'Whatever', 'Poland', 'ShortName23', 'M', '2020-09-01 12:18:42.120', 69)
INSERT INTO Sales 
VALUES ('Europe', 'Whatever', 'Poland', 'ShortName23', 'M', '2020-09-01 12:18:42.120', 69)
INSERT INTO Sales 
VALUES ('Europe', 'Whatever', 'Poland', 'ShortName23', 'M', '2020-09-01 12:18:42.120', 69)
INSERT INTO Sales 
VALUES ('Europe', 'Whatever', 'Poland', 'ShortName23', 'M', '2020-09-01 12:18:42.120', 69)
INSERT INTO Sales 
VALUES ('Europe', 'Whatever', 'Poland', 'ShortName23', 'M', '2020-09-01 12:18:42.120', 69)
INSERT INTO Sales 
VALUES ('Europe', 'Whatever', 'Poland', 'ShortName23', 'M', '2020-09-01 12:18:42.120', 69)
INSERT INTO Sales 
VALUES ('Europe', 'Whatever', 'Poland', 'ShortName23', 'M', '2020-09-01 12:18:42.120', 69)
checkpoint

TRUNCATE TABLE dbo.Sales
DELETE FROM dbo.Sales

select * from dbo.Sales
BEGIN TRAN
	TRUNCATE TABLE dbo.Sales
COMMIT TRAN
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
0x530068006F00720074004E0061006D00650032003300

DECLARE @SupName7 varbinary(max) = 0x5700680061007400650076006500720050006F006C0061006E006400530068006F00720074004E0061006D006500320033004D00000101000C0000C9381C1D00000102000402030004
(SELECT cast(@SupName7 as [nvarchar](255)))


DECLARE @SupName nvarchar(255) = 'Whatever'
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

