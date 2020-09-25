CREATE TABLE Employee (EmpID int identity(1,1),EmpName varchar(500))

CREATE PROCEDURE uspEmployeeInsert
(@EmpName varchar(50),
@EId int output)
AS
BEGIN
SET NOCOUNT ON
 
INSERT INTO Employee (EmpName) VALUES (@EmpName)
 
SELECT @EId= SCOPE_IDENTITY()
 
END

DECLARE @ReturnInt INT = 0
exec uspEmployeeInsert 'ExemplaryEmployee', @ReturnInt OUTPUT
SELECT @ReturnInt
SELECT * FROM Employee

------------------------------------------------------------------
CREATE PROCEDURE uspGetSalesOrderHeaders
AS
BEGIN
SET NOCOUNT ON
	SELECT 
		SalesOrderID,
		OrderDate,
		SalesOrderNumber,
		SalesPersonID
	from Sales.SalesOrderHeader
END

CREATE TABLE #TmpWho
(
	SalesOrderID INT,
	OrderDate datetime2,
	SalesOrderNumber nvarchar(50),
	SalesPersonID int
)

INSERT INTO #TmpWho
exec dbo.uspGetSalesOrderHeaders

select * from #TmpWho

----- Mechanisms to check if all is fine
ALTER PROCEDURE [HumanResources].[uspUpdateEmployeeHireInfo]
    @BusinessEntityID [int], 
    @JobTitle [nvarchar](50), 
    @HireDate [datetime], 
    @RateChangeDate [datetime], 
    @Rate [money], 
    @PayFrequency [tinyint], 
    @CurrentFlag [dbo].[Flag] 
WITH EXECUTE AS CALLER
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        UPDATE [HumanResources].[Employee] 
        SET [JobTitle] = @JobTitle 
            ,[HireDate] = @HireDate 
            ,[CurrentFlag] = @CurrentFlag 
        WHERE [BusinessEntityID] = @BusinessEntityID;

        INSERT INTO [HumanResources].[EmployeePayHistory] 
            ([BusinessEntityID]
            ,[RateChangeDate]
            ,[Rate]
            ,[PayFrequency]) 
        VALUES (@BusinessEntityID, @RateChangeDate, @Rate, @PayFrequency);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Rollback any active or uncommittable transactions before
        -- inserting information in the ErrorLog
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END

        EXECUTE [dbo].[uspLogError];
    END CATCH;
END;