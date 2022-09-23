CREATE VIEW [4.21].Solution AS 

	WITH CTE_Person AS 
	(
		SELECT 
			p.BusinessEntityID as [Id Osoby],
			p.FirstName + ' ' + p.LastName as [Godnosc]
		FROM Person.Person p
	),
	CTE_Phone AS
	(
		SELECT 
			pp.BusinessEntityID as [Id Osoby],
			pp.PhoneNumber as [Numer Telefonu],
			[type].Name as [Typ Telefonu]
		FROM Person.PersonPhone pp
		INNER JOIN Person.PhoneNumberType [type] on pp.PhoneNumberTypeID = [type].PhoneNumberTypeID
	),
	CTE_Email AS
	(
		SELECT 
			ea.BusinessEntityID as [Id Osoby],
			ea.EmailAddress as [Adres Email]
		FROM Person.EmailAddress ea
	)
	
	SELECT 
		p.[Id Osoby],
		phone.[Numer Telefonu],
		phone.[Typ Telefonu],
		email.[Adres Email]
	FROM CTE_Person p
	INNER JOIN CTE_Phone phone on p.[Id Osoby] = phone.[Id Osoby]
	INNER JOIN CTE_Email email on p.[Id Osoby] = email.[Id Osoby]


	SELECT * FROM [4.21].Solution
