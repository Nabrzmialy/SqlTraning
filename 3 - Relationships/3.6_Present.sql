USE [AdventureWorks2012]
GO

-- Let's calculate population of new country
SELECT * FROM [3.6].AdultPeople
SELECT * FROM [3.6].Country

-- @@ROWCOUNT - returns number of affecter rows after last operation:
INSERT INTO [3.6].[AdultPeople]
VALUES ('Alina', 'Wiejska', '1923-07-02 19:29:40.000', '23070261134', 1, GETDATE())	
SELECT @@ROWCOUNT -- returns 1

UPDATE [3.6].[AdultPeople] set [Name] = 'Lalalal' where PersonId = -1
SELECT @@ROWCOUNT -- returns 0

-- Trigger creation

CREATE TRIGGER [3.6].[iAdultPeople] ON [3.6].AdultPeople
AFTER INSERT, UPDATE AS 
BEGIN
    DECLARE @Count int;

    SET @Count = @@ROWCOUNT;
    IF @Count = 0 
    BEGIN
		PRINT 'No rows were affected.'
		RETURN;
	END

	SELECT 'Inserted' as [Operation], * FROM inserted
	SELECT 'Deleted' as [Operation], * FROM deleted

	
END

--Now let's check how behaves inserted and deleted when performing insert/update
INSERT INTO [3.6].[AdultPeople]
VALUES ('Zbyszek', 'Leśny', '1990-11-02 19:29:40.000', '90110261134', 1, GETDATE(), 1)	

UPDATE [3.6].[AdultPeople] SET IsAlive = 0 where PersonId = 1

-- Remove trigger and calculate population of country
DROP TRIGGER [3.6].[iAdultPeople]

CREATE TRIGGER [3.6].[iAdultPeople] ON [3.6].AdultPeople
AFTER INSERT AS 
BEGIN
    DECLARE @Count int;

    SET @Count = @@ROWCOUNT;
    IF @Count = 0 
    BEGIN
		PRINT 'No rows were affected.'
		RETURN;
	END
	
	UPDATE [3.6].Country SET [Population] = [Population] +1 
	WHERE CountryId = (SELECT NationalityId FROM inserted)
END

-- Check the behavior of our table
INSERT INTO [3.6].[AdultPeople]
VALUES ('Ania', 'Ziemna', '1933-11-02 19:29:40.000', '33110261134', 152, GETDATE(), 1)	

SELECT * FROM [3.6].[AdultPeople]
SELECT * FROM [3.6].[Country]

