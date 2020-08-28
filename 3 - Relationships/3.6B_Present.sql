USE [AdventureWorks2012]
GO


-- Definition
RAISERROR                  
  (N'Exemplary Message', -- Message                  
  10, -- Severity.                  
  1); -- State.    

/*--------------------------- 
	SEVERITY
0–10 Informational messages
11–18 Errors
19–25 Fatal errors

	STATE
The state is an integer from 0 through 255. If you raise the same user-defined error at multiple locations, you can use a 
unique state number for each location 
to make it easier to find which section of the code is causing the errors. For most implementations, you can use 1.
-----------------------------*/
-- Let's learn new how to show exceptions and show log
RAISERROR ( 'Message situation', 9, 4 ) 
RAISERROR ( 'Bad situation', 15, 4 )
RAISERROR ( 'Very2 bad situation', 19, 4 ) 
RAISERROR ( 'Very2 bad situation', 19, 4 ) With log  

-- Let's check column definitions of AdultPeople
SELECT * FROM [3.6].AdultPeople


-- Let's make adultpeople table safe - not allow deletes
CREATE TRIGGER [3.6].[dAdultPeople] ON [3.6].AdultPeople
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
	  RAISERROR(N'Adult people cannot be deleted. They can only be marked as not alive.', 10, 1)
	
END

--Now let's try to delete exemplary person

DELETE FROM [3.6].AdultPeople where PersonId=20
SELECT * FROM [3.6].AdultPeople




