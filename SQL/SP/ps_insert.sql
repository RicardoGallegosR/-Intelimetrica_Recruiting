-- DROP PROCEDURE Restaurant.sp_insert
CREATE PROCEDURE Restaurant.sp_insert(
   @Rating TINYINT,
   @Name VARCHAR(40), 
   @WebSite VARCHAR(40),
   @email VARCHAR(45),
   @phone VARCHAR(15), 
   @street VARCHAR(35),
   @city VARCHAR(50),
   @State VARCHAR(30),
   @lat FLOAT, 
   @lng FLOAT,
   @Id UNIQUEIDENTIFIER
   )
AS
BEGIN
    DECLARE
        @ErrorMessage NVARCHAR(4000),
        @ErrorSeverity INT,
        @ErrorState INT

    SET NOCOUNT ON;

    -- Validar si ya existe el id
    IF EXISTS (SELECT TOP 1 Id FROM Restaurant.Restaurants WHERE Id = @Id)
    BEGIN
        RAISERROR('El registro con el Id  ya existe.', 16, 1);
        RETURN;
    END
		
	-- Asignar un nuevo Id si no se proporciona uno
    IF @Id IS NULL
    BEGIN
        SET @Id = NEWID();
    END
	
    -- Validar si está en intervalo
    IF @Rating < 0 OR @Rating > 4
    BEGIN
        RAISERROR('El valor de Rating debe estar entre 0 y 4.', 16, 1);
        RETURN;
    END

    BEGIN TRY
        BEGIN TRANSACTION
            INSERT INTO Restaurant.Restaurants (Rating, [Name], WebSite, Email, Phone, Street, City, [State], Lat, Lng, Id)
            VALUES  (@Rating, @Name, @WebSite, @email, @phone, @street, @city, @State, @lat, @lng, @Id);
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

    SELECT @Id AS NewRestaurantID;
    SET NOCOUNT OFF;
END;
GO
