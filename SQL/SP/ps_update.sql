
CREATE PROCEDURE Restaurant.sp_update_Restaurant
    @RestaurantsId INT = NULL,
    @Id UNIQUEIDENTIFIER = NULL,
    @Rating TINYINT = NULL,
    @Name VARCHAR(40) = NULL,
    @WebSite VARCHAR(40) = NULL,
    @Email VARCHAR(45) = NULL,
    @Phone VARCHAR(15) = NULL,
    @Street VARCHAR(35) = NULL,
    @City VARCHAR(50) = NULL,
    @State VARCHAR(30) = NULL,
    @Lat FLOAT = NULL,
    @Lng FLOAT = NULL
AS
BEGIN
    DECLARE
        @ErrorMessage NVARCHAR(4000),
        @ErrorSeverity INT,
        @ErrorState INT;

    SET NOCOUNT ON;

    -- Validar que al menos RestaurantsId o Id sea proporcionado
    IF @RestaurantsId IS NULL AND @Id IS NULL
    BEGIN
        RAISERROR('Debe proporcionar al menos RestaurantsId o Id para realizar la actualización.', 16, 1);
        RETURN;
    END

    BEGIN TRY
        BEGIN TRANSACTION;

        IF @RestaurantsId IS NOT NULL
        BEGIN
            IF NOT EXISTS (SELECT TOP 1 Id FROM Restaurant.Restaurants WHERE RestaurantsId = @RestaurantsId)
            BEGIN
                RAISERROR('RestaurantsId no existe.', 16, 1);
                RETURN;
            END

            UPDATE Restaurant.Restaurants
            SET Rating = ISNULL(@Rating, Rating),
                [Name] = ISNULL(@Name, [Name]),
                WebSite = ISNULL(@WebSite, WebSite),
                Email = ISNULL(@Email, Email),
                Phone = ISNULL(@Phone, Phone),
                Street = ISNULL(@Street, Street),
                City = ISNULL(@City, City),
                [State] = ISNULL(@State, [State]),
                Lat = ISNULL(@Lat, Lat),
                Lng = ISNULL(@Lng, Lng)
            WHERE RestaurantsId = @RestaurantsId;
        END
        ELSE
        BEGIN
            IF NOT EXISTS (SELECT TOP 1 Id FROM Restaurant.Restaurants WHERE Id = @Id)
            BEGIN
                RAISERROR('Id no existe.', 16, 1);
                RETURN;
            END

            UPDATE Restaurant.Restaurants
            SET Rating = ISNULL(@Rating, Rating),
                [Name] = ISNULL(@Name, [Name]),
                WebSite = ISNULL(@WebSite, WebSite),
                Email = ISNULL(@Email, Email),
                Phone = ISNULL(@Phone, Phone),
                Street = ISNULL(@Street, Street),
                City = ISNULL(@City, City),
                [State] = ISNULL(@State, [State]),
                Lat = ISNULL(@Lat, Lat),
                Lng = ISNULL(@Lng, Lng)
            WHERE Id = @Id;
        END

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        SET @ErrorMessage = 'Error en el procedimiento almacenado sp_update_Restaurant: ' + @ErrorMessage +
                    '. Error en la línea: ' + CAST(ERROR_LINE() AS NVARCHAR(10));
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
        
        ROLLBACK TRANSACTION;
    END CATCH;

    SET NOCOUNT OFF;
END;
GO