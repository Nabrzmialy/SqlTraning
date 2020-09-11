-- check current isolation level of connection

/*
	0 = Unspecified
	1 = Read Uncommitted
	2 = Read Committed
	3 = Repeatable
	4 = Serializable
	5 = Snapshot
*/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

SELECT transaction_isolation_level
FROM sys.dm_exec_sessions
WHERE session_id = @@SPID;


SET TRANSACTION ISOLATION LEVEL READ COMMITTED

SELECT transaction_isolation_level
FROM sys.dm_exec_sessions
WHERE session_id = @@SPID;


---

SELECT DB_ID ('AdventureWorks2012') as [Db Id]
exec sp_lock

SET TRANSACTION ISOLATION LEVEL READ COMMITTED 
BEGIN TRAN
	UPDATE  dbo.TestIsolationLevels 
	SET     EmpSalary = 25000
	WHERE   EmpID = 2900
ROLLBACK TRAN

	SELECT      es.login_name, tl.resource_type, 
	            tl.resource_associated_entity_id,
	            tl.request_mode, 
	            tl.request_status,
				tl.*
	FROM        sys.dm_tran_locks tl
	INNER JOIN  sys.dm_exec_sessions es ON tl.request_session_id = es.session_id 
	WHERE       es.login_name = SUSER_SNAME() AND tl.resource_associated_entity_id <> 0

