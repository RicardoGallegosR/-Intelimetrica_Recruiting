CREATE DATABASE Intelimetrica
COLLATE SQL_Latin1_General_CP1_CI_AI;
GO

USE Intelimetrica;
GO
CREATE SCHEMA Activos;
GO
CREATE SCHEMA Restaurant;
GO
CREATE SCHEMA Administrador;
GO


-- drop table Activos.Activo
CREATE TABLE Activos.Activo (
    ActivoId TINYINT IDENTITY(0,1) NOT NULL,
	 tipo_Activo NVARCHAR(30) NOT NULL, 
    PRIMARY KEY (ActivoId),
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


CREATE TABLE Restaurant.Restaurants (
   RestaurantsId INT IDENTITY(0,1) NOT NULL,
   Id UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
   Rating TINYINT CHECK (Rating BETWEEN 0 AND 4),
   [Name] VARCHAR(40), -- Name of the restaurant
   WebSite VARCHAR(40), -- Url of the restaurant
   email VARCHAR(45),
   phone VARCHAR(15), -- por los numeros internacionales,10 para los nacionales
   street VARCHAR(35),
   city VARCHAR(50),
   [State] VARCHAR(30),
   lat FLOAT, 
   lng FLOAT,
   ActivoId INT DEFAULT 1,
   PRIMARY KEY (RestaurantsId) 
);

ALTER TABLE Restaurant.Restaurants
ADD CONSTRAINT FK_Activos_Restaurants
FOREIGN KEY (ActivoId) REFERENCES Examples.Activo.Activos(ActivoId);
