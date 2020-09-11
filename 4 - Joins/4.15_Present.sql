SELECT 
	soh.SalesOrderID,
	T.[Ilosc Przyczyn],
	soh.CustomerID as [Id Klienta],
	email.EmailAddress as [Email],
	K.[Liczba Telefonow],
	K.BusinessEntityID as [Id Osoby]
FROM Sales.SalesOrderHeader soh 
INNER join 
(
	SELECT 
		reason.SalesOrderID, 
		count(*) as [Ilosc Przyczyn]
	FROM Sales.SalesOrderHeaderSalesReason reason
	group by reason.SalesOrderID
	having count (*) > 1
) T ON soh.SalesOrderID = T.SalesOrderID
INNER JOIN Sales.Customer customer on customer.CustomerID = soh.CustomerID
INNER JOIN Person.Person person on customer.PersonID = person.BusinessEntityID
INNER JOIN Person.EmailAddress email on person.BusinessEntityID = email.BusinessEntityID
INNER JOIN 
(
	SELECT 
		person.BusinessEntityID, 
		count(phone.BusinessEntityID) as [Liczba Telefonow] 
	FROM Person.Person person
	LEFT JOIN Person.PersonPhone phone on person.BusinessEntityID = phone.BusinessEntityID
	GROUP BY person.BusinessEntityID
) K ON person.BusinessEntityID = K.BusinessEntityID
WHERE K.[Liczba Telefonow] = 0
----------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Let's extract part of the query into "separate block"
WITH CTE_OrdersWithNumberOfReasons AS
(
	SELECT 
		reason.SalesOrderID, 
		count(*) as [Ilosc Przyczyn]
	FROM Sales.SalesOrderHeaderSalesReason reason
	group by reason.SalesOrderID
)

SELECT * FROM CTE_OrdersWithNumberOfReasons

----------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Let's extract part of the query into "separate block" - column can be defined at CTE level
WITH CTE_OrdersWithNumberOfReasons ([SalesOrderID], [Ilosc Przyczyn]) AS
(
	SELECT 
		reason.SalesOrderID, 
		count(*)
	FROM Sales.SalesOrderHeaderSalesReason reason
	group by reason.SalesOrderID
)

SELECT * FROM CTE_OrdersWithNumberOfReasons

----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Let's use block in the query:

WITH CTE_OrdersWithNumberOfReasons AS
(
	SELECT 
		reason.SalesOrderID, 
		count(*) as [Ilosc Przyczyn]
	FROM Sales.SalesOrderHeaderSalesReason reason
	group by reason.SalesOrderID
)

SELECT 
	soh.SalesOrderID,
	T.[Ilosc Przyczyn],
	soh.CustomerID as [Id Klienta],
	email.EmailAddress as [Email],
	K.[Liczba Telefonow],
	K.BusinessEntityID as [Id Osoby]
FROM Sales.SalesOrderHeader soh 
INNER join CTE_OrdersWithNumberOfReasons T ON soh.SalesOrderID = T.SalesOrderID
INNER JOIN Sales.Customer customer on customer.CustomerID = soh.CustomerID
INNER JOIN Person.Person person on customer.PersonID = person.BusinessEntityID
INNER JOIN Person.EmailAddress email on person.BusinessEntityID = email.BusinessEntityID
INNER JOIN 
(
	SELECT 
		person.BusinessEntityID, 
		count(phone.BusinessEntityID) as [Liczba Telefonow] 
	FROM Person.Person person
	LEFT JOIN Person.PersonPhone phone on person.BusinessEntityID = phone.BusinessEntityID
	GROUP BY person.BusinessEntityID
) K ON person.BusinessEntityID = K.BusinessEntityID
WHERE K.[Liczba Telefonow] = 0 AND T.[Ilosc Przyczyn] > 1

----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Let's use 2nd block in the query:

WITH 
CTE_OrdersWithNumberOfReasons AS
(
	SELECT 
		reason.SalesOrderID, 
		count(*) as [Ilosc Przyczyn]
	FROM Sales.SalesOrderHeaderSalesReason reason
	group by reason.SalesOrderID
),
CTE_PeopleWithNoOfPhones AS
(
	SELECT 
		person.BusinessEntityID, 
		count(phone.BusinessEntityID) as [Liczba Telefonow] 
	FROM Person.Person person
	LEFT JOIN Person.PersonPhone phone on person.BusinessEntityID = phone.BusinessEntityID
	GROUP BY person.BusinessEntityID
)

SELECT 
	soh.SalesOrderID,
	T.[Ilosc Przyczyn],
	soh.CustomerID as [Id Klienta],
	email.EmailAddress as [Email],
	K.[Liczba Telefonow],
	K.BusinessEntityID as [Id Osoby]
FROM Sales.SalesOrderHeader soh 
INNER join CTE_OrdersWithNumberOfReasons T ON soh.SalesOrderID = T.SalesOrderID
INNER JOIN Sales.Customer customer on customer.CustomerID = soh.CustomerID
INNER JOIN Person.Person person on customer.PersonID = person.BusinessEntityID
INNER JOIN Person.EmailAddress email on person.BusinessEntityID = email.BusinessEntityID
INNER JOIN CTE_PeopleWithNoOfPhones K ON person.BusinessEntityID = K.BusinessEntityID
WHERE K.[Liczba Telefonow] = 0 AND T.[Ilosc Przyczyn] > 1

----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- We can put all query into CTE --

WITH 
CTE_OrdersWithNumberOfReasons AS
(
	SELECT 
		reason.SalesOrderID, 
		count(*) as [Ilosc Przyczyn]
	FROM Sales.SalesOrderHeaderSalesReason reason
	group by reason.SalesOrderID
),
CTE_PeopleWithNoOfPhones AS
(
	SELECT 
		person.BusinessEntityID, 
		count(phone.BusinessEntityID) as [Liczba Telefonow] 
	FROM Person.Person person
	LEFT JOIN Person.PersonPhone phone on person.BusinessEntityID = phone.BusinessEntityID
	GROUP BY person.BusinessEntityID
),
CTE_Result AS
(
	SELECT 
		soh.SalesOrderID,
		T.[Ilosc Przyczyn],
		soh.CustomerID as [Id Klienta],
		email.EmailAddress as [Email],
		K.[Liczba Telefonow],
		K.BusinessEntityID as [Id Osoby]
	FROM Sales.SalesOrderHeader soh 
	INNER join CTE_OrdersWithNumberOfReasons T ON soh.SalesOrderID = T.SalesOrderID
	INNER JOIN Sales.Customer customer on customer.CustomerID = soh.CustomerID
	INNER JOIN Person.Person person on customer.PersonID = person.BusinessEntityID
	INNER JOIN Person.EmailAddress email on person.BusinessEntityID = email.BusinessEntityID
	INNER JOIN CTE_PeopleWithNoOfPhones K ON person.BusinessEntityID = K.BusinessEntityID
)

SELECT * FROM CTE_Result res
WHERE res.[Liczba Telefonow] = 0 AND res.[Ilosc Przyczyn] > 1