--------------------------------------------------CREATE----------------------------------------------------------
CREATE VIEW Production.ProductsWithCategories
AS
SELECT 
	prod.ProductID [Id Produktu],
	prod.[Name] as [Nazwa],
	pc.[Name] as [Kategoria Produktu],
	ps.[Name] as [Subkategoria Produktu]
FROM [Production].Product prod 
LEFT JOIN [Production].ProductSubcategory ps on prod.ProductSubcategoryID = ps.ProductSubcategoryID
LEFT JOIN [Production].ProductCategory pc on ps.ProductCategoryID = pc.ProductCategoryID

SELECT * FROM Production.ProductsWithCategories
---------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------UPDATES---------------------------------------------------------------------------------
-- Cannot update identity column 'ProductID'.
UPDATE Production.ProductsWithCategories
SET [Id Produktu] = 2
WHERE [Id Produktu] = 1

-- Operational
UPDATE Production.ProductsWithCategories
SET Nazwa = 'Adjustable Race'
WHERE [Id Produktu] = 1

-- Operational
UPDATE Production.ProductsWithCategories
SET [Kategoria Produktu] = 'Components'
WHERE [Id Produktu] = 680

SELECT * FROM Production.ProductCategory

---------------------------------------------------INSERTS------------------------------------------------------------------
-- INSERT trial
INSERT INTO Production.ProductsWithCategories
([Id Produktu], Nazwa, [Kategoria Produktu], [Subkategoria Produktu])
VALUES
(1000, 'ML Bottom Bracket_', 'Components_',	'Bottom Brackets_')

-- INSERT trial
INSERT INTO Production.ProductsWithCategories
(Nazwa)
VALUES
('ML Bottom Bracket_')

-- INSERT trial with productNumber
INSERT INTO Production.ProductsWithCategories
(Nazwa, ProductNumber)
VALUES
('ML Bottom Bracket_', 'KO-2036')
--------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------WITHOUT CHECK--------------------------------------------------------------------------------------------
ALTER VIEW Production.ProductsWithCategories
AS
SELECT 
	prod.ProductID [Id Produktu],
	prod.[Name] as [Nazwa],
	pc.[Name] as [Kategoria Produktu],
	ps.[Name] as [Subkategoria Produktu],
	prod.Color as [Kolor]
FROM [Production].Product prod 
LEFT JOIN [Production].ProductSubcategory ps on prod.ProductSubcategoryID = ps.ProductSubcategoryID
LEFT JOIN [Production].ProductCategory pc on ps.ProductCategoryID = pc.ProductCategoryID
WHERE pc.[Name] is not null and prod.Color = 'Black'

SELECT * FROM Production.ProductsWithCategories

UPDATE Production.ProductsWithCategories
SET [Kolor] = 'White'
WHERE [Id Produktu] = 680

SELECT * FROM Production.ProductsWithCategories

UPDATE Production.Product SET Color= 'Black' WHERE ProductID = 680

SELECT * FROM Production.ProductsWithCategories
--------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------WITH CHECK--------------------------------------------------------------------------------------------
ALTER VIEW Production.ProductsWithCategories
AS
SELECT 
	prod.ProductID [Id Produktu],
	prod.[Name] as [Nazwa],
	pc.[Name] as [Kategoria Produktu],
	ps.[Name] as [Subkategoria Produktu],
	prod.Color as [Kolor]
FROM [Production].Product prod 
LEFT JOIN [Production].ProductSubcategory ps on prod.ProductSubcategoryID = ps.ProductSubcategoryID
LEFT JOIN [Production].ProductCategory pc on ps.ProductCategoryID = pc.ProductCategoryID
WHERE pc.[Name] is not null and prod.Color = 'Black'
WITH CHECK OPTION;  

SELECT * FROM Production.ProductsWithCategories

UPDATE Production.ProductsWithCategories
SET [Kolor] = 'White'
WHERE [Id Produktu] = 680

UPDATE Production.ProductsWithCategories
SET Nazwa = 'HL Road Frame - Black, 58___'
WHERE [Id Produktu] = 680

SELECT * FROM Production.ProductsWithCategories

--------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------WITHOUT SCHEMABINDING --------------------------------------------------------------------------------------------
ALTER VIEW Production.ProductsWithCategories 
AS
SELECT 
	prod.ProductID [Id Produktu],
	prod.[Name] as [Nazwa],
	pc.[Name] as [Kategoria Produktu],
	ps.[Name] as [Subkategoria Produktu],
	prod.Color as [Kolor]
FROM [Production].Product prod 
LEFT JOIN [Production].ProductSubcategory ps on prod.ProductSubcategoryID = ps.ProductSubcategoryID
LEFT JOIN [Production].ProductCategory pc on ps.ProductCategoryID = pc.ProductCategoryID

SELECT * FROM Production.ProductsWithCategories

ALTER TABLE Production.Product
ALTER COLUMN Color nvarchar(20) null

--------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------WITH SCHEMABINDING -----------------------------------------------------------------------------------------
ALTER VIEW Production.ProductsWithCategories 
WITH SCHEMABINDING
AS
SELECT 
	prod.ProductID [Id Produktu],
	prod.[Name] as [Nazwa],
	pc.[Name] as [Kategoria Produktu],
	ps.[Name] as [Subkategoria Produktu],
	prod.Color as [Kolor]
FROM [Production].Product prod 
LEFT JOIN [Production].ProductSubcategory ps on prod.ProductSubcategoryID = ps.ProductSubcategoryID
LEFT JOIN [Production].ProductCategory pc on ps.ProductCategoryID = pc.ProductCategoryID

SELECT * FROM Production.ProductsWithCategories

ALTER TABLE Production.Product
ALTER COLUMN Color nvarchar(20) null

DROP VIEW Production.ProductsWithCategories

--------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------Views With Aggregation -----------------------------------------------------------------------------------------
CREATE VIEW Sales.OrdersWithNumberOfReasons
AS
	SELECT 
		soh.SalesOrderID,
		T.[Ilosc Przyczyn],
		soh.CustomerID as [Id Klienta]
	FROM Sales.SalesOrderHeader soh 
	inner join 
	(
		SELECT 
			reason.SalesOrderID, 
			count(*) as [Ilosc Przyczyn]
		FROM Sales.SalesOrderHeaderSalesReason reason
		group by reason.SalesOrderID
		having count (*) > 1
	) T ON soh.SalesOrderID = T.SalesOrderID

SELECT * FROM Sales.OrdersWithNumberOfReasons

UPDATE Sales.OrdersWithNumberOfReasons
SET [Ilosc Przyczyn] = 3
WHERE [SalesOrderID] = 51522

