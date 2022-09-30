CREATE OR ALTER FUNCTION [dbo].ufnLocalTimeToUtc(@localTime datetime)
   RETURNS datetime AS 
   BEGIN
	RETURN CAST(TODATETIMEOFFSET(@localTime, DATEPART(TZOFFSET, SYSDATETIMEOFFSET())) AT TIME ZONE 'UTC' as datetime)
   END
GO

CREATE OR ALTER  FUNCTION [dbo].[ufnRetrieveWorkingDays] 
(    
    @StartDate AS datetime2,
	@EndDate AS datetime2
) 
RETURNS INT 
AS
BEGIN
	DECLARE @Result INT = 0;
	DECLARE @StartDate_ date = CAST(@StartDate AS DATE)
	DECLARE @EndDate_ date = CAST(@EndDate AS DATE)

		while(@StartDate_ <= @EndDate_)
		begin
			IF (DATEPART(weekday,@StartDate_) IN (2,3,4,5,6)) 
            BEGIN
                SET @Result = @Result + 1 
            END
			SET @StartDate_= DATEADD(day, 1, @StartDate_)
        end
    RETURN @Result 
END


select 
	SalesOrderID,
	TotalDue,
	OrderDate,
	ShipDate,
	DATEDIFF(day, OrderDate, ShipDate) as [TimeToGet],
	dbo.[ufnRetrieveWorkingDays](OrderDate, ShipDate) as [TimeToGet_WorkDays]
from Sales.SalesOrderHeader

select dbo.ufnLocalTimeToUtc(GETDATE())

