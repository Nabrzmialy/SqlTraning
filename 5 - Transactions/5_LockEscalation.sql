-- Updates

BEGIN TRAN Tran_1

	-- LOCK ESCALATION
	UPDATE dbo.supplier
	SET [nameSupplier] = 'SUP_20'
	WHERE idSupplier < 7975

	-- NO LOCK ESCALATION
	UPDATE dbo.supplier
	SET [nameSupplier] = 'SUP_10'
	WHERE idSupplier < 7875

	SELECT * FROM dbo.Supplier
	WHERE   idSupplier < 7875

ROLLBACK TRAN

