USE [AdventureWorks2012]
GO

-- PREPARE Present --
DROP TABLE dbo.Country
DROP TABLE dbo.[CapitalCity]
-- PREPARE Present --

-- Let's find constraints --
CREATE TABLE [dbo].[Country](
	[CountryId] [int] NOT NULL IDENTITY(1,1),
	[Name] nvarchar(100) NOT NULL,
	[Population] bigint NOT NULL,
	[ModifiedDate] datetime2 NULL 
		/*DEFAULT (GETDATE())*/ 
		/*CONSTRAINT [DF_Country_ModifiedDate] DEFAULT GETDATE()*/,
	[Iso] nvarchar(2) NOT NULL,
	[Description] nvarchar(max) NULL
 CONSTRAINT [PK_Country_CountryId] PRIMARY KEY ( [CountryId] )
)

CREATE TABLE [dbo].[CapitalCity](
		[CountryId] int NOT NULL,
		[Name] nvarchar(100) NOT NULL,
		CONSTRAINT PK_CapitalCity_CountryId PRIMARY KEY ([CountryId] ASC),
		CONSTRAINT FK_CapitalCity_Country_CountryId FOREIGN KEY (CountryId) REFERENCES dbo.Country (CountryId)
	)
-- END Let's find constraints --

-- Take a look at deafult value constraint value -- remove default from create

ALTER TABLE [dbo].[Country] ADD CONSTRAINT [DF_Country_ModifiedDate]  DEFAULT ((GETDATE())) FOR [ModifiedDate];
ALTER TABLE [dbo].[Country] WITH CHECK ADD CONSTRAINT [CK_Country_Population] CHECK  ([Population] > 0 )
ALTER TABLE [dbo].[Country] WITH CHECK ADD CONSTRAINT [CK_Country_Iso] CHECK (LEN([Iso]) = 2 )
ALTER TABLE [dbo].[Country] ADD CONSTRAINT [UC_Country_Iso] UNIQUE (Iso);

INSERT INTO dbo.Country ([Name], [Population], [ModifiedDate], [Iso])
VALUES ('Poland', 38000000, GETDATE(), 'PL')


--INSERT INTO dbo.Country ([Name], [Population], [ModifiedDate], [Iso])
--VALUES ('Poland', 38000000, GETDATE(), 'PL')
--INSERT INTO dbo.Country ([Name], [Population], [ModifiedDate], [Iso])
--VALUES ('France', 67990000, GETDATE(), 'FR')
--INSERT INTO dbo.Country ([Name], [Population], [ModifiedDate], [Iso])
--VALUES ('Hungary', 9730000, GETDATE(), 'HU')

--INSERT INTO dbo.CapitalCity ([CountryId], [Name])
--VALUES (1, 'Warsaw')
--INSERT INTO dbo.CapitalCity ([CountryId], [Name])
--VALUES (2, 'Paris')
--INSERT INTO dbo.CapitalCity ([CountryId], [Name])
--VALUES (3, 'Budapest')
--INSERT INTO dbo.CapitalCity ([CountryId], [Name])
--VALUES (4, 'Berlin')