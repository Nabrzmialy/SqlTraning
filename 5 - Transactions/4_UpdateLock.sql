-- Updates

BEGIN TRAN Tran_1

    SELECT * FROM dbo.Supplier WITH (UPDLOCK)
	WHERE   idSupplier = 10

	SELECT * FROM dbo.Supplier WITH (UPDLOCK)
	WHERE   idSupplier = 20

	UPDATE dbo.supplier
	SET [nameSupplier] = 'SUP_10'
	WHERE idSupplier = 10
	
	UPDATE dbo.supplier
	SET [nameSupplier] = 'SUP_10'
	WHERE idSupplier = 20

ROLLBACK TRAN

