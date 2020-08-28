USE [AdventureWorks2012]
GO
-- Change population of city whenever there is new address added.

SELECT * FROM  [3.6].[Addresses]
SELECT * FROM  [3.6].[City]
SELECT * FROM  [3.6].[Country]
SELECT * FROM  [3.6].[AdultPeople]	


CREATE TRIGGER [3.6].[iAddresses] ON [3.6].Addresses
AFTER INSERT AS 
BEGIN
    DECLARE @Count int;

    SET @Count = @@ROWCOUNT;
    IF @Count = 0 
    BEGIN
		PRINT 'No rows were affected.'
		RETURN;
	END
	
	UPDATE [3.6].City SET [Population] = [Population] +1 
	WHERE CityId = (SELECT CityId FROM inserted)
END

select * from [3.6].[Addresses] 
INSERT INTO [3.6].[Addresses] ([PersonId],[CityId],[AddressLine1],[AddressLine2],[RowCreationDate])
VALUES(16, 152, 'addressLine1','addressLine2',GETDATE())
select * from [3.6].City

