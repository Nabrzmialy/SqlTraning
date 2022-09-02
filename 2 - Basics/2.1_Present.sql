------------------------------------ Simple select------------------------------------------------
SELECT 'Welcome in Bydgoszcz'

------------------------------------ Simple select 2 values------------------------------------------------
SELECT 'Welcome in Bydgoszcz', 'I love sql' 

------------------------------------ Simple select from table------------------------------------------------
SELECT 
	ProductID, 
	Name, 
	ProductNumber 
FROM Production.Product 

------------------------------------ All columns from table - "*"------------------------------------------------
SELECT * FROM Production.Product

------------------------------------ ALIASING - Renaming column names in result------------------------------------------------
SELECT 
	'Welcome in Bydgoszcz' as Greeting, 
	'I love sql' as Motto 

SELECT
    ProductID AS ID,
    Name AS ProductName,
    ProductNumber AS ProductNumber,
    Color
FROM Production.Product

------------------------------------ Get unique results------------------------------------------------
SELECT Color FROM Production.Product
SELECT DISTINCT Color FROM Production.Product

------------------------------------ Filtering - WHERE ------------------------------------------------
SELECT ListPrice,*
FROM Production.Product
WHERE ListPrice > 1000 

/*
> - greater than
< - less than
>= - greater than or equal to
<= - less than or equal to
<> - not equal to (!=)
= - equal
*/


------------------------------------ Filtering nulls ------------------------------------------------
SELECT Weight, *
FROM Production.Product
WHERE Weight >= 0

SELECT Weight, *
FROM Production.Product
WHERE Weight is null

------------------------------------ Negate condition ------------------------------------------------
SELECT *
FROM Production.Product
WHERE Color <> 'Red'


SELECT Color, *
FROM Production.Product
WHERE NOT Color = 'Red'

------------------------------------ Combining predicates ------------------------------------------------
SELECT Color, ListPrice, *
FROM Production.Product
WHERE ListPrice > 1000
    AND Color = 'Red'

SELECT Color, ListPrice, *
FROM Production.Product
WHERE ListPrice > 1000
    OR Color = 'Red'

SELECT Color, ListPrice, *
FROM Production.Product
WHERE ListPrice > 1000
    AND Color = 'Red'
    OR Color = 'Black' 

SELECT Color, ListPrice, *
FROM Production.Product
WHERE (ListPrice > 1000 AND Color = 'Red')
    OR Color = 'Black' 

SELECT Color, ListPrice, *
FROM Production.Product
WHERE ListPrice > 1000
    AND (Color = 'Red'
    OR Color = 'Black')

------------------------------------ Filtering strings------------------------------------------------
/*

% - none, one or more characters
_ - any single character
[<character list>] -single character from the list
[<character range>] - single character from the range
[^<character list or range>] - single character that is not in the list or range

*/

SELECT *
FROM Production.Product
WHERE Name LIKE 'B%'

SELECT *
FROM Production.Product
WHERE Name LIKE '%B'

SELECT *
FROM Production.Product
WHERE Name LIKE '%Lock%' 

SELECT *
FROM Production.Product
WHERE Name LIKE '%Road%Black%'

-- First character is anything
-- Second character is an L
-- Third character is a space
SELECT *
FROM Production.Product
WHERE Name LIKE '_L %'
 
-- First character is an M, H or L
-- Second character is an L
SELECT *
FROM Production.Product
WHERE Name LIKE '[MHL]L%'
 
-- First character is an A, B or C
SELECT *
FROM Production.Product
WHERE Name LIKE '[A-C]%'
 
-- First character is not an A, B or C
SELECT *
FROM Production.Product
WHERE Name LIKE '[^A-C]%'

------------------------------------ Filtering IN/BETWEEN ------------------------------------------------
--BETWEEN--
SELECT ListPrice, *
FROM Production.Product
WHERE ListPrice BETWEEN 100 AND 200

SELECT ListPrice, *
FROM Production.Product
WHERE ListPrice >= 100
    AND ListPrice <= 200

-- IN --
SELECT ProductModelID, *
FROM Production.Product
WHERE ProductModelID IN (15, 25, 30) 

SELECT ProductModelID, *
FROM Production.Product
WHERE ProductModelID = 15 OR ProductModelID = 25 OR ProductModelID = 30 

------------------------------------ Ordering------------------------------------------------
SELECT *
FROM Production.Product
ORDER BY [Name]

SELECT *
FROM Production.Product
ORDER BY [Name] DESC

-- ordering nulls
SELECT *
FROM Production.Product
ORDER BY Color

SELECT *
FROM Production.Product
ORDER BY Color DESC

-- multiple columns
SELECT *
FROM Production.Product
ORDER BY ListPrice asc, [Name]  desc

-- aliasing
SELECT
    Name,
    ProductNumber AS Number
FROM Production.Product
ORDER BY Number 

--error example
SELECT DISTINCT Color
FROM Production.Product
ORDER BY [Name] desc

--- order by column index
SELECT [Name], ProductNumber
FROM Production.Product
ORDER BY 1 desc

------------------------------------ Limiting results------------------------------------------------
SELECT TOP 10 *
FROM Production.Product 


SELECT TOP 10 *
FROM Production.Product
ORDER BY ListPrice DESC

SELECT TOP 10 WITH TIES *
FROM Production.Product
ORDER BY ListPrice DESC 

SELECT TOP 10 PERCENT *
FROM Production.Product
ORDER BY ListPrice DESC

--- OFFSET/FETCH -- great for paging

SELECT *
FROM Production.Product
ORDER BY ListPrice DESC
OFFSET 100 ROWS

SELECT *
FROM Production.Product
ORDER BY ListPrice DESC
OFFSET 100 ROWS 
FETCH NEXT 25 ROWS ONLY

SELECT *
FROM Production.Product
ORDER BY ListPrice DESC
OFFSET 0 ROWS 
FETCH FIRST 25 ROWS ONLY

-- FIRST = NEXT