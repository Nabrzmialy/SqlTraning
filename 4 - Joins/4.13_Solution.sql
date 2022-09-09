/* 
	Show 
	a) all orders with more than 1 sales reasons + assigned to clients who has 0 phones numbers
	b) show email of such customer

	Tables to use: 
	a) Sales.SalesOrderHeader
	b) Sales.SalesOrderHeaderSalesReason
	c) Sales.Customer
	d) Person.Person
	e) Person.EmailAddress
	f) Person.PersonPhone

*/
SET STATISTICS TIME ON
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



select 
	ssoh.SalesOrderID, 
	count(ssohsr.SalesOrderID) as [Ilosc przyczyn], 
	ssoh.CustomerID as [Id Klienta],
	pea.EmailAddress as [Email], 
	count(ppp.PhoneNumber) as [Liczba Telefonow], 
	so.PersonID as [Id Osoby]
from Sales.SalesOrderHeader ssoh
inner join Sales.SalesOrderHeaderSalesReason ssohsr on ssoh.SalesOrderID = ssohsr.SalesOrderID
inner join Sales.Customer so on so.CustomerID = ssoh.CustomerID
inner join Person.Person pp on so.PersonID = pp.BusinessEntityID
inner join Person.EmailAddress pea on pea.BusinessEntityID = pp.BusinessEntityID
left join Person.PersonPhone ppp on ppp.BusinessEntityID = pp.BusinessEntityID
group by ssoh.SalesOrderID, ssohsr.SalesOrderID, ssoh.CustomerID, so.PersonID, pea.EmailAddress
having count(ppp.BusinessEntityID) = 0 and count(ssohsr.SalesOrderID) > 1

select * from Person.EmailAddress