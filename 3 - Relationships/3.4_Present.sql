USE [AdventureWorks2012]
GO

-- It is annoying to remember about primary key id when doing an insert...
drop table [3.4].[Country]

CREATE TABLE [3.4].[Country](
	[CountryId] int NOT NULL,
	[Name] nvarchar(100) NOT NULL,
	[Population] int NOT NULL,
	[Iso] nvarchar(2) NOT NULL,
	[Description] nvarchar(max) NULL,
	[RowCreationDate] datetime2 NOT NULL,
	CONSTRAINT [PK_Country_CountryId] PRIMARY KEY ( [CountryId] )
)

ALTER TABLE [3.4].[Country] ADD CONSTRAINT [DF_Country_RowCreationDate]  DEFAULT ((GETDATE())) FOR [RowCreationDate];
ALTER TABLE [3.4].[Country] WITH CHECK ADD CONSTRAINT [CK_Country_Population] CHECK ([Population] > 0 )
ALTER TABLE [3.4].[Country] WITH CHECK ADD CONSTRAINT [CK_Country_Iso] CHECK (LEN([Iso]) = 2 AND [Iso] = UPPER([Iso]))
ALTER TABLE [3.4].[Country] ADD CONSTRAINT [UC_Country_Iso] UNIQUE (Iso);
ALTER TABLE [3.4].[Country] ADD CONSTRAINT [UC_Country_Name] UNIQUE ([Name]);

INSERT INTO [3.4].Country ([CountryId], [Name], [Population], [Iso], [Description])
VALUES (1, 'Poland', 38000000, 'PL', 'Country to be come the strongest in the world')

SELECT * FROM [3.4].Country

-- 1. Let's use identity --

drop table [3.4].[Country]
CREATE TABLE [3.4].[Country](
	[CountryId] int NOT NULL IDENTITY(1,1),
	[Name] nvarchar(100) NOT NULL,
	[Population] int NOT NULL,
	[Iso] nvarchar(2) NOT NULL,
	[Description] nvarchar(max) NULL,
	[RowCreationDate] datetime2 NOT NULL,
	CONSTRAINT [PK_Country_CountryId] PRIMARY KEY ( [CountryId] )
)

ALTER TABLE [3.4].[Country] ADD CONSTRAINT [DF_Country_RowCreationDate]  DEFAULT ((GETDATE())) FOR [RowCreationDate];
ALTER TABLE [3.4].[Country] WITH CHECK ADD CONSTRAINT [CK_Country_Population] CHECK ([Population] > 0 )
ALTER TABLE [3.4].[Country] WITH CHECK ADD CONSTRAINT [CK_Country_Iso] CHECK (LEN([Iso]) = 2 AND [Iso] = UPPER([Iso]))
ALTER TABLE [3.4].[Country] ADD CONSTRAINT [UC_Country_Iso] UNIQUE (Iso);
ALTER TABLE [3.4].[Country] ADD CONSTRAINT [UC_Country_Name] UNIQUE ([Name]);

-- Inserts are way easier without taking care of what is the next id. --------------------------------------------------------------------------------
INSERT INTO [3.4].Country ([Name], [Population], [Iso], [Description])
VALUES ('Poland', 38000000, 'PL', 'Country to be come the strongest in the world')
INSERT INTO [3.4].Country ([Name], [Population], [Iso], [Description])
VALUES ('France', 67990000, 'FR', 'Country famous from eating frogs and snails.')
INSERT INTO [3.4].Country ([Name], [Population], [Iso], [Description])
VALUES ('Hungary', 9730000, 'HU', 'Friends of Polish citizens lives there.')

SELECT * FROM [3.4].Country
----------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Let's remove hungary and add it once again, country id is growing
DELETE FROM [3.4].[Country] WHERE CountryId = 3
INSERT INTO [3.4].Country ([Name], [Population], [Iso], [Description])
VALUES ('Hungary', 9730000, 'HU', 'Friends of Polish citizens lives there. I really like Hungarian cuisine.')
INSERT INTO [3.4].Country ([Name], [Population], [Iso], [Description])
VALUES ('Russia', 144730000, 'RU', 'Russia is russia.')
SELECT * FROM [3.4].[Country]
----------------------------------------------------------------------------------------------------------------------------------------------------------------

-- It's impossible to update identity columns
UPDATE [3.4].Country SET CountryId = 3 Where [Name]='Hungary'
----------------------------------------------------------------------------------------------------------------------------------------------------------------

-- It's impossible to insert into identity columns
INSERT INTO [3.4].Country ([CountryId], [Name], [Population], [Iso], [Description])
VALUES (3, 'China', 1932730000, 'CH', 'Maybe coronavirus comes from this country.')
----------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Let's try to insert into identity column
SET IDENTITY_INSERT [3.4].Country ON -- it allows to insert id once again

INSERT INTO [3.4].Country ([CountryId], [Name], [Population], [Iso], [Description])
VALUES (3, 'China', 1932730000, 'CH', 'Maybe coronavirus comes from this country.')

SELECT * FROM [3.4].[Country]
----------------------------------------------------------------------------------------------------------------------------------------------------------------

-- And then we turn off identity insert once again, what will happen? It's still possible to add new entries.

INSERT INTO [3.4].Country ([CountryId], [Name], [Population], [Iso], [Description])
VALUES (6, 'Spain', 1932730000, 'ES', 'Barcelona and Real Madrit are football clubs from this country.')

SELECT * FROM [3.4].[Country]

SET IDENTITY_INSERT [3.4].Country OFF

INSERT INTO [3.4].Country ([Name], [Population], [Iso], [Description])
VALUES ('Australia', 193730000, 'AU', 'Snakes and kangaroos.')

SELECT * FROM [3.4].[Country]

-- What if we delete all elements? Still new ids gonna be added.

DELETE FROM [3.4].[Country]

INSERT INTO [3.4].Country ([Name], [Population], [Iso], [Description])
VALUES ('Poland', 38000000, 'PL', 'Country to be come the strongest in the world')
INSERT INTO [3.4].Country ([Name], [Population], [Iso], [Description])
VALUES ('France', 67990000, 'FR', 'Country famous from eating frogs and snails.')
INSERT INTO [3.4].Country ([Name], [Population], [Iso], [Description])
VALUES ('Hungary', 9730000, 'HU', 'Friends of Polish citizens lives there.')

SELECT * FROM [3.4].[Country]

-- If we want to start from id with number 1 once again we need to restart counter:

DBCC CHECKIDENT ('[3.4].[Country]')  -- give us information about current identity value and column value
DBCC CHECKIDENT ('[3.4].[Country]', RESEED, 0)  -- we gonna reset to 0
DBCC CHECKIDENT ('[3.4].[Country]') 
DELETE FROM [3.4].[Country]

INSERT INTO [3.4].Country ([Name], [Population], [Iso], [Description])
VALUES ('Polandd', 38000000, 'PF', 'Country to be come the strongest in the world')
INSERT INTO [3.4].Country ([Name], [Population], [Iso], [Description])
VALUES ('France', 67990000, 'FR', 'Country famous from eating frogs and snails.')
INSERT INTO [3.4].Country ([Name], [Population], [Iso], [Description])
VALUES ('Hungary', 9730000, 'HU', 'Friends of Polish citizens lives there.')

SELECT * FROM [3.4].[Country] -- we see ids starting from 1 once again

DROP TABLE [3.4].[Country]
