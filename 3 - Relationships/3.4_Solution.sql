USE [AdventureWorks2012]
GO


CREATE TABLE [3.4].[Country](
	[CountryId] int NOT NULL IDENTITY (1,1),
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

CREATE TABLE [3.4].[AdultPeople](
	[PersonId] int NOT NULL IDENTITY (1,1),
	[Name] nvarchar(100) NOT NULL,
	[Surname] nvarchar(100) NOT NULL,
	[DateOfBirth] datetime2 NOT NULL,
	[IdentityNumber] nvarchar(11) NOT NULL,
	[NationalityId] [int] NOT NULL,
	[RowCreationDate] datetime2 NOT NULL,
	CONSTRAINT [PK_AdultPeople_PersonId] PRIMARY KEY ( [PersonId] ),
	CONSTRAINT [FK_AdultPeople_Country_CountryId] FOREIGN KEY ( [NationalityId] ) REFERENCES [3.4].Country (CountryId)
)

ALTER TABLE [3.4].[AdultPeople] ADD CONSTRAINT [DF_AdultPeople_RowCreationDate]  DEFAULT ((GETDATE())) FOR [RowCreationDate];
ALTER TABLE [3.4].[AdultPeople] WITH CHECK ADD CONSTRAINT [CK_AdultPeople_DateOfBirth] CHECK 
(
	(YEAR(GETDATE()) - YEAR(DateOfBirth)) > 17
)
ALTER TABLE [3.4].[AdultPeople] ADD CONSTRAINT [UC_AdultPeople_IdentityNumber] UNIQUE (IdentityNumber)
ALTER TABLE [3.4].[AdultPeople] WITH CHECK ADD CONSTRAINT [CK_AdultPeople_IdentityNumber] CHECK 
(
	LEN([IdentityNumber]) = 11 AND
	((TRY_CONVERT(DateTime, SUBSTRING(IdentityNumber, 5, 2) + '-' + SUBSTRING(IdentityNumber, 3, 2)  + '-' + SUBSTRING(IdentityNumber, 1, 2), 5)) is not null)
)
ALTER TABLE [3.4].[AdultPeople] WITH CHECK ADD CONSTRAINT [CK_AdultPeople_IdentityNumberAlignedWithDateOfBirth] CHECK 
(
	RIGHT((CAST( (YEAR(DateOfBirth)) AS NVARCHAR(4))), 2) = SUBSTRING(IdentityNumber, 1, 2)
	AND
	MONTH(DateOfBirth) = SUBSTRING(IdentityNumber, 3, 2)
	AND
	DAY(DateOfBirth) = SUBSTRING(IdentityNumber, 5, 2)
)

CREATE TABLE [3.4].[City](
	[CityId] int NOT NULL IDENTITY (1,1),
	[CountryId] int NULL,
	[Name] nvarchar(200) NOT NULL,
	[Population] int NOT NULL,
	[Description] nvarchar(max) NULL,
	[IsCapitalCity] bit NOT NULL,
	[RowCreationDate] datetime2 NOT NULL,
	CONSTRAINT [PK_City_CityId] PRIMARY KEY ( [CityId] ),
	CONSTRAINT FK_City_Country_CountryId FOREIGN KEY (CountryId) REFERENCES [3.4].Country (CountryId)
)

ALTER TABLE [3.4].[City] ADD CONSTRAINT [DF_City_RowCreationDate]  DEFAULT ((GETDATE())) FOR [RowCreationDate];
ALTER TABLE [3.4].[City] WITH CHECK ADD CONSTRAINT [CK_City_Population] CHECK  ([Population] > 0 )

CREATE TABLE [3.4].[Addresses](
		[AddressId] [int] NOT NULL IDENTITY (1,1),
		[PersonId] [int] NOT NULL,
		[CityId] [int] NOT NULL,
		[AddressLine1] nvarchar(100) NULL,
		[AddressLine2] nvarchar(100) NULL,
		[RowCreationDate] datetime2 NOT NULL
		CONSTRAINT [PK_Addresses_AddressId] PRIMARY KEY ( [AddressId] ),
		CONSTRAINT FK_Addresses_AdultPeople_PersonId FOREIGN KEY (PersonId) REFERENCES [3.4].[AdultPeople] (PersonId),
		CONSTRAINT FK_Addresses_City_CityId FOREIGN KEY (CityId) REFERENCES [3.4].[City] (CityId)
	)

ALTER TABLE [3.4].[Addresses] ADD CONSTRAINT [DF_Addresses_RowCreationDate]  DEFAULT ((GETDATE())) FOR [RowCreationDate];
ALTER TABLE [3.4].[Addresses] ADD CONSTRAINT [UC_Addresses_PersonId] UNIQUE (PersonId);
-- 2 --

BEGIN -- INSERTS: --

	INSERT INTO [3.4].Country ([Name], [Population], [Iso], [Description])
	VALUES ('Poland', 38000000, 'PL', 'Country to be come the strongest in the world')
	INSERT INTO [3.4].Country ([Name], [Population], [Iso], [Description])
	VALUES ('France', 67990000, 'FR', 'Country famous from eating frogs and snails.')
	INSERT INTO [3.4].Country ([Name], [Population], [Iso], [Description])
	VALUES ('Hungary', 9730000, 'HU', 'Friends of Polish citizens lives there.')

	SET IDENTITY_INSERT [3.4].Country ON 
	INSERT INTO [3.4].Country ([CountryId], [Name], [Population], [Iso], [Description])
	VALUES (150, 'Turkey', 82835090, 'TR', 'It''s warm there')
	INSERT INTO [3.4].Country ([CountryId], [Name], [Population], [Iso], [Description])
	VALUES (43, 'Canada', 37590000, 'CA', 'Ice hockey masters')
	SET IDENTITY_INSERT [3.4].Country OFF 

	INSERT INTO [3.4].[AdultPeople]
	VALUES ('Johnny', 'Bravo', '1982-12-15 19:29:40.000', '82121561134', 2, GETDATE())
	
	INSERT INTO [3.4].[AdultPeople]
	VALUES ('Zbigniew', 'Wesoły', '2001-07-02 19:29:40.000', '01070261134', 1, GETDATE())
	
	INSERT INTO [3.4].[AdultPeople]
	VALUES ('Alina', 'Kowalska', '1976-05-11 19:29:40.000', '76051161134', 1, GETDATE())
	
	INSERT INTO [3.4].[AdultPeople]
	VALUES ('Michał', 'Kozioł', '1992-02-26 13:32:11.000', '92022661134', 1, GETDATE())
	
	INSERT INTO [3.4].City ([CountryId], [Name], [Population], [Description], [IsCapitalCity])
	VALUES (1, 'Warsaw', 1700001, 'Capital city of Poland.', 1)
	INSERT INTO [3.4].City ([CountryId], [Name], [Population], [Description], [IsCapitalCity])
	VALUES (2, 'Saint-Tropez', 1700001, 'Famous from song "Welocome to Saint-Tropez, tututrutu".', 0)
	INSERT INTO [3.4].City ([CountryId], [Name], [Population], [Description], [IsCapitalCity])
	VALUES (1, 'Bydgoszcz', 348190, 'Very beautiful people with ambitious it developers.', 0)
	
	INSERT INTO [3.4].[Addresses] ([PersonId], [CityId], [AddressLine1], [AddressLine2])
	VALUES (1, 1, 'Andersa 15/20', 'Woj. Mazowieckie')
	
	INSERT INTO [3.4].[Addresses] ([PersonId], [CityId], [AddressLine1], [AddressLine2])
	VALUES (2, 2, 'Avenue des Palmiers 23', 'Post code: 83990')
	
	INSERT INTO [3.4].[Addresses] ([PersonId], [CityId], [AddressLine1], [AddressLine2])
	VALUES (3, 3, 'Jana Kozietulskiego 32/44', 'Woj. Kujawsko-pomorskie')
	
	INSERT INTO [3.4].[Addresses] ([PersonId], [CityId], [AddressLine1], [AddressLine2])
	VALUES (4, 3, 'Toruńska 324', 'Woj. Kujawsko-pomorskie')
	
	SELECT * FROM  [3.4].[Addresses]
	SELECT * FROM  [3.4].[City]
	SELECT * FROM  [3.4].[Country]
	SELECT * FROM  [3.4].[AdultPeople]	

END -- INSERTS --


drop table [3.4].[Addresses]
drop table [3.4].[City]
drop table [3.4].[AdultPeople]
drop table [3.4].[Country]