/* 
	
	Introduce 3 CTE tables for:
	a) CTE_Person for Person details
		- Id Osoby
		- Godnosc (FirstName + ' ' + LastName)
	b) CTE_Phone
		- Id Osoby
		- Numer Telefonu
		- Typ Telefonu
	c) CTE_Email
		- Id Osoby
		- Adres Email

*/




SELECT 
	p.[Id Osoby],
	p.[Godnosc],
	phone.[Numer Telefonu],
	phone.[Typ Telefonu],
	email.[Adres Email]
FROM CTE_Person p
INNER JOIN CTE_Phone phone on p.[Id Osoby] = phone.[Id Osoby]
INNER JOIN CTE_Email email on p.[Id Osoby] = email.[Id Osoby]

-----------------------------------------------------------------------------------------------------------------------------
EXEC [4.16].Solution