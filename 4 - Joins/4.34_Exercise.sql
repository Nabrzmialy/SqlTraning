	SELECT 
		prod.ProductID [Id Produktu],
		prod.[Name] as [Nazwa],
		pc.[Name] as [Kategoria Produktu],
		ps.[Name] as [Subkategoria Produktu]
	FROM [Production].Product prod 
	LEFT JOIN [Production].ProductSubcategory ps on prod.ProductSubcategoryID = ps.ProductSubcategoryID
	LEFT JOIN [Production].ProductCategory pc on ps.ProductCategoryID = pc.ProductCategoryID

-- 1. Create stored procedure to filter this query by LIKE '%Bike%'
-- ProductName
-- CategoryName
-- SubCategoryName
-- Product ID

CREATE PROCEDURE uspGetProductsWithCategories

-- 2. Add parameters for paging
--@PageNumber
--@PageSize

exec uspGetProductsWithCategories 'Bikes', null, null, 0, 1, 20

--- 3. Filter only by products IDs - create new procedure to use int list - by creating own type

CREATE TYPE [dbo].[GuidList] AS TABLE(
	[Item] [uniqueidentifier] NULL
)

-- exec uspGetProductsWithCategories2 @IDs