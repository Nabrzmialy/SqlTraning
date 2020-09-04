-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- WHAT IS TRANSACTION

BEGIN TRANSACTION

SELECT * FROM Person.Person WHERE BusinessEntityID = 69

UPDATE Person.Person
SET MiddleName = 'Donald'
WHERE BusinessEntityID = 69

SELECT * FROM Person.Person WHERE BusinessEntityID = 69

COMMIT TRANSACTION

----------------------------------------------------------------------------------------------------------------------------------
-- What if we do not want to apply our changes

BEGIN TRANSACTION

SELECT * FROM Person.Person WHERE BusinessEntityID = 69

UPDATE Person.Person
SET MiddleName = 'Lalalala'
WHERE BusinessEntityID = 69

SELECT * FROM Person.Person WHERE BusinessEntityID = 69

ROLLBACK TRANSACTION

SELECT * FROM Person.Person WHERE BusinessEntityID = 69

----------------------------------------------------------------------------------------------------------------------------------
-- Time for interesting update... with join
-- Let's update People Middle Name to type of phone  :-)

SELECT * FROM Person.PhoneNumberType

-- Let's take a look at our data
SELECT 
	p.BusinessEntityID,
	pp.PhoneNumber,
	pnt.[Name]
FROM Person.Person p
inner join Person.PersonPhone pp on p.BusinessEntityID = pp.BusinessEntityID
inner join Person.PhoneNumberType pnt on pp.PhoneNumberTypeID = pnt.PhoneNumberTypeID

-- update time
BEGIN TRAN

	UPDATE
	    person
	SET
	    person.MiddleName = pnt.[Name]
	FROM 
	    Person.Person person
	    inner join Person.PersonPhone pp on person.BusinessEntityID = pp.BusinessEntityID
		inner join Person.PhoneNumberType pnt on pp.PhoneNumberTypeID = pnt.PhoneNumberTypeID
	
	SELECT * FROM Person.Person

ROLLBACK TRAN