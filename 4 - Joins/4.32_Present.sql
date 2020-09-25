CREATE OR ALTER FUNCTION [dbo].[ufnGetOrdersByNumberOfReason](@ReasonNo int)
RETURNS TABLE 
AS 
RETURN
(
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
		having count (*) = @ReasonNo
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
)


SELECT * FROM [dbo].[ufnGetOrdersByNumberOfReason](0)