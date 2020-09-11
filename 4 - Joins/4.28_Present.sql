SELECT * FROM SALES where OrderID= 120712983

BEGIN TRAN
	UPDATE Sales set OrderDate = GETDATE() WHERE OrderID = 120712983


exec sp_who2 
kill 57   
