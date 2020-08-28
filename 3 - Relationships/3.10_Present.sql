
-- disable/enable certain trigger
ALTER TABLE [Person].[Person] DISABLE TRIGGER [iuPerson]
ALTER TABLE [Person].[Person] ENABLE TRIGGER [iuPerson]

-- disable all triggers on table level
DISABLE TRIGGER ALL ON [Person].[Person]
ENABLE TRIGGER ALL ON [Person].[Person]

-- disable database triggers not table triggers
DISABLE TRIGGER ALL ON DATABASE;
ENABLE TRIGGER ALL ON DATABASE;

-- get all database triggers
SELECT  
    name,
    is_instead_of_trigger,
	*
FROM 
    sys.triggers  
WHERE 
    type = 'TR';





