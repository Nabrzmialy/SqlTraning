SET STATISTICS TIME ON
-- MK - 1.15 - 93ms cpu - 167ms- all

EXEC [4.13].[Solution]

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



-- Maciek Kuśmierzak - 1.35 - cpu 63ms - all 121ms
select
	t.*,
	soh.CustomerID,
	ea.EmailAddress,
	0 as LiczbaTelefonow,
	c.PersonID
from sales.SalesOrderHeader soh
inner join
(
	select sohsr.SalesOrderID, count(sohsr.SalesOrderID) as Reasons from sales.SalesOrderHeaderSalesReason sohsr
	group by sohsr.SalesOrderID
) as t on t.SalesOrderID = soh.SalesOrderID
inner join sales.Customer c on c.CustomerID = soh.CustomerID
left join person.EmailAddress ea on c.PersonID = ea.BusinessEntityID
where not exists (select 1 from person.PersonPhone pp where pp.BusinessEntityID = c.PersonID)

-- Bartek -- 1.14

SELECT T1.*, soh.CustomerID AS 'Id Klienta',
pea.EmailAddress AS 'Email',
'0' AS 'Liczba Telefonow',
p.BusinessEntityID AS 'Id Osoby'
FROM Sales.SalesOrderHeader soh
INNER JOIN
(
	SELECT sohr.SalesOrderID, COUNT(sohr.SalesOrderID)  AS 'Ilosc przyczyn'
	FROM Sales.SalesOrderHeaderSalesReason sohr
	GROUP BY sohr.SalesOrderID
	HAVING (COUNT(sohr.SalesOrderID) > 1)
) T1 ON soh.SalesOrderID = T1.SalesOrderID
JOIN Sales.Customer c ON c.CustomerID = soh.CustomerID
JOIN Person.Person p ON p.BusinessEntityID = c.PersonID
JOIN Person.EmailAddress pea ON pea.BusinessEntityID = p.BusinessEntityID
WHERE p.BusinessEntityID NOT IN(
	SELECT BusinessEntityID
	FROM Person.PersonPhone
)

-- Pawel - 1.86

SELECT
	soh.SalesOrderID,
	R.[Liczba przyczyn],
	soh.CustomerId as [Id klienta],
	e.EmailAddress,
	C.[Liczba numerow telefonu],
	pers.BusinessEntityID as [Id Osoby]
FROM
	Sales.SalesOrderHeader soh
	INNER JOIN
	(
		SELECT
			SalesOrderID,
			COUNT(SalesReasonID) as [Liczba przyczyn]
		FROM
			Sales.SalesOrderHeaderSalesReason
		GROUP BY
			SalesOrderID
		HAVING
			COUNT(SalesReasonID) > 1
	) R ON soh.SalesOrderID = R.SalesOrderID
	INNER JOIN
	(
		SELECT
			c.CustomerID,
			COUNT(pn.PhoneNumber) as [Liczba numerow telefonu]
		FROM
			Sales.Customer c
			LEFT JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
			LEFT JOIN Person.PersonPhone pn ON  p.BusinessEntityID =  pn.BusinessEntityID
		GROUP BY
			c.CustomerID
		HAVING COUNT(pn.PhoneNumber) = 0
	) C ON soh.CustomerID = C.CustomerID
	INNER JOIN Sales.Customer cust ON soh.CustomerID = cust.CustomerID
	INNER JOIN Person.Person pers ON cust.PersonID = pers.BusinessEntityID
	INNER JOIN Person.EmailAddress e ON e.BusinessEntityID = pers.BusinessEntityID


-- Artur -- 1.12

SELECT
	--soh.SalesOrderID ,
	soh.CustomerID as [Id klienta],
	C.PersonID as [Id Osoby],
	PEA.EmailAddress,
	T.* ,
	T2.[Liczba Telefonow]
FROM [Sales].SalesOrderHeader soh
INNER JOIN
(
	Select
	SalesOrderID,
	COUNT(sor.SalesReasonID) as [Ilosc Przyczyn]
	from Sales.SalesOrderHeaderSalesReason sor
	
	GROUP BY sor.SalesOrderID
	HAVING (COUNT(sor.SalesReasonID) > 1)
) T ON soh.SalesOrderID = T.SalesOrderID
INNER JOIN [Sales].Customer C on soh.CustomerId = C.CustomerID
INNER JOIN Person.Person P on C.PersonID = P.BusinessEntityID
INNER JOIN Person.EmailAddress PEA on P.BusinessEntityID = PEA.BusinessEntityID
INNER JOIN
(
	SELECT
		p2.BusinessEntityID,
		count(phone.BusinessEntityID) as [Liczba Telefonow]
	FROM Person.Person p2
	LEFT JOIN Person.PersonPhone phone on p2.BusinessEntityID = phone.BusinessEntityID
	GROUP BY p2.BusinessEntityID
) T2 ON P.BusinessEntityID = T2.BusinessEntityID
where
C.PersonID is not null
AND
T2.[Liczba Telefonow] = 0
-- order by soh.SalesOrderID


-- bartek lepsza wersja: - 0.72

SELECT T1.*, soh.CustomerID AS 'Id Klienta',
pea.EmailAddress AS 'Email',
'0' AS 'Liczba Telefonow',
pea.BusinessEntityID AS 'Id Osoby'
FROM Sales.SalesOrderHeader soh
INNER JOIN
(
	SELECT sohr.SalesOrderID, COUNT(sohr.SalesOrderID)  AS 'Ilosc przyczyn'
	FROM Sales.SalesOrderHeaderSalesReason sohr
	GROUP BY sohr.SalesOrderID
	HAVING (COUNT(sohr.SalesOrderID) > 1)
) T1 ON soh.SalesOrderID = T1.SalesOrderID
JOIN Sales.Customer c ON c.CustomerID = soh.CustomerID
JOIN Person.EmailAddress pea ON pea.BusinessEntityID = c.PersonID
WHERE pea.BusinessEntityID NOT IN(
	SELECT BusinessEntityID
	FROM Person.PersonPhone
)



SELECT soh.SalesOrderID, soh.CustomerID, T.CountSalesReason, p.BusinessEntityID, cu.PersonID, pp.PhoneNumber, ea.EmailAddress FROM Sales.SalesOrderHeader soh
INNER JOIN
(SELECT sohsr.SalesOrderID, COUNT(sohsr.SalesReasonID) as CountSalesReason FROM Sales.SalesOrderHeaderSalesReason sohsr
GROUP BY sohsr.SalesOrderID
HAVING COUNT(sohsr.SalesReasonID) > 1 ) T ON T.SalesOrderID = soh.SalesOrderID
INNER JOIN Sales.Customer cu ON  cu.CustomerID = soh.CustomerID
INNER JOIN Person.Person p ON p.BusinessEntityID = cu.PersonID
LEFT JOIN Person.PersonPhone pp ON pp.BusinessEntityID = cu.PersonID
INNER JOIN Person.EmailAddress ea ON ea.BusinessEntityID = cu.PersonID
WHERE pp.PhoneNumber is null



