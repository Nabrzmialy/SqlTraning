USE [AdventureWorks2012]
GO


-- Change population of city whenever there is new address added.

SELECT * FROM  [3.6].[Addresses]
SELECT * FROM  [3.6].[City]
SELECT * FROM  [3.6].[Country]
SELECT * FROM  [3.6].[AdultPeople]	






INSERT INTO [3.6].[Addresses] ([PersonId],[CityId],[AddressLine1],[AddressLine2],[RowCreationDate])
VALUES(16, 5, 'addressLine1','addressLine2',GETDATE())