SELECT 
	prod.ProductID [Id Produktu],
	prod.[Name] as [Nazwa],
	pc.[Name] as [Kategoria Produktu],
	ps.[Name] as [Subkategoria Produktu]
FROM [Production].Product prod 
LEFT JOIN [Production].ProductSubcategory ps on prod.ProductSubcategoryID = ps.ProductSubcategoryID
LEFT JOIN [Production].ProductCategory pc on ps.ProductCategoryID = pc.ProductCategoryID


