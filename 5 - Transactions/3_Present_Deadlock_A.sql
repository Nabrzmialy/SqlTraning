BEGIN TRAN TRAN_A

UPDATE dbo.supplier
SET [nameSupplier] = 'SUP_10'
WHERE idSupplier = 20

-- TRAN_B
UPDATE dbo.supplier
SET [nameSupplier] = 'SUP_10'
WHERE idSupplier = 10

ROLLBACK
