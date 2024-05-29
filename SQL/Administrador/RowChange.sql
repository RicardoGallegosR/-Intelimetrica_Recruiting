CREATE TABLE Intelimetrica.ADMINISTRADOR.TipoAccion (
    ActionTypeId TINYINT IDENTITY(0,1) PRIMARY KEY, 
    ActionType NVARCHAR(12) NOT NULL, -- Tipo de acción:'DESCONOCIDO', 'INSERT', 'UPDATE', 'DELETE'
    );

INSERT INTO Intelimetrica.ADMINISTRADOR.TipoAccion (ActionType)
VALUES ('INSERT'),('UPDATE'),('DELETE')

SELECT * FROM Intelimetrica.ADMINISTRADOR.TipoAccion
---------------------------------------------------------------------------
---------------------------------------------------------------------------
CREATE TABLE Intelimetrica.ADMINISTRADOR.RowChangeLog (
    LogID INT IDENTITY(0,1) PRIMARY KEY,			-- ID de registro único (clave primaria)
    ActionTypeId TINYINT DEFAULT 0 NOT NULL, 
    TableId SMALLINT DEFAULT 0 NOT NULL,			-- Nombre de la tabla afectada
    [RowCount] INT NOT NULL,							-- Cantidad de filas cambiadas
    UserName NVARCHAR(128) NOT NULL,				-- Nombre del usuario que realizó la acción
    [TIMESTAMP] DATETIME DEFAULT GETDATE() NOT NULL,	-- Marca de tiempo de la acción
	Authorized BIT DEFAULT 0						-- Cambio Authorizado
);


ALTER TABLE Intelimetrica.ADMINISTRADOR.RowChangeLog
ADD CONSTRAINT FK_RowChangeLog_TipoAccion
FOREIGN KEY (ActionTypeId) REFERENCES Intelimetrica.ADMINISTRADOR.TipoAccion(ActionTypeId);


ALTER TABLE Intelimetrica.ADMINISTRADOR.RowChangeLog
ADD CONSTRAINT FK_RowChangeLog_TableId
FOREIGN KEY (TableId) REFERENCES Intelimetrica.ADMINISTRADOR.Tablas(TableId);


INSERT INTO Intelimetrica.ADMINISTRADOR.Tablas (SchemaId,Table_nombre)
VALUES 	(3,'RowChangeLog'),	(3,'TipoAccion')