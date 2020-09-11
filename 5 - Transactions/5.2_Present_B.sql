-- READ UNCOMMITTED
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

SELECT EmpID, EmpName, EmpSalary
FROM dbo.TestIsolationLevels
WHERE EmpID = 2900

-- READ UNCOMMITTED - nolock
SET TRANSACTION ISOLATION LEVEL READ COMMITTED

SELECT EmpID, EmpName, EmpSalary
FROM dbo.TestIsolationLevels  WITH (NOLOCK)
WHERE EmpID = 2900

-- SNAPSHOT
SET TRANSACTION ISOLATION LEVEL READ COMMITTED  -- wait for consistent state after transaction
SET TRANSACTION ISOLATION LEVEL SNAPSHOT -- last consistent table state
SELECT EmpID, EmpName, EmpSalary
FROM dbo.TestIsolationLevels
WHERE EmpID = 2900

SELECT EmpID, EmpName, EmpSalary
FROM dbo.TestIsolationLevels


--Repeatable read
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED 

	BEGIN TRAN
		SELECT  EmpID, EmpName, EmpSalary
		FROM    dbo.TestIsolationLevels 
		WHERE   EmpID = 2900
		
		WAITFOR DELAY '00:00:10'
	
		SELECT  EmpID, EmpName, EmpSalary
		FROM    dbo.TestIsolationLevels 
		WHERE   EmpID = 2900
	COMMIT
	
	SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
	SET NOCOUNT ON
	GO
	BEGIN TRAN
		SELECT  EmpID, EmpName, EmpSalary
		FROM    dbo.TestIsolationLevels 
		WHERE   EmpID = 2900
		WAITFOR DELAY '00:00:10'
		SELECT  EmpID, EmpName, EmpSalary
		FROM    dbo.TestIsolationLevels 
		WHERE   EmpID = 2900
	COMMIT

	--phantom

	SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
	SET NOCOUNT ON
	GO
	BEGIN TRAN
		SELECT  EmpName
		FROM    dbo.TestIsolationLevels 
		WAITFOR DELAY '00:00:10'
		SELECT  EmpName
		FROM    dbo.TestIsolationLevels 
	COMMIT

--END - Repeatable read

-- SERIALIZABLE 
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE

BEGIN TRAN
	SELECT  EmpName
	FROM    dbo.TestIsolationLevels 
	WAITFOR DELAY '00:00:10'
	SELECT  EmpName
	FROM    dbo.TestIsolationLevels 
COMMIT


SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

BEGIN TRAN
	SELECT  EmpName
	FROM    dbo.TestIsolationLevels WITH (SERIALIZABLE)
	WAITFOR DELAY '00:00:10'
	SELECT  EmpName
	FROM    dbo.TestIsolationLevels WITH (SERIALIZABLE)
COMMIT



-- END -- SERIALIZABLE 


--problem with SNAPSHOT

	SET TRANSACTION ISOLATION LEVEL SNAPSHOT;
	BEGIN TRANSACTION;
 
	SELECT EmpName FROM dbo.TestIsolationLevels
	WHERE EmpID = 2900
	 
	WAITFOR DELAY '00:00:05'  
	 
	UPDATE dbo.TestIsolationLevels
	SET EmpName = 'Roger'
	WHERE EmpID = 2900;
	 
	SELECT EmpName FROM dbo.TestIsolationLevels
	WHERE EmpID = 2900;
	 
	COMMIT TRANSACTION;
	
-- end pws

	SELECT      es.login_name, tl.resource_type, 
	            tl.resource_associated_entity_id,
	            tl.request_mode, 
	            tl.request_status,
				tl.*
	FROM        sys.dm_tran_locks tl
	INNER JOIN  sys.dm_exec_sessions es ON tl.request_session_id = es.session_id 
	WHERE       es.login_name = SUSER_SNAME() AND tl.resource_associated_entity_id <> 0