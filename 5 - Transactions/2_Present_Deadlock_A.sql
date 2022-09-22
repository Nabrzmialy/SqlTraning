BEGIN TRAN TRAN_A


UPDATE dbo.supplier
SET [nameSupplier] = 'SUP_10'
WHERE idSupplier = 10

--TRAN_A
UPDATE dbo.supplier
SET [nameSupplier] = 'SUP_10'
WHERE idSupplier = 20

ROLLBACK


