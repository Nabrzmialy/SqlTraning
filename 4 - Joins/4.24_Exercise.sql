select * from Sales.SalesOrderHeader

SELECT * FROM Sales.SalesOrderHeader sh
inner join Sales.SalesOrderDetail sd on sh.SalesOrderID = sd.SalesOrderID
inner join Production.Product p on sd.ProductID = p.ProductID

-- migrate data to new table
CREATE SCHEMA Sprzedaz
CREATE TABLE Sprzedaz.NaglowkiSprzedazy(
	[Id] [int] NOT NULL,
	[NumerRewizji] [tinyint] NOT NULL,
	[DataZamowienia] [datetime] NOT NULL,
	[CzasNaZaplate] [datetime] NOT NULL,
	[DataDostawy] [datetime] NULL,
	[Status] [tinyint] NOT NULL,
)

-- create view simulating Sales.SalesOrderHeader
SELECT 
	sh.Id,
	sh.RevisionNumber,
	sh.OrderDate,
	sh.DueDate,
	sh.ShipDate,
	sh.[Status]
FROM Sprzedaz.NaglowkiSprzedazy sh
inner join Sales.SalesOrderDetail sd on sh.Id = sd.SalesOrderID
inner join Production.Product p on sd.ProductID = p.ProductID