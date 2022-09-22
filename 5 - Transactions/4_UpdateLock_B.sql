
BEGIN TRAN Tran_2

	UPDATE dbo.supplier
	SET [nameSupplier] = 'SUP_10'
	WHERE idSupplier = 20
	
	UPDATE dbo.supplier
	SET [nameSupplier] = 'SUP_10'
	WHERE idSupplier = 10

ROLLBACK TRAN

    SELECT * FROM dbo.Supplier
	WHERE   idSupplier = 10