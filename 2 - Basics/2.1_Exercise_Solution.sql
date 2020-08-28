-- 2.1.A
SELECT *
FROM Production.Product
WHERE [ProductNumber] LIKE '%BK%' 

-- 2.1.B
SELECT *
FROM Production.Product
WHERE [ProductNumber] LIKE 'BK-[^R]%' 

-- 2.1.C
SELECT *
FROM Production.Product
WHERE [ProductNumber] LIKE 'FR-[A-Z][0-9][0-9][A-Z]-3_' 

-- 2.1.D
SELECT *
FROM Production.Product
WHERE 
	[ProductNumber] LIKE '%LN%' 
	OR (Color = 'RED')

-- 2.1.E
SELECT *
FROM Production.Product
WHERE 
	[Weight] >= 15 
	AND Color = 'BLACK'
	AND Size is not null
	AND ListPrice Between 600 AND 2500



