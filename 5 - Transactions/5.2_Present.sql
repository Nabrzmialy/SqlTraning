/* SET TRANSACTION ISOLATION LEVEL
    {READ UNCOMMITTED
    | READ COMMITTED
    | REPEATABLE READ
    | SNAPSHOT
    | SERIALIZABLE
    } */

-- init
DROP TABLE IF EXISTS dbo.TestIsolationLevels 
CREATE TABLE dbo.TestIsolationLevels (
EmpID INT NOT NULL,
EmpName VARCHAR(100),
EmpSalary MONEY,
CONSTRAINT pk_EmpID PRIMARY KEY(EmpID) )

INSERT INTO dbo.TestIsolationLevels 
VALUES 
	(2322, 'Dave Smith', 35000),
	(2900, 'John West', 22000),
	(2219, 'Melinda Carlisle', 40000),
	(2950, 'Adam Johns', 18000) 
GO

SELECT * FROM dbo.TestIsolationLevels 
SELECT @@TRANCOUNT

-- READ UNCOMMITTED
BEGIN TRAN
UPDATE  dbo.TestIsolationLevels 
SET     EmpSalary = 25000
WHERE   EmpID = 2900
ROLLBACK TRAN

--- snapshot / read-commited

BEGIN TRAN
	UPDATE  dbo.TestIsolationLevels 
	SET     EmpSalary = 25000
	WHERE   EmpID = 2900
	--
ROLLBACK

--Repeatable read

BEGIN TRAN
	UPDATE  dbo.TestIsolationLevels 
	SET     EmpSalary = 8764
	WHERE   EmpID = 2900
COMMIT

	--phantom
	BEGIN TRAN
		INSERT INTO dbo.TestIsolationLevels VALUES (3427, 'Phantom Employee 1', 30000)
	COMMIT


-- Serializable

BEGIN TRAN
	INSERT INTO dbo.TestIsolationLevels VALUES (3428, 'Phantom Employee 2', 30000)
COMMIT


-- END Serializable



-- Problem with snapshot:

	--session 2
	UPDATE dbo.TestIsolationLevels
	SET EmpName = 'Harold'
	WHERE EmpID = 2900
	 
	SELECT EmpName FROM dbo.TestIsolationLevels
	WHERE EmpID = 2900;