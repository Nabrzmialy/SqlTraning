BEGIN TRAN
	
	UPDATE
	    soh
	SET
	    soh.ShipDate = DATEADD(day, 1, soh.ShipDate)
	FROM 
	    Sales.SalesOrderHeader soh
	    inner join Purchasing.ShipMethod sm on soh.ShipMethodID = sm.ShipMethodID
		where sm.[Name] = 'CARGO TRANSPORT 5'

ROLLBACK TRAN