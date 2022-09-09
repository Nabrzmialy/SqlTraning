BEGIN TRAN

	DECLARE @ControlSum INT = 0

	UPDATE
	    p
	SET
	    p.ListPrice = p.ListPrice + 8.69
	FROM 
	    Production.Product p
		INNER JOIN Production.ProductSubcategory ps on p.ProductSubcategoryID = ps.ProductSubcategoryID
		INNER JOIN Production.ProductCategory pc on pc.ProductCategoryID = ps.ProductCategoryID
	WHERE pc.[Name]='Clothing' and p.Color = 'Black'

	SET @ControlSum = @@rowcount

IF(@ControlSum = 16)
BEGIN
	COMMIT TRAN
	PRINT 'COMMIT'
END
ELSE
BEGIN
	ROLLBACK TRAN
	PRINT 'ROLLBACK'
END