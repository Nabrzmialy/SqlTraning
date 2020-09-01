-- 1. use proper db
use SupplierPortal

-- 2. let's take a look at table
SELECT top 100 * from som.Supplier order by idSupplier

-- 3. Look at lockres
SELECT tOP 100 %%lockres%%, * FROM som.Supplier

-- 4. FIND UPDATER
select [Current LSN], [Lock Information], [Operation], [Transaction ID], [Begin Time], [End Time], [Transaction Name], [AllocUnitName], [Description], [Transaction SID]
from fn_dblog(null, null)
where AllocUnitName like '%Supplier%'

select %%lockres%%,*
	from som.Supplier
	where idSupplier=5

DECLARE @lockres nchar(14) = '(59855d342c69)'
select [Transaction ID],[Lock Information],*
	from fn_dblog(null, null)
	where charindex(@lockres, [Lock Information]) > 0;

select [Current LSN], [Operation], [Transaction ID], [Page ID],
	convert(int, convert(varbinary, '0x' + SUBSTRING([Page ID], 6, 8), 1)) as [Page ID], 
	[Slot ID], 
	[Transaction SID], [Begin Time], [End Time],
	[Num Elements], [AllocUnitName], [RowLog Contents 0], [RowLog Contents 1], [RowLog Contents 2],
	[RowLog Contents 3], [RowLog Contents 4], [RowLog Contents 5]
	from fn_dblog(null, null)
	where [Transaction ID] = '0000:00000454'

select [Current LSN], [Operation], [Transaction ID], [Page ID],
	convert(int, convert(varbinary, '0x' + SUBSTRING([Page ID], 6, 8), 1)) as [Page ID], 
	[Slot ID], 
	[Transaction SID], [Begin Time], [End Time],
	[Num Elements], [AllocUnitName], 
	cast([RowLog Contents 0] as nvarchar(100)) as [RowLog Contents 0], 
	cast([RowLog Contents 1] as nvarchar(100)) as [RowLog Contents 1],
	cast([RowLog Contents 2] as nvarchar(100)) as [RowLog Contents 2],
	cast([RowLog Contents 3] as nvarchar(100)) as [RowLog Contents 3],
	cast([RowLog Contents 4] as nvarchar(100)) as [RowLog Contents 4],
	cast([RowLog Contents 5] as nvarchar(100)) as [RowLog Contents 5]
	from fn_dblog(null, null)
	where [Transaction ID] = '0000:00000454'

SELECT SUSER_SNAME(0x869E24ABB2BF134B823B7BAB9A61D1AD)

-- 4. FIND DELETER

 -- 'EXTREMELY IMPORTANT SUPPLIER!!!'
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


select 
	[Current LSN], [Operation], [Transaction ID], [Page ID],
	convert(int, convert(varbinary, '0x' + SUBSTRING([Page ID], 6, 8), 1)) as [Page ID], 
	[Slot ID], 
	[Transaction SID], [Begin Time], [End Time],
	[Num Elements], [AllocUnitName], 
	[Log Record],
	cast([Log Record] as nvarchar(255)) as [Log Record Text]
from fn_dblog(null, null)
where [Transaction ID] = '0000:00000372'

-- SELECT SUSER_SNAME(0x6AC1E27B52570C4AB027A10E4739F529)

-- 5. FIND INSERTER

select %%lockres%%,*
	from som.Supplier
	where idSupplier=999999

DECLARE @lockres2 nchar(14) = '(cad04dee267c)'
select [Transaction ID], [Lock Information],*
	from fn_dblog(null, null)
	where charindex(@lockres2, [Lock Information]) > 0;

select [Current LSN], [Operation], [Transaction ID], [Page ID],
	convert(int, convert(varbinary, '0x' + SUBSTRING([Page ID], 6, 8), 1)) as [Page ID], 
	[Slot ID], 
	[Transaction SID], [Begin Time], [End Time],
	[Num Elements], [AllocUnitName]
	from fn_dblog(null, null)
	where [Transaction ID] = '0000:000003bf'


-- SELECT SUSER_SNAME(0xA243BA2746890B428AECA1EDA40CEE9B)