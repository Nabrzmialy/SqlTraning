--- Simple transaction
BEGIN TRANSACTION

	SELECT * FROM Person.Person WHERE BusinessEntityID = 69
	
	UPDATE Person.Person
	SET MiddleName = 'Lalalala'
	WHERE BusinessEntityID = 69
	
	SELECT * FROM Person.Person WHERE BusinessEntityID = 69

ROLLBACK TRANSACTION



--- Multiple transactions

-- function that returns number of opened transactions in current connection
SELECT @@trancount

BEGIN TRANSACTION FIRST_ONE

	BEGIN TRANSACTION SECOND_ONE

	UPDATE Person.Person
	SET MiddleName = 'moppp88'
	WHERE BusinessEntityID = 69

	SELECT 'From Second_One:', FirstName, LastName, MiddleName FROM Person.Person WHERE BusinessEntityID = 69
	
	--COMMIT TRANSACTION SECOND_ONE

	ROLLBACK TRANSACTION SECOND_ONE
	
	UPDATE Person.Person
	SET MiddleName = 'Lalalala45'
	WHERE BusinessEntityID = 69
	
	SELECT 'From FIRST_ONE:', FirstName, LastName, MiddleName FROM Person.Person WHERE BusinessEntityID = 69

COMMIT TRANSACTION FIRST_ONE


-- what happens for rollback
SELECT @@trancount
BEGIN TRANSACTION FIRST_ONE

	BEGIN TRANSACTION SECOND_ONE

	UPDATE Person.Person
	SET MiddleName = 'moppp88'
	WHERE BusinessEntityID = 69

	SELECT 'From Second_One:', FirstName, LastName, MiddleName FROM Person.Person WHERE BusinessEntityID = 69
	
	ROLLBACK TRANSACTION SECOND_ONE

	UPDATE Person.Person
	SET MiddleName = 'Lalalala45'
	WHERE BusinessEntityID = 69
	
	SELECT 'From FIRST_ONE:', FirstName, LastName, MiddleName FROM Person.Person WHERE BusinessEntityID = 69

COMMIT TRANSACTION FIRST_ONE


