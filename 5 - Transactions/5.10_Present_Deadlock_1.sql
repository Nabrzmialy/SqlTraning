﻿BEGIN TRAN;           
---------------------------------------------------------------
							--| BEGIN TRAN;
----------------------------------------------------------------
UPDATE Production.Product
SET [Name] = 'Adjustable Race_X'
WHERE ProductID = 1
------------------------------------------------------------------
                             --| UPDATE ##Suppliers
                             --| SET Fax = N'555-1212'
                             --| WHERE SupplierId = 1
------------------------------------------------------------------
UPDATE Production.Location
SET [Name] = 'Tool Crib_X'
WHERE LocationID = 1

----------------------------------------------------------------
<blocked>                    --| UPDATE ##Employees
                             --| SET Phone = N'555-9999'
                             --| WHERE EmpId = 1
--------------------------------------------------------------------
                             | <blocked>
----------------------------------------------------------------------

