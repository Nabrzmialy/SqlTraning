USE [AdventureWorks2012]
GO

-- 1. Take a look at the name of created primary key. --
BEGIN
	CREATE TABLE [dbo].[Country](
		[CountryId] int NOT NULL PRIMARY KEY,
		[Name] nvarchar(100) NOT NULL,
		[Population] bigint NOT NULL,
		[ModifiedDate] datetime2 NULL,
		[Iso] nvarchar(2) NOT NULL,
		[Description] nvarchar(max) NULL
	)
END

BEGIN
	DROP TABLE dbo.Country
END
-- 1. --

-- 2. Take a look at the name of created primary key. --
BEGIN
	CREATE TABLE [dbo].[Country](
		[CountryId] [int] NOT NULL,
		[Name] nvarchar(100) NOT NULL,
		[Population] bigint NOT NULL,
		[ModifiedDate] datetime2 NULL,
		[Iso] nvarchar(2) NOT NULL,
		[Description] nvarchar(max) NULL
	 CONSTRAINT [PK_Country_CountryId] PRIMARY KEY ( [CountryId] )
	)
END
DROP TABLE dbo.Country
-- 2 --

-- 3. Try to make primary key nullable. --
BEGIN
	CREATE TABLE [dbo].[Country](
		[CountryId] [int] NOT NULL IDENTITY(1,1),
		[Name] nvarchar(100) NOT NULL,
		[Population] bigint NOT NULL,
		[ModifiedDate] datetime2 NULL,
		[Iso] nvarchar(2) NOT NULL,
		[Description] nvarchar(max) NULL
	 CONSTRAINT [PK_Country_CountryId] PRIMARY KEY ( [CountryId] )
	)
END
-- 3 --

-- 4. Fill country with data --
INSERT INTO dbo.Country ([Name], [Population], [ModifiedDate], [Iso])
VALUES ('Poland', 38000000, GETDATE(), 'PL')
INSERT INTO dbo.Country ([Name], [Population], [ModifiedDate], [Iso])
VALUES ('France', 67990000, GETDATE(), 'FR')
INSERT INTO dbo.Country ([Name], [Population], [ModifiedDate], [Iso])
VALUES ('Hungary', 9730000, GETDATE(), 'HU')

select * from dbo.Country

-- 4.-- Create table and foreign key. Not possible to add entry out of keys.

CREATE TABLE [dbo].[CapitalCity](
		[CountryId] int NOT NULL,
		[Name] nvarchar(100) NOT NULL,
		CONSTRAINT PK_CapitalCity_CountryId PRIMARY KEY ([CountryId] ASC),
		CONSTRAINT FK_CapitalCity_Country_CountryId FOREIGN KEY (CountryId) REFERENCES dbo.Country (CountryId)
	)

INSERT INTO dbo.CapitalCity ([CountryId], [Name])
VALUES (1, 'Warsaw')
INSERT INTO dbo.CapitalCity ([CountryId], [Name])
VALUES (2, 'Paris')
INSERT INTO dbo.CapitalCity ([CountryId], [Name])
VALUES (3, 'Budapest')
INSERT INTO dbo.CapitalCity ([CountryId], [Name])
VALUES (4, 'Berlin')
-- 4.--



--5. -- show drop order
DROP TABLE dbo.CapitalCity
GO
DROP TABLE dbo.Country
GO






