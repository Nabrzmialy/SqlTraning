USE [AdventureWorks2012]
GO


-- Add 3 missing commented constraints for adult people(1 foreign key + 1 unique + 1 check ) in the safe way
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
ALTER TABLE [3.5].[Country] ADD CONSTRAINT [UC_Country_Iso] UNIQUE (Iso);
ALTER TABLE [3.5].[Country] ADD CONSTRAINT [UC_Country_Name] UNIQUE ([Name]);

CREATE TABLE [3.5].[AdultPeople](
	[PersonId] int NOT NULL,
	[Name] nvarchar(100) NOT NULL,
	[Surname] nvarchar(100) NOT NULL,
	[DateOfBirth] datetime2 NOT NULL,
	[IdentityNumber] nvarchar(11) NOT NULL,
	[NationalityId] [int] NOT NULL,
	[RowCreationDate] datetime2 NOT NULL,
	CONSTRAINT [PK_AdultPeople_PersonId] PRIMARY KEY ( [PersonId] ),
)

-- ALTER TABLE [3.5].[AdultPeople] ADD CONSTRAINT FK_AdultPeople_Country_CountryId FOREIGN KEY (NationalityId) REFERENCES [3.5].Country (CountryId)
ALTER TABLE [3.5].[AdultPeople] ADD CONSTRAINT [DF_AdultPeople_RowCreationDate]  DEFAULT ((GETDATE())) FOR [RowCreationDate];
--ALTER TABLE [3.5].[AdultPeople] WITH CHECK ADD CONSTRAINT [CK_AdultPeople_DateOfBirth] CHECK 
--(
--	(YEAR(GETDATE()) - YEAR(DateOfBirth)) > 17
--)
--ALTER TABLE [3.5].[AdultPeople] ADD CONSTRAINT [UC_AdultPeople_IdentityNumber] UNIQUE (IdentityNumber)


DECLARE @CountryObjectId int = (SELECT OBJECT_ID('[3.5].[AdultPeople]'))
IF NOT EXISTS( 
	SELECT * FROM SYS.objects 
	WHERE 
		parent_object_id = @CountryObjectId 
		AND [Name] = 'FK_AdultPeople_Country_CountryId' 
		and [type_desc] = 'FOREIGN_KEY_CONSTRAINT'
)
BEGIN
	ALTER TABLE [3.5].[AdultPeople] ADD CONSTRAINT FK_AdultPeople_Country_CountryId FOREIGN KEY (NationalityId) REFERENCES [3.5].Country (CountryId)
END
------------------------------------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS( 
	SELECT * FROM SYS.objects 
	WHERE 
		parent_object_id = @CountryObjectId 
		AND [Name] = 'CK_AdultPeople_DateOfBirth' 
)
BEGIN
	ALTER TABLE [3.5].[AdultPeople] WITH CHECK ADD CONSTRAINT [CK_AdultPeople_DateOfBirth] CHECK
	(
		(YEAR(GETDATE()) - YEAR(DateOfBirth)) > 17
	)
END
------------------------------------------------------------------------------------------------------------------------------------------------

IF NOT EXISTS( 
	SELECT * FROM SYS.objects 
	WHERE 
		parent_object_id = @CountryObjectId 
		AND [Name] = 'UC_AdultPeople_IdentityNumber' 
)
BEGIN
	ALTER TABLE [3.5].[AdultPeople] ADD CONSTRAINT [UC_AdultPeople_IdentityNumber] UNIQUE (IdentityNumber)
END

SELECT * FROM SYS.objects WHERE parent_object_id = @CountryObjectId 
