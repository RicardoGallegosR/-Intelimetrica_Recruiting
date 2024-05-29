CREATE LOGIN API_Intelimetrica 
WITH PASSWORD = 'Pass.1234';
GO

CREATE USER API_Intelimetrica 
FOR LOGIN API_Intelimetrica;


-- Negar  todos los permisos de los esquemas menos el esquema Restaurant
DECLARE @SchemaName NVARCHAR(MAX);
DECLARE cur CURSOR FOR 
    SELECT name FROM sys.schemas WHERE name NOT IN ('Restaurant');

OPEN cur;
    FETCH NEXT FROM cur INTO @SchemaName;
    WHILE @@FETCH_STATUS = 0
        BEGIN
            EXEC('DENY SELECT, UPDATE, DELETE ON SCHEMA::[' + @SchemaName + '] TO API_Intelimetrica;');
            FETCH NEXT FROM cur INTO @SchemaName;
        END
CLOSE cur;

DEALLOCATE cur;
    IF EXISTS (SELECT * FROM sys.schemas WHERE name = 'Restaurant')
        BEGIN
            GRANT SELECT, UPDATE, DELETE ON SCHEMA :: Restaurant TO API_Intelimetrica;
        END
    ELSE
        BEGIN
            PRINT 'El esquema Restaurant no existe en la base de datos.';
        END
    GO