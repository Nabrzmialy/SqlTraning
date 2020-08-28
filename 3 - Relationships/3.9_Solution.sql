-- Create trigger which gonna save all trigger of tables into table: [3.9].table_alteration_logs


CREATE TABLE [3.9].table_alteration_logs (
    log_id INT IDENTITY PRIMARY KEY,
    event_data XML NOT NULL,
    changed_by SYSNAME NOT NULL
);
GO

CREATE TRIGGER trg_table_alteration
ON DATABASE
AFTER	
    ALTER_TABLE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO [3.9].table_alteration_logs (
        event_data,
        changed_by
    )
    VALUES (
        EVENTDATA(),
        USER
    );
END;

ALTER TABLE [3.9].[TestCountry]
ALTER COLUMN [Name] nvarchar(4000);

SELECT * FROM [3.9].table_alteration_logs

