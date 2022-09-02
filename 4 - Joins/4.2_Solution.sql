SELECT
	 P.LastName AS Nazwisko
	,P.FirstName AS Imię
	,E.Gender AS Płeć
FROM
	Person.Person P 
	INNER JOIN HumanResources.Employee E ON P.BusinessEntityID = E.BusinessEntityID
WHERE
	E.Gender = 'F' -- F = Female = kobieta 