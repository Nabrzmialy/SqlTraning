ALTER DATABASE ecoPortal SET READ_COMMITTED_SNAPSHOT OFF 

/* SET TRANSACTION ISOLATION LEVEL
{ 
	| 1- READ UNCOMMITTED
    | 2- READ COMMITTED
    | 3- REPEATABLE READ
	| 4- SERIALIZABLE
    | 5- SNAPSHOT
} */
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE

SELECT transaction_isolation_level
FROM sys.dm_exec_sessions
WHERE session_id = @@SPID;

BEGIN TRAN
select  idSupplier, nameSupplier, country
from dbo.Supplier
WHERE   idSupplier <= 160











--- QUERY A --
------------------- Question no 1 ---------------------
BEGIN TRAN
UPDATE  dbo.Supplier 
SET     nameSupplier = 'Michal Sql Company'
WHERE   idSupplier <= 160

rollback tran


















--- QUERY A --
------------------- Question no 2 ---------------------
BEGIN TRAN
UPDATE  dbo.Supplier 
SET     nameSupplier = 'Michal Sql Company'
WHERE   idSupplier = 150

ROLLBACK TRAN






--- QUERY A --
------------------- Question no 3 ---------------------
BEGIN TRAN
UPDATE  dbo.Supplier 
SET     nameSupplier = 'Michal Sql Company'
WHERE   idSupplier <= 160

rollback tran








--- QUERY A --
------------------- Question no 4 ---------------------
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
BEGIN TRAN
UPDATE  dbo.Supplier 
SET     nameSupplier = 'Michal Sql Company'
WHERE   idSupplier <= 160
rollback tran

















--- QUERY A --
------------------- Question no 5 ---------------------
BEGIN TRAN
UPDATE  dbo.Supplier 
SET     nameSupplier = 'Michal Sql Company'
WHERE   idSupplier <= 160
rollback tran












SET TRANSACTION ISOLATION LEVEL READ COMMITTED 


--- QUERY A --
------------------- Question no 6 ---------------------
UPDATE  dbo.Supplier 
SET     Country = 'Japan'
WHERE   idSupplier <= 160











--- QUERY A --
------------------- Question no 7 ---------------------
UPDATE  dbo.Supplier 
SET     Country = 'Hungary'
WHERE   idSupplier <= 160












--- QUERY A --
------------------- Question no 8 ---------------------
-- 1. Delete--
delete from dbo.Supplier where idSupplier=24


INSERT INTO dbo.Supplier
(idSupplier, nameSupplier, country, idCategory, evid)
VALUES
(24, 'Fresh New Supplier', 'Poland', 244, 'SX704239')












--- QUERY A --
------------------- Question no 9 ---------------------
-- 1. Delete--
delete from dbo.Supplier where idSupplier=24

-- 3 Insert - 
INSERT INTO dbo.Supplier
(idSupplier, nameSupplier, country, idCategory, evid)
VALUES
(24, 'Fresh New Supplier', 'Poland', 244, 'SX704239')


