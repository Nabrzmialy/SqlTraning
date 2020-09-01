-- PREPARE DATA --




































CREATE DATABASE [SupplierPortal]
GO

USE [SupplierPortal]
GO

CREATE SCHEMA [Som]
GO

CREATE TABLE [Som].[Supplier](
	[IdSupplier] [int] NOT NULL PRIMARY KEY,
	[NameSupplier] [nvarchar](255) NULL,
	[DateCreation] [datetime2](7) NULL
) ON [PRIMARY]
GO

ALTER TABLE [Som].[Supplier] ADD  DEFAULT (getdate()) FOR [DateCreation]
GO

DELETE FROM SupplierPortal.som.Supplier

INSERT INTO SupplierPortal.som.Supplier (idSupplier, nameSupplier, dateCreation)
VALUES (1, 'Coca-Cola', GETDATE())
INSERT INTO SupplierPortal.som.Supplier (idSupplier, nameSupplier, dateCreation)
VALUES (2, 'Sprite', GETDATE())
INSERT INTO SupplierPortal.som.Supplier (idSupplier, nameSupplier, dateCreation)
VALUES (3, 'Adidas', GETDATE())
INSERT INTO SupplierPortal.som.Supplier (idSupplier, nameSupplier, dateCreation)
VALUES (4, 'Nike', GETDATE())
INSERT INTO SupplierPortal.som.Supplier (idSupplier, nameSupplier, dateCreation)
VALUES (5, 'Fortuna', GETDATE())
INSERT INTO SupplierPortal.som.Supplier (idSupplier, nameSupplier, dateCreation)
VALUES (6, 'Hortex', GETDATE())
INSERT INTO SupplierPortal.som.Supplier (idSupplier, nameSupplier, dateCreation)
VALUES (7, 'Coca-Cola', GETDATE())
INSERT INTO SupplierPortal.som.Supplier (idSupplier, nameSupplier, dateCreation)
VALUES (8, 'Wedel', GETDATE())
INSERT INTO SupplierPortal.som.Supplier (idSupplier, nameSupplier, dateCreation)
VALUES (9, 'Wawel', GETDATE())
INSERT INTO SupplierPortal.som.Supplier (idSupplier, nameSupplier, dateCreation)
VALUES (10, 'Unimil', GETDATE())
INSERT INTO SupplierPortal.som.Supplier (idSupplier, nameSupplier, dateCreation)
VALUES (11, 'EXTREMELY IMPORTANT SUPPLIER!!!', GETDATE())

CHECKPOINT;

---UPDATE SupplierPortal.som.Supplier
---SET nameSupplier = 'EXTREMELY IMPORTANT SUPPLIER!!!'
---where idSupplier =11

ALTER DATABASE [SupplierPortal] SET TARGET_RECOVERY_TIME = 3000 MINUTES

CHECKPOINT;

SELECT * FROM SupplierPortal.som.Supplier order by idSupplier
