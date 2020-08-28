-- Create trigger which gonna save all alters of tables into table: table_alteration_logs


ALTER TABLE [3.9].[TestCountry]
ALTER COLUMN [Name] nvarchar(4000);

SELECT * FROM [3.9].table_alteration_logs