USE [AdventureWorks2012]
GO

select * from [3.6].Country
select * from [3.6].AdultPeople






CREATE TRIGGER [3.6].[uAdultPeople] ON [3.6].AdultPeople
AFTER UPDATE AS 
BEGIN
    DECLARE @Count int;

    SET @Count = @@ROWCOUNT;
    IF @Count = 0 
    BEGIN
		RETURN;
	END

	IF NOT UPDATE(IsAlive)
		RETURN;

	DECLARE @OldValue INT = (SELECT IsAlive FROM deleted)
	DECLARE @NewValue INT = (SELECT IsAlive FROM inserted)

	IF(@OldValue <> @NewValue)
	BEGIN
		IF(@NewValue = 1)
		BEGIN
			UPDATE [3.6].Country SET [Population] = [Population] + 1 
			WHERE CountryId = (SELECT NationalityId FROM inserted)
		END
		IF(@NewValue = 0)
		BEGIN
			UPDATE [3.6].Country SET [Population] = [Population] - 1 
			WHERE CountryId = (SELECT NationalityId FROM inserted)
		END
	END
END



