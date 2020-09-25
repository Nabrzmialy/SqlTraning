CREATE OR ALTER FUNCTION [dbo].ufnNumberOfLetterA(@RandomText nvarchar(100))
   RETURNS INT AS 
   BEGIN
	DECLARE @Initial INT = 0;
	DECLARE @After INT = 0;

	SET @Initial = LEN(@RandomText)
	SET @After = LEN((REPLACE(@RandomText, 'A', '')))

	RETURN @Initial - @AFTER
   END
GO

SELECT [dbo].ufnNumberOfLetterA('AAAafffaa')
SELECT [dbo].ufnNumberOfLetterA('AAAaaa')
