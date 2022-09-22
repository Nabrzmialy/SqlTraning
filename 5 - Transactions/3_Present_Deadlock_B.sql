SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRAN TRAN_B           

SELECT Idsupplier,namesupplier from dbo.supplier
WHERE idSupplier = 10

SELECT Idsupplier,namesupplier from dbo.supplier
WHERE idSupplier = 20

ROLLBACK