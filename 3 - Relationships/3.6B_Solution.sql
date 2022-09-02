USE [AdventureWorks2012]
GO

CREATE TRIGGER [3.6].[dCity] ON [3.6].City
INSTEAD OF DELETE AS 
BEGIN
    DECLARE @Count int;

    SET @Count = @@ROWCOUNT;
    IF @Count = 0 
    BEGIN
		PRINT 'No rows were affected.'
		RETURN;
	END

	 DECLARE @DeleteCount int = (SELECT COUNT(*) FROM deleted)          
	 IF @DeleteCount > 0      
	  RAISERROR(N'Cities can be destroyed not deleted.', 10, 1)
	
END

DELETE FROM [3.6].City where CityId=5
SELECT * FROM [3.6].City




