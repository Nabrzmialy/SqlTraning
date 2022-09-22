-- Updates

BEGIN TRAN Tran_2

	UPDATE dbo.supplier
	SET [nameSupplier] = 'SUP_69'

ROLLBACK TRAN

