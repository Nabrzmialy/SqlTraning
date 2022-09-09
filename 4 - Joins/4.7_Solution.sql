	SELECT 
		prod.Name as [Nazwa produktu],
		prod.ProductID as [Id Produktu],
		so.Description as [Nazwa Oferty],
		prod.ListPrice as [Cena katalogowa],
		prod.Color as [Kolor],
		sc.Name as [Kategoria]
	FROM Production.Product prod
	INNER JOIN sales.SpecialOfferProduct sop on prod.ProductID = sop.ProductID
	INNER JOIN sales.SpecialOffer so on sop.SpecialOfferID = so.SpecialOfferID
	INNER JOIN Production.ProductSubcategory sp on prod.ProductSubcategoryID = sp.ProductSubcategoryID
	INNER JOIN Production.ProductCategory sc on sp.ProductCategoryID = sc.ProductCategoryID
	WHERE so.[Description] = 'LL Road Frame Sale' and prod.Color = 'Red'