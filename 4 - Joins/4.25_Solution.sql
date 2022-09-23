DROP VIEW MaterializedView

CREATE VIEW MaterializedView
WITH SCHEMABINDING
AS
(
	SELECT 
		soh.SalesOrderID,
		soh.CustomerID as [Id Klienta],
		email.EmailAddress as [Email]
	FROM Sales.SalesOrderHeader soh 
	INNER JOIN Sales.Customer customer on customer.CustomerID = soh.CustomerID
	INNER JOIN Person.Person person on customer.PersonID = person.BusinessEntityID
	INNER JOIN Person.EmailAddress email on person.BusinessEntityID = email.BusinessEntityID
)


CREATE UNIQUE CLUSTERED INDEX 
    MaterializedView
ON dbo.MaterializedView(SalesOrderID);


SELECT 
		soh.SalesOrderID,
		soh.CustomerID as [Id Klienta],
		email.EmailAddress as [Email]
	FROM Sales.SalesOrderHeader soh 
	INNER JOIN Sales.Customer customer on customer.CustomerID = soh.CustomerID
	INNER JOIN Person.Person person on customer.PersonID = person.BusinessEntityID
	INNER JOIN Person.EmailAddress email on person.BusinessEntityID = email.BusinessEntityID

SELECT SalesOrderID FROM MaterializedView 

SELECT SalesOrderID FROM MaterializedView WITH (NOEXPAND)
