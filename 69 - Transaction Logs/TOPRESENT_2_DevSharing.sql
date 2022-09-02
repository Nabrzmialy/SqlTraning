USe SupplierPortal

DROP TABLE SupplierNew
create table SupplierNew (
	id int not null identity(1,1) primary key, 
	nameSuppplier char(20), 
	created_at datetime default getutcdate());



-------------- SINGLE INSERT ----------------
------------------ 1 START ------------------
DELETE FROM SupplierNew
TRUNCATE TABLE SupplierNew
CHECKPOINT
insert into SupplierNew (nameSuppplier) values ('random supplier');

SELECT * FROM SupplierNew

select [Current LSN], [Operation], [Transaction ID], [Begin Time], [End Time], [Transaction Name], 
[Page ID], 
convert(int, convert(varbinary, '0x' + SUBSTRING([Page ID], 6, 8), 1)) as [Page ID], 
[Slot ID], [AllocUnitName], [Description], [Transaction SID]
from fn_dblog(null, null)
------------------ 1 END ------------------

-------------- MULTIPLE INSERT ----------------
------------------ 2A START ------------------
begin transaction
insert into SupplierNew (nameSuppplier) values ('one supplier');
insert into SupplierNew (nameSuppplier) values ('two supplier');
insert into SupplierNew (nameSuppplier) values ('three supplier');
insert into SupplierNew (nameSuppplier) values ('four supplier');
insert into SupplierNew (nameSuppplier) values ('five supplier');
commit;

SELECT * FROM SupplierNew

select [Current LSN], [Operation], [Transaction ID], [Begin Time], [End Time], [Transaction Name], [AllocUnitName], [Description], [Transaction SID]
from fn_dblog(null, null)
------------------ 2A END ------------------

-------------- MULTIPLE INSERT with named transction----------------
------------------ 2B START ------------------
begin transaction DevSharingTransactionXXX
insert into SupplierNew (nameSuppplier) values ('999 supplier');
insert into SupplierNew (nameSuppplier) values ('888 supplier');
insert into SupplierNew (nameSuppplier) values ('777 supplier');
insert into SupplierNew (nameSuppplier) values ('666 supplier');
insert into SupplierNew (nameSuppplier) values ('555 supplier');
commit

select [Current LSN], [Operation], [Transaction ID], [Begin Time], [End Time], [Transaction Name], [AllocUnitName], [Description], [Transaction SID]
from fn_dblog(null, null)

------------------ 2B END ------------------


------------------ 3 START ------------------
SELECT * FROM SupplierNew
delete from SupplierNew
where nameSuppplier in ('one supplier','two supplier');
SELECT * FROM SupplierNew

select [Current LSN], [Operation], [Transaction ID], [Parent Transaction ID],
	[Begin Time], [Transaction Name], [Transaction SID]
from fn_dblog(null, null)
where [Operation] = 'LOP_BEGIN_XACT'

select [Current LSN], [Operation], 
	[AllocUnitName], [Page ID], [Slot ID], 
	[Lock Information],
	[Num Elements], [RowLog Contents 0], [RowLog Contents 1], [RowLog Contents 2], [Log Record]
from fn_dblog(null, null)
where [Transaction ID]='0000:000007ed'

------------------ 3 END ------------------

------------------ 4 START ------------------
SELECT * FROM SupplierNew

UPDATE SupplierNew set nameSuppplier = 'UPDATE EXAMPLE'

SELECT * FROM SupplierNew

select [Current LSN], [Operation], [Transaction ID], [Parent Transaction ID],
	[Begin Time], [Transaction Name], [Transaction SID]
from fn_dblog(null, null)
where [Operation] = 'LOP_BEGIN_XACT'

select [Current LSN], [Operation], 
	[AllocUnitName], [Page ID], [Slot ID], 
	[Lock Information],
	[Num Elements], [RowLog Contents 0], [RowLog Contents 1], [RowLog Contents 2], [Log Record]
from fn_dblog(null, null)
where [Transaction ID]='0000:000007ee'
------------------ 4 END ------------------















-- 4 -- analyze page
--database id = SELECT DB_ID() = 14
dbcc traceon(3604,-1);
-- (@databaseId, @FileId, @PageId, @OutPutOption={0|1|2|3})
dbcc page(7,1,320,3);

--5 --
/*
For B-Trees the key lock is a hash of the key value and thus can be used to locate the row, 
even if it moved after page splits.
We again located the same row, the first INSERT. 
Remember that lock resource hashes, by definition, can produce false positives due to hash collision
*/

--/*
--Anatomy of a Record (later) you can identify the record parts:
--10002400 is the record header
--01000000 is the first fixed column (id, int)
--0x7374616E64616C6F6E6520786163742020202020 is the second fixed char(20) column
--0x912ba300b6a10000 is the datetime created_at column
--0x030000 is the NULL bitmap
--*/
--select cast(0x7374616E64616C6F6E6520786163742020202020 as varchar(20))
--select top 1 * from demotable
----------------------------------------------------------------------------------------------------------------------------
--insert into demotable (data) values ('junk'), ('important'), ('do not change!');
--update demotable set data='changed' where data = 'do not change!';
--update demotable set created_at = getutcdate() where data = 'changed';
--delete from demotable where data='important'