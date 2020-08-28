USE [AdventureWorks2012]
GO

CREATE TABLE [3.2].[Country](
	[CountryId] int NOT NULL,
	[Name] nvarchar(100) NOT NULL,
	[Population] int NOT NULL,
	[Iso] nvarchar(2) NOT NULL,
	[Description] nvarchar(max) NULL,
	[RowCreationDate] datetime2 NOT NULL,
	CONSTRAINT [PK_Country_CountryId] PRIMARY KEY ( [CountryId] )
)

CREATE TABLE [3.2].[AdultPeople](
	[PersonId] int NOT NULL,
	[Name] nvarchar(100) NOT NULL,
	[Surname] nvarchar(100) NOT NULL,
	[DateOfBirth] datetime2 NOT NULL,
	[IdentityNumber] nvarchar(11) NOT NULL,
	[NationalityId] [int] NOT NULL,
	[RowCreationDate] datetime2 NOT NULL,
	CONSTRAINT [PK_AdultPeople_PersonId] PRIMARY KEY ( [PersonId] ),
	CONSTRAINT [FK_AdultPeople_Country_CountryId] FOREIGN KEY ( [NationalityId] ) REFERENCES [3.2].Country (CountryId)
)

CREATE TABLE [3.2].[City](
	[CityId] int NOT NULL,
	[CountryId] int NULL,
	[Name] nvarchar(200) NOT NULL,
	[Population] int NOT NULL,
	[Description] nvarchar(max) NULL,
	[IsCapitalCity] bit NOT NULL,
	[RowCreationDate] datetime2 NOT NULL,
	CONSTRAINT [PK_City_CityId] PRIMARY KEY ( [CityId] ),
	CONSTRAINT FK_City_Country_CountryId FOREIGN KEY (CountryId) REFERENCES [3.2].Country (CountryId)
)


CREATE TABLE [3.2].[Addresses](
		[AddressId] [int] NOT NULL,
		[PersonId] [int] NOT NULL,
		[CityId] [int] NOT NULL,
		[AddressLine1] nvarchar(100) NULL,
		[AddressLine2] nvarchar(100) NULL,
		[RowCreationDate] datetime2 NOT NULL
		CONSTRAINT [PK_Addresses_AddressId] PRIMARY KEY ( [AddressId] ),
		CONSTRAINT FK_Addresses_AdultPeople_PersonId FOREIGN KEY (PersonId) REFERENCES [3.2].[AdultPeople] (PersonId),
		CONSTRAINT FK_Addresses_City_CityId FOREIGN KEY (CityId) REFERENCES [3.2].[City] (CityId)
	)


BEGIN -- INSERTS: --

	INSERT INTO [3.2].Country ([CountryId], [Name], [Population], [Iso], [Description], [RowCreationDate])
	VALUES (1, 'Poland', 38000000, 'PL', 'Country to be come the strongest in the world', GETDATE())
	INSERT INTO [3.2].Country ([CountryId], [Name], [Population], [Iso], [Description], [RowCreationDate])
	VALUES (2, 'France', 67990000, 'FR', 'Country famous from eating frogs and snails.', GETDATE())
	INSERT INTO [3.2].Country ([CountryId], [Name], [Population], [Iso], [Description], [RowCreationDate])
	VALUES (3, 'Hungary', 9730000, 'HU', 'Friends of Polish citizens lives there.', GETDATE())

	INSERT INTO [3.2].[AdultPeople]
	VALUES (1, 'Johnny', 'Bravo', '1982-12-15 19:29:40.000', '82121561134', 2, GETDATE())
	
	INSERT INTO [3.2].[AdultPeople]
	VALUES (2, 'Zbigniew', 'Wesoły', '2001-07-02 19:29:40.000', '01070261134', 1, GETDATE())
	
	INSERT INTO [3.2].[AdultPeople]
	VALUES (3, 'Alina', 'Kowalska', '1976-05-11 19:29:40.000', '76051161134', 1, GETDATE())
	
	INSERT INTO [3.2].[AdultPeople]
	VALUES (4, 'Michał', 'Kozioł', '1992-02-26 13:32:11.000', '92022661134', 1, GETDATE())
	
	INSERT INTO [3.2].City ([CityId], [CountryId], [Name], [Population], [Description], [IsCapitalCity], [RowCreationDate])
	VALUES (1, 1, 'Warsaw', 1700001, 'Capital city of Poland.', 1, GETDATE())
	INSERT INTO [3.2].City ([CityId], [CountryId], [Name], [Population], [Description], [IsCapitalCity], [RowCreationDate])
	VALUES (2, 2, 'Saint-Tropez', 1700001, 'Famous from song "Welocome to Saint-Tropez, tututrutu".', 0, GETDATE())
	INSERT INTO [3.2].City ([CityId], [CountryId], [Name], [Population], [Description], [IsCapitalCity], [RowCreationDate])
	VALUES (3, 1, 'Bydgoszcz', 348190, 'Very beautiful people with ambitious it developers.', 0, GETDATE())
	
	INSERT INTO [3.2].[Addresses] ([AddressId], [PersonId], [CityId], [AddressLine1], [AddressLine2], [RowCreationDate])
	VALUES (1, 1, 1, 'Andersa 15/20', 'Woj. Mazowieckie', GETDATE())
	
	INSERT INTO [3.2].[Addresses] ([AddressId], [PersonId], [CityId], [AddressLine1], [AddressLine2], [RowCreationDate])
	VALUES (2, 2, 2, 'Avenue des Palmiers 23', 'Post code: 83990', GETDATE())
	
	INSERT INTO [3.2].[Addresses] ([AddressId], [PersonId], [CityId], [AddressLine1], [AddressLine2], [RowCreationDate])
	VALUES (3, 3, 3, 'Jana Kozietulskiego 32/44', 'Woj. Kujawsko-pomorskie', GETDATE())
	
	INSERT INTO [3.2].[Addresses] ([AddressId], [PersonId], [CityId], [AddressLine1], [AddressLine2], [RowCreationDate])
	VALUES (4, 4, 3, 'Toruńska 324', 'Woj. Kujawsko-pomorskie', GETDATE())
	
	SELECT * FROM  [3.2].[Addresses]
	SELECT * FROM  [3.2].[City]
	SELECT * FROM  [3.2].[Country]
	SELECT * FROM  [3.2].[AdultPeople]	

END -- INSERTS --

BEGIN -- WRONG INSERTS: --
	
	INSERT INTO [3.2].[AdultPeople]
	VALUES (67, 'Johnny', 'Bravo', '1982-12-15 19:29:40.000', '82121561134', 7, GETDATE())
	
	INSERT INTO [3.2].[AdultPeople]
	VALUES (45, 'Zbigniew', 'Wesoły', '2001-07-02 19:29:40.000', '010702611348', 1, GETDATE())
	
	INSERT INTO [3.2].Country ([CountryId], [Name], [Population], [Iso], [Description], [RowCreationDate])
	VALUES (1, 'xx', 'dsfd', 'PL', 'Country to be come the strongest in the world', GETDATE())

	INSERT INTO [3.2].City ([CityId], [CountryId], [Name], [Population], [Description], [IsCapitalCity], [RowCreationDate])
	VALUES (69, 77, 'Warsaw', 1700001, 'Capital city of Poland.', 1, GETDATE())
	
	INSERT INTO [3.2].[Addresses] ([AddressId], [PersonId], [CityId], [AddressLine1], [AddressLine2], [RowCreationDate])
	VALUES (3, 22, 99, 'Jana Kozietulskiego 32/44', 'Woj. Kujawsko-pomorskie', GETDATE())
	

END -- WRONG INSERTS: --


drop table [3.2].[Addresses]
drop table [3.2].[City]
drop table [3.2].[Country]
drop table [3.2].[AdultPeople]





