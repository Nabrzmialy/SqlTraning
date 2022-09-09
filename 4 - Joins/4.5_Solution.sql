SELECT 
		prod.ProductID [Id Produktu],
		prod.[Name] as [Nazwa],
		pc.[Name] as [Kategoria Produktu],
		ps.[Name] as [Subkategoria Produktu],
		photo.ThumbnailPhotoFileName as [Plik -Mniaturka Nazwa Zdjecia],
		photo.LargePhotoFileName as [Plik - Nazwa Zdjecia],
		review.Rating as [Ocena]
	FROM [Production].Product prod 
	INNER JOIN [Production].ProductSubcategory ps on prod.ProductSubcategoryID = ps.ProductSubcategoryID
	INNER JOIN [Production].ProductCategory pc on ps.ProductCategoryID = pc.ProductCategoryID
	INNER JOIN [Production].ProductProductPhoto prodPhoto on prodPhoto.ProductID = prod.ProductID
	INNER JOIN [Production].ProductPhoto photo on photo.ProductPhotoID = prodPhoto.ProductPhotoID
	INNER JOIN [Production].productReview review on prod.ProductID = review.ProductID
	WHERE photo.LargePhotoFileName <> 'no_image_available_large.gif'


