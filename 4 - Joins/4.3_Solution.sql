SELECT
	 P.LastName AS Nazwisko
	,P.FirstName AS Imię
	,P.MiddleName AS [Drugie Imię]
	,E.Gender AS Płeć
	,E.BirthDate as [Data Urodzenia]
FROM
	Person.Person P 
	LEFT JOIN HumanResources.Employee E ON P.BusinessEntityID = E.BusinessEntityID
WHERE
	(P.MiddleName is not null)
	OR
	(E.BirthDate > '1960-01-01' and E.BusinessEntityID is not null)
ORDER BY E.BirthDate DESC
