GO
CREATE TABLE Intelimetrica.ADMINISTRADOR.Tablas (
    TableId SMALLINT IDENTITY(0,1) PRIMARY KEY NOT NULL,
    SchemaId TINYINT DEFAULT 0,
	Table_nombre NVARCHAR(30) NOT NULL, 
	ActivoId TINYINT DEFAULT 1 NOT NULL
);

ALTER TABLE Intelimetrica.ADMINISTRADOR.Tablas
ADD CONSTRAINT FK_Activos_Tablas
FOREIGN KEY (ActivoId) REFERENCES Intelimetrica.Activos.Activo(ActivoId);

BEGIN TRY
    BEGIN TRANSACTION
        INSERT INTO Intelimetrica.ADMINISTRADOR.Tablas (SchemaId,Table_nombre)
        VALUES
				(0,'Activo'),
				(1,'Restaurants'),
				(3,'Esquemas'),
				(3,'Tablas')
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

SELECT * FROM [Administrador].[Tablas]