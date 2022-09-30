-- 1. Database Id
SELECT DB_ID()

-- 2. Object Id on sql
SELECT OBJECT_ID(N'dbo.supplier')

-- 3. Stored procedure returning info about locks - 
EXEC sp_lock
/* COMMENT FROM OFFICIAL MICROSOFT PAGE:
This feature will be removed in a future version of Microsoft SQL Server. 
Avoid using this feature in new development work, and plan to modify applications that currently use this feature. 
To obtain information about locks in the SQL Server Database Engine, use the sys.dm_tran_locks dynamic management view.
*/

-- 4. Dynamic management view returning info about locks - 
select 
	*
from sys.dm_tran_locks

--5. Example
  SET TRANSACTION ISOLATION LEVEL SERIALIZABLE

  BEGIN TRAN FIRST_TRAN

  SELECT idSupplier, nameSupplier, dateCreation, country from supplier where idSupplier= 69

  ROLLBACK TRAN
  SELECT idSupplier, nameSupplier, dateCreation, country from supplier where idSupplier= 69
  		
SELECT * FROM GiveMeSupplierLocks

  SELECT
		L.request_session_id AS SPID, 
        DB_NAME(L.resource_database_id) AS DatabaseName,
        CASE WHEN 
			O.Name IS NULL THEN O2.name
			ELSE O.name
		END AS LockedObjectName, 
        P.object_id AS LockedObjectId, 
		L.resource_description,
        L.resource_type AS LockedResource, 
        L.request_mode AS LockType,
		L.request_status,
		I.name AS IndexName,
		I.type_desc,
        ES.login_name AS LoginName,
        ES.host_name AS HostName,
        TST.is_user_transaction as IsUserTransaction,
        AT.name as TransactionName,
        CN.auth_scheme as AuthenticationMethod,
		CN.most_recent_sql_handle,
		ST.text AS SqlStatementText
FROM    sys.dm_tran_locks L
        LEFT JOIN sys.partitions P ON P.hobt_id = L.resource_associated_entity_id
		LEFT JOIN sys.indexes I ON I.object_id = P.object_id AND I.index_id = P.index_id
        LEFT JOIN sys.objects O ON O.object_id = P.object_id
		LEFT JOIN sys.objects O2 ON O2.object_id = L.resource_associated_entity_id
        LEFT JOIN sys.dm_exec_sessions ES ON ES.session_id = L.request_session_id
        LEFT JOIN sys.dm_tran_session_transactions TST ON ES.session_id = TST.session_id
        LEFT JOIN sys.dm_tran_active_transactions AT ON TST.transaction_id = AT.transaction_id
        LEFT JOIN sys.dm_exec_connections CN ON CN.session_id = ES.session_id
        OUTER APPLY sys.dm_exec_sql_text(CN.most_recent_sql_handle) AS ST
WHERE   
	resource_database_id = db_id() 
	and (P.object_id = (SELECT OBJECT_ID(N'dbo.supplier')) 
			OR L.resource_associated_entity_id = (SELECT OBJECT_ID(N'dbo.supplier')) 
		)
ORDER BY L.request_session_id, LockedResource


SELECT %%lockres%%, idSupplier, nameSupplier, dateCreation, country from dbo.supplier where idsupplier= 69

SELECT %%lockres%%, idSupplier, nameSupplier, dateCreation, country from dbo.supplier where idsupplier < 100

--6. Let's have our own view getting locks from table dbo.Supplier.

DROP VIEW IF EXISTS GiveMeSupplierLocks

CREATE VIEW GiveMeSupplierLocks AS
  SELECT
		L.request_session_id AS SPID, 
        DB_NAME(L.resource_database_id) AS DatabaseName,
        CASE WHEN 
			O.Name IS NULL THEN O2.name
			ELSE O.name
		END AS LockedObjectName, 
        P.object_id AS LockedObjectId, 
		L.resource_description,
        L.resource_type AS LockedResource, 
        L.request_mode AS LockType,
		L.request_status,
		I.name AS IndexName,
		I.type_desc,
        ES.login_name AS LoginName,
        ES.host_name AS HostName,
        TST.is_user_transaction as IsUserTransaction,
        AT.name as TransactionName,
        CN.auth_scheme as AuthenticationMethod,
		CN.most_recent_sql_handle,
		ST.text AS SqlStatementText
FROM    sys.dm_tran_locks L
        LEFT JOIN sys.partitions P ON P.hobt_id = L.resource_associated_entity_id
		LEFT JOIN sys.indexes I ON I.object_id = P.object_id AND I.index_id = P.index_id
        LEFT JOIN sys.objects O ON O.object_id = P.object_id
		LEFT JOIN sys.objects O2 ON O2.object_id = L.resource_associated_entity_id
        LEFT JOIN sys.dm_exec_sessions ES ON ES.session_id = L.request_session_id
        LEFT JOIN sys.dm_tran_session_transactions TST ON ES.session_id = TST.session_id
        LEFT JOIN sys.dm_tran_active_transactions AT ON TST.transaction_id = AT.transaction_id
        LEFT JOIN sys.dm_exec_connections CN ON CN.session_id = ES.session_id
        OUTER APPLY sys.dm_exec_sql_text(CN.most_recent_sql_handle) AS ST
WHERE   
	resource_database_id = db_id() 
	and (P.object_id = (SELECT OBJECT_ID(N'dbo.supplier')) 
			OR L.resource_associated_entity_id = (SELECT OBJECT_ID(N'dbo.supplier')) 
		)



