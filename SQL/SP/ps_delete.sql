CREATE PROCEDURE Restaurant.sp_delete_Restaurant
    @RestaurantsId INT = NULL,
    @Id UNIQUEIDENTIFIER = NULL
AS
BEGIN
    DECLARE
        @ErrorMessage NVARCHAR(4000),
        @ErrorSeverity INT,
        @ErrorState INT;

    SET NOCOUNT ON;

    -- Validar que al menos uno de los parámetros sea proporcionado
    IF @RestaurantsId IS NULL AND @Id IS NULL
    BEGIN
        RAISERROR('Debe proporcionar al menos RestaurantsId o Id para realizar la eliminación.', 16, 1);
        RETURN;
    END

    BEGIN TRY
        BEGIN TRANSACTION;

        IF @RestaurantsId IS NOT NULL
        BEGIN
            IF EXISTS (SELECT TOP 1 Id FROM Restaurant.Restaurants WHERE RestaurantsId = @RestaurantsId)
            BEGIN
                RAISERROR('RestaurantsId ya ha sido eliminado o no existe.', 16, 1);
                RETURN;
            END

            DELETE FROM Restaurant.Restaurants
            WHERE RestaurantsId = @RestaurantsId;
        END
        ELSE
        BEGIN
            IF EXISTS (SELECT TOP 1 Id FROM Restaurant.Restaurants WHERE Id = @Id)
            BEGIN
                RAISERROR('Id ya ha sido eliminado o no existe.', 16, 1);
                RETURN;
            END

            DELETE FROM Restaurant.Restaurants
            WHERE Id = @Id;
        END

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        SET @ErrorMessage = 'Error en el procedimiento almacenado sp_delete_Restaurant: ' + @ErrorMessage +
                    '. Error en la línea: ' + CAST(ERROR_LINE() AS NVARCHAR(10));
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
        
        ROLLBACK TRANSACTION;
    END CATCH;

    SET NOCOUNT OFF;
END;
GO
