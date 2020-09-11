BEGIN TRAN;       

UPDATE Production.Location
SET [Name] = 'Tool Crib_X'
WHERE LocationID = 1

UPDATE Production.Product
SET [Name] = 'Adjustable Race_X'
WHERE ProductID = 1