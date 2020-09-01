--Prepare data--







































USE SupplierPortal
GO

CREATE LOGIN Hulk
WITH PASSWORD = 'password'
GO

CREATE USER [Hulk] FOR LOGIN [Hulk] WITH DEFAULT_SCHEMA=[dbo]
GO

EXEC sp_addrolemember N'db_owner', N'Hulk'
GO

CREATE LOGIN ArnoldSchwarzenegger
WITH PASSWORD = 'password'

CREATE USER [ArnoldSchwarzenegger] FOR LOGIN [ArnoldSchwarzenegger] WITH DEFAULT_SCHEMA=[dbo]
GO

EXEC sp_addrolemember N'db_owner', N'ArnoldSchwarzenegger'
GO

CREATE LOGIN MichalKoziol
WITH PASSWORD = 'password'

CREATE USER [MichalKoziol] FOR LOGIN [MichalKoziol] WITH DEFAULT_SCHEMA=[dbo]
GO

EXEC sp_addrolemember N'db_owner', N'MichalKoziol'
GO

-- HULK SCRIPT START --
EXECUTE AS LOGIN = 'Hulk';  

DELETE FROM SupplierPortal.som.Supplier
WHERE nameSupplier = 'EXTREMELY IMPORTANT SUPPLIER!!!'
REVERT;  
-- HULK SCRIPT END --

-- ARNOLD SCRIPT START --
EXECUTE AS LOGIN = 'ArnoldSchwarzenegger';  

UPDATE SupplierPortal.som.Supplier SET nameSupplier = 'I AM THE STRONGEST'
WHERE idSupplier <= 10
REVERT;  
-- ARNOLD SCRIPT END --

-- MICHAL SCRIPT START --
EXECUTE AS LOGIN = 'MichalKoziol';  


INSERT INTO SupplierPortal.som.Supplier (idSupplier, nameSupplier)
VALUES (999999, 'I am the master of masters!')
REVERT;  
-- MICHAL SCRIPT END --


SELECT * FROM SupplierPortal.som.Supplier ORDER BY idSupplier


