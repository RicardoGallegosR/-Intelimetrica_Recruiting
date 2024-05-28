CREATE TABLE Intelimetrica.ADMINISTRADOR.Esquemas (
    SchemaId TINYINT IDENTITY(0,1) PRIMARY KEY NOT NULL,
	Schema_nombre NVARCHAR(30) NOT NULL, 
	ActivoId TINYINT DEFAULT 1 NOT NULL
);

ALTER TABLE Intelimetrica.ADMINISTRADOR.Esquemas
ADD CONSTRAINT FK_Activos_Esquemas
FOREIGN KEY (ActivoId) REFERENCES Intelimetrica.Activos.Activo(ActivoId);

BEGIN TRY
    BEGIN TRANSACTION
        INSERT INTO Examples.ADMINISTRADOR.Esquemas (Schema_nombre)
        VALUES	('DESCONOCIDO'),
				('Activos'),
				('Restaurant'),
				('Administrador')
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    DECLARE
        @ErrorMessage NVARCHAR(4000),
        @ErrorSeverity INT,
        @ErrorState INT
    SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE();

        SET @ErrorMessage = 'Error en el procedimiento almacenado Insertar Certificado: ' + @ErrorMessage +
                    '. Error en la línea: ' + CAST(ERROR_LINE() AS NVARCHAR(10))
    RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    ROLLBACK TRANSACTION;
END CATCH