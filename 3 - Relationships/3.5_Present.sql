USE [AdventureWorks2012]
GO

drop table [3.5].[Country]

-- Let's check if we can find info about our table:
CREATE TABLE [3.5].[Country](
	[CountryId] int NOT NULL,
	[Name] nvarchar(100) NOT NULL,
	[Population] int NOT NULL,
	[Iso] nvarchar(2) NOT NULL,
	[Description] nvarchar(max) NULL,
	[RowCreationDate] datetime2 NOT NULL,
	CONSTRAINT [PK_Country_CountryId] PRIMARY KEY ( [CountryId] )
)
ALTER TABLE [3.5].[Country] ADD CONSTRAINT [DF_Country_RowCreationDate]  DEFAULT ((GETDATE())) FOR [RowCreationDate];
ALTER TABLE [3.5].[Country] WITH CHECK ADD CONSTRAINT [CK_Country_Population] CHECK ([Population] > 0 )
ALTER TABLE [3.5].[Country] WITH CHECK ADD CONSTRAINT [CK_Country_Iso] CHECK (LEN([Iso]) = 2 AND [Iso] = UPPER([Iso]))
-- ALTER TABLE [3.5].[Country] ADD CONSTRAINT [UC_Country_Iso] UNIQUE (Iso);
-- ALTER TABLE [3.5].[Country] ADD CONSTRAINT [UC_Country_Name] UNIQUE ([Name]);

-- Let's check what's inside our database
SELECT * FROM Sys.objects
SELECT OBJECT_ID('[3.5].[Country]')
--------------------------------------------------------------------------------------

-- Let's find our database and its constraints
SELECT * FROM SYS.objects WHERE object_id = 1846297637
SELECT * FROM SYS.objects WHERE parent_object_id = 1846297637
--------------------------------------------------------------------------------------

-- Let's create script to add missing constraints on production
DECLARE @CountryObjectId int = (SELECT OBJECT_ID('[3.5].[Country]'))
IF NOT EXISTS( SELECT * FROM SYS.objects WHERE parent_object_id = @CountryObjectId AND [Name] = 'UC_Country_Iso')
BEGIN
	ALTER TABLE [3.5].[Country] ADD CONSTRAINT [UC_Country_Iso] UNIQUE (Iso);
END

IF NOT EXISTS( SELECT * FROM SYS.objects WHERE parent_object_id = @CountryObjectId AND [Name] = 'UC_Country_Name')
BEGIN
	ALTER TABLE [3.5].[Country] ADD CONSTRAINT UC_Country_Name UNIQUE (Name);
END
SELECT * FROM SYS.objects WHERE parent_object_id = @CountryObjectId
--------------------------------------------------------------------------------------

