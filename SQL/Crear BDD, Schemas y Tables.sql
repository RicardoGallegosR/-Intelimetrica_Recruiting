/*
Creamos la BDD para ejemplificar se nombro Intelimetrica, dado que es importante el tipo de codificacion:

SQL_Latin1_General_CP1: Indica que se usa el conjunto de caracteres Latin1 (que es un conjunto de caracteres de Europa Occidental). CP1 se refiere a Code Page 1252, que es una página de códigos específica para este conjunto de caracteres.
CI: Significa Case Insensitive, lo que quiere decir que las comparaciones de caracteres no diferencian entre mayúsculas y minúsculas. Por ejemplo, 'A' y 'a' se consideran iguales.
AI: Significa Accent Insensitive, lo que indica que las comparaciones de caracteres no diferencian entre caracteres con y sin acentos. Por ejemplo, 'a' y 'á' se consideran iguales.
*/
CREATE DATABASE Intelimetrica
COLLATE SQL_Latin1_General_CP1_CI_AI;
GO
/*
Se crean 3 esquemas 
- el de activos contendra la tabla Activo y definira si un restuarante proporciona servicio o no :(
- el esquema Restaurant contendra todo lo relacionado con los restaurantes
- el esquema administrador es para almacenar los trigger y cosas de niños grandes :D 
*/
CREATE SCHEMA Activos;
GO
CREATE SCHEMA Restaurant;
GO
CREATE SCHEMA Administrador;
GO

/*
Creacion de la Tabla de Activos
*/
CREATE TABLE Activos.Activo (
    ActivoId BIT IDENTITY(0,1) NOT NULL,
	tipo_Activo NVARCHAR(30) NOT NULL, 
);

-- Tomamos precauciones al llenar la BDD
DECLARE
    @ErrorMessage NVARCHAR(4000),
    @ErrorSeverity INT,
    @ErrorState INT

BEGIN TRY
    BEGIN TRANSACTION
        INSERT INTO Examples.Activo.Activos (tipo_Activo)
        VALUES	('INACTIVO'),
				('ACTIVO')
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

        SET @ErrorMessage = 'Error en el procedimiento almacenado Insertar Certificado: ' + @ErrorMessage +
                    '. Error en la línea: ' + CAST(ERROR_LINE() AS NVARCHAR(10))
    RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    ROLLBACK TRANSACTION;
END CATCH





Restaurants (
id TEXT PRIMARY KEY, -- Unique Identifier of Restaurant
            rating INTEGER, -- Number between 0 and 4
            name TEXT, -- Name of the restaurant
            site TEXT, -- Url of the restaurant
            email TEXT,
            phone TEXT,
            street TEXT,
            city TEXT,
            state TEXT,
            lat FLOAT, -- Latitude
            lng FLOAT) -- Longitude