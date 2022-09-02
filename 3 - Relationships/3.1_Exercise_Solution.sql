USE [AdventureWorks2012]
GO

SELECT * FROM dbo.[Order]
SELECT * FROM dbo.[OrderStatus]

DECLARE @CandidateKeys nvarchar(100) = '[Order].[OrderId], [Order].[CreationDate], [Order].[InvoiceNumber]'
DECLARE @PrimaryKeys nvarchar(100) = '[Order].[OrderId]'
DECLARE @UniqueKeys nvarchar(100) = '[Order].[CreationDate], [Order].[InvoiceNumber]'
DECLARE @CompositeKeys nvarchar(100) = '[OrderStatus].([OrderId], [Status], [ChangeDate])'
DECLARE @SuperKeys nvarchar(100) = '[Order].([OrderId], [CreationDate], [InvoiceNumber])'
DECLARE @ForeignKeys nvarchar(100) = '[OrderStatus].[OrderId]'
DECLARE @AlternateKeys nvarchar(100) = '[Order].[CreationDate], [Order].[InvoiceNumber]'

PRINT 'Candidate Keys: ' + @CandidateKeys
PRINT 'Primary Keys: ' + @PrimaryKeys
PRINT 'Unique Keys: ' + @UniqueKeys
PRINT 'Composite Keys: ' + @CompositeKeys
PRINT 'Super Keys: ' + @SuperKeys
PRINT 'Foreign Keys: ' + @ForeignKeys
PRINT 'Alternate Keys: ' + @AlternateKeys
