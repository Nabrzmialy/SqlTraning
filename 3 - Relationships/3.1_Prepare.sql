USE [AdventureWorks2012]
GO


CREATE TABLE [dbo].[Order](
	[OrderId] int NOT NULL,
	[Name] nvarchar(100) NOT NULL,
	[CreationDate] datetime2 NOT NULL,
	[InvoiceNumber] nvarchar(100) NULL,
	[Amount] decimal(16,2) NOT NULL
)

CREATE TABLE [dbo].[OrderStatus](
	[OrderId] [int] NOT NULL,
	[Status] [nvarchar](100) NOT NULL,
	[ChangeDate] [datetime2] NULL
)

INSERT INTO dbo.[Order]
VALUES (1, 'Buying 2 cars - brand Ferrarri', '2020-07-19 05:53:23.1115431', 'INV202007190001', 34532.00)
INSERT INTO dbo.[Order]
VALUES (2, 'Buying 34 pencils - sharp ones', '2020-07-19 17:32:21.5439763', 'INV202007190002', 101.00)
INSERT INTO dbo.[Order]
VALUES (3, 'Buying 65 computers - Asus', '2020-07-22 21:02:43.26398732', 'INV202007220001', 65444.00)
INSERT INTO dbo.[Order]
VALUES (4, 'Buying 34 cars - brand Daewoo', '2020-07-22 23:23:43.2637721', 'INV202007220002', 5000.00)
INSERT INTO dbo.[Order]
VALUES (5, 'Buying 322 tables, wooden', '2020-08-05 13:43:43.7654565', 'INV202008050001', 98441.00)

INSERT INTO dbo.[OrderStatus]
VALUES (1, 'New', '2020-07-19 05:53:23.1115431')
INSERT INTO dbo.[OrderStatus]
VALUES (1, 'In Progress', '2020-07-20 12:32:43.1997431')
INSERT INTO dbo.[OrderStatus]
VALUES (1, 'Done', '2020-08-01 21:20:32.1547431')

INSERT INTO dbo.[OrderStatus]
VALUES (4, 'New', '2020-07-22 23:23:43.2637721')
INSERT INTO dbo.[OrderStatus]
VALUES (4, 'In Progress', '2020-07-23 07:12:34.1225431')
INSERT INTO dbo.[OrderStatus]
VALUES (4, 'Cancelled', '2020-08-12 12:43:54.6969691')
INSERT INTO dbo.[OrderStatus]
VALUES (4, 'In Progress', '2020-08-13 23:23:43.1757431')
INSERT INTO dbo.[OrderStatus]
VALUES (4, 'Done', '2020-08-20 15:43:11.1599431')

SELECT * FROM dbo.[Order]
SELECT * FROM dbo.[OrderStatus]