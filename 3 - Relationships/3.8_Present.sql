-- Let's check how UPDATE(column_name) works

CREATE TRIGGER [3.6].[DeleteMe_AdultPeople] ON [3.6].AdultPeople
AFTER UPDATE AS 
BEGIN
    DECLARE @Count int;

    SET @Count = @@ROWCOUNT;
    IF @Count = 0 
    BEGIN
		PRINT 'No rows were affected.'
		RETURN;
	END

	IF UPDATE([Name])
		PRINT 'Name was updated'
END

-- Let's check what happens when we try to update
select * FROM [3.6].AdultPeople
UPDATE [3.6].AdultPeople set Name = 'Johny' WHERE PersonId = 1
UPDATE [3.6].AdultPeople set Name = 'Johnny' WHERE PersonId = 1

UPDATE [3.6].AdultPeople set Surname = 'Bravo' WHERE PersonId = 1


