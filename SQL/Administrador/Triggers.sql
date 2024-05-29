-------------------------------------------------------------------
-------------------------------------------------------------------
CREATE TRIGGER trg_Audit_Activo
   ON Activos.Activo
   AFTER INSERT, UPDATE, DELETE
   AS
      BEGIN
          SET NOCOUNT ON;
          DECLARE @ActionTypeId TINYINT;
          DECLARE @TableId SMALLINT;
          DECLARE @RowCount INT;
          DECLARE @UserName NVARCHAR(128);
          DECLARE @ActionType NVARCHAR(12);

          IF EXISTS (SELECT 1 FROM inserted)
          BEGIN
              IF EXISTS (SELECT 1 FROM deleted)
                  SET @ActionTypeId = (SELECT ActionTypeId FROM Intelimetrica.ADMINISTRADOR.TipoAccion WHERE ActionType = 'UPDATE');
              ELSE
                  SET @ActionTypeId = (SELECT ActionTypeId FROM Intelimetrica.ADMINISTRADOR.TipoAccion WHERE ActionType = 'INSERT');
          END
          ELSE IF EXISTS (SELECT 1 FROM deleted)
             BEGIN
                 SET @ActionTypeId = (SELECT ActionTypeId FROM Intelimetrica.ADMINISTRADOR.TipoAccion WHERE ActionType = 'DELETE');
             END
          ELSE
             BEGIN
                 SET @ActionTypeId = (SELECT ActionTypeId FROM Intelimetrica.ADMINISTRADOR.TipoAccion WHERE ActionType = 'DESCONOCIDO');
             END
    
          SET @TableId = 0; 
          SET @RowCount = (SELECT COUNT(*) FROM inserted) + (SELECT COUNT(*) FROM deleted);
          SET @UserName = SYSTEM_USER;

          INSERT INTO Intelimetrica.ADMINISTRADOR.RowChangeLog (ActionTypeId, TableId, [RowCount], UserName)
          VALUES (@ActionTypeId, @TableId, @RowCount, @UserName);
      END;






-------------------------------------------------------------------
-------------------------------------------------------------------
GO
CREATE TRIGGER trg_Audit_Administrador_Esquemas
   ON Administrador.Esquemas--, Administrador.RowChangeLog, Administrador.Tablas, Administrador.TipoAccion
   AFTER INSERT, UPDATE, DELETE
   AS
      BEGIN
          SET NOCOUNT ON;
          DECLARE @ActionTypeId TINYINT;
          DECLARE @TableId SMALLINT;
          DECLARE @RowCount INT;
          DECLARE @UserName NVARCHAR(128);
          DECLARE @ActionType NVARCHAR(12);

          IF EXISTS (SELECT 1 FROM inserted)
          BEGIN
              IF EXISTS (SELECT 1 FROM deleted)
                  SET @ActionTypeId = (SELECT ActionTypeId FROM Intelimetrica.ADMINISTRADOR.TipoAccion WHERE ActionType = 'UPDATE');
              ELSE
                  SET @ActionTypeId = (SELECT ActionTypeId FROM Intelimetrica.ADMINISTRADOR.TipoAccion WHERE ActionType = 'INSERT');
          END
          ELSE IF EXISTS (SELECT 1 FROM deleted)
             BEGIN
                 SET @ActionTypeId = (SELECT ActionTypeId FROM Intelimetrica.ADMINISTRADOR.TipoAccion WHERE ActionType = 'DELETE');
             END
          ELSE
             BEGIN
                 SET @ActionTypeId = (SELECT ActionTypeId FROM Intelimetrica.ADMINISTRADOR.TipoAccion WHERE ActionType = 'DESCONOCIDO');
             END
    
          SET @TableId = 0; 
          SET @RowCount = (SELECT COUNT(*) FROM inserted) + (SELECT COUNT(*) FROM deleted);
          SET @UserName = SYSTEM_USER;

          INSERT INTO Intelimetrica.ADMINISTRADOR.RowChangeLog (ActionTypeId, TableId, [RowCount], UserName)
          VALUES (@ActionTypeId, @TableId, @RowCount, @UserName);
      END;








-------------------------------------------------------------------
-------------------------------------------------------------------
GO
CREATE TRIGGER trg_Audit_Administrador_RowChangeLog
   ON Administrador.RowChangeLog--, Administrador.Tablas, Administrador.TipoAccion
   AFTER INSERT, UPDATE, DELETE
   AS
      BEGIN
          SET NOCOUNT ON;
          DECLARE @ActionTypeId TINYINT;
          DECLARE @TableId SMALLINT;
          DECLARE @RowCount INT;
          DECLARE @UserName NVARCHAR(128);
          DECLARE @ActionType NVARCHAR(12);

          IF EXISTS (SELECT 1 FROM inserted)
          BEGIN
              IF EXISTS (SELECT 1 FROM deleted)
                  SET @ActionTypeId = (SELECT ActionTypeId FROM Intelimetrica.ADMINISTRADOR.TipoAccion WHERE ActionType = 'UPDATE');
              ELSE
                  SET @ActionTypeId = (SELECT ActionTypeId FROM Intelimetrica.ADMINISTRADOR.TipoAccion WHERE ActionType = 'INSERT');
          END
          ELSE IF EXISTS (SELECT 1 FROM deleted)
             BEGIN
                 SET @ActionTypeId = (SELECT ActionTypeId FROM Intelimetrica.ADMINISTRADOR.TipoAccion WHERE ActionType = 'DELETE');
             END
          ELSE
             BEGIN
                 SET @ActionTypeId = (SELECT ActionTypeId FROM Intelimetrica.ADMINISTRADOR.TipoAccion WHERE ActionType = 'DESCONOCIDO');
             END
    
          SET @TableId = 0; 
          SET @RowCount = (SELECT COUNT(*) FROM inserted) + (SELECT COUNT(*) FROM deleted);
          SET @UserName = SYSTEM_USER;

          INSERT INTO Intelimetrica.ADMINISTRADOR.RowChangeLog (ActionTypeId, TableId, [RowCount], UserName)
          VALUES (@ActionTypeId, @TableId, @RowCount, @UserName);
      END;





-------------------------------------------------------------------
-------------------------------------------------------------------
GO
CREATE TRIGGER trg_Audit_Administrador_Tablas
   ON  Administrador.Tablas--, Administrador.TipoAccion
   AFTER INSERT, UPDATE, DELETE
   AS
      BEGIN
          SET NOCOUNT ON;
          DECLARE @ActionTypeId TINYINT;
          DECLARE @TableId SMALLINT;
          DECLARE @RowCount INT;
          DECLARE @UserName NVARCHAR(128);
          DECLARE @ActionType NVARCHAR(12);

          IF EXISTS (SELECT 1 FROM inserted)
          BEGIN
              IF EXISTS (SELECT 1 FROM deleted)
                  SET @ActionTypeId = (SELECT ActionTypeId FROM Intelimetrica.ADMINISTRADOR.TipoAccion WHERE ActionType = 'UPDATE');
              ELSE
                  SET @ActionTypeId = (SELECT ActionTypeId FROM Intelimetrica.ADMINISTRADOR.TipoAccion WHERE ActionType = 'INSERT');
          END
          ELSE IF EXISTS (SELECT 1 FROM deleted)
             BEGIN
                 SET @ActionTypeId = (SELECT ActionTypeId FROM Intelimetrica.ADMINISTRADOR.TipoAccion WHERE ActionType = 'DELETE');
             END
          ELSE
             BEGIN
                 SET @ActionTypeId = (SELECT ActionTypeId FROM Intelimetrica.ADMINISTRADOR.TipoAccion WHERE ActionType = 'DESCONOCIDO');
             END
    
          SET @TableId = 0; 
          SET @RowCount = (SELECT COUNT(*) FROM inserted) + (SELECT COUNT(*) FROM deleted);
          SET @UserName = SYSTEM_USER;

          INSERT INTO Intelimetrica.ADMINISTRADOR.RowChangeLog (ActionTypeId, TableId, [RowCount], UserName)
          VALUES (@ActionTypeId, @TableId, @RowCount, @UserName);
      END;





-------------------------------------------------------------------
-------------------------------------------------------------------
GO
CREATE TRIGGER trg_Audit_Administrador_TipoAccion
   ON Administrador.TipoAccion
   AFTER INSERT, UPDATE, DELETE
   AS
      BEGIN
          SET NOCOUNT ON;
          DECLARE @ActionTypeId TINYINT;
          DECLARE @TableId SMALLINT;
          DECLARE @RowCount INT;
          DECLARE @UserName NVARCHAR(128);
          DECLARE @ActionType NVARCHAR(12);

          IF EXISTS (SELECT 1 FROM inserted)
          BEGIN
              IF EXISTS (SELECT 1 FROM deleted)
                  SET @ActionTypeId = (SELECT ActionTypeId FROM Intelimetrica.ADMINISTRADOR.TipoAccion WHERE ActionType = 'UPDATE');
              ELSE
                  SET @ActionTypeId = (SELECT ActionTypeId FROM Intelimetrica.ADMINISTRADOR.TipoAccion WHERE ActionType = 'INSERT');
          END
          ELSE IF EXISTS (SELECT 1 FROM deleted)
             BEGIN
                 SET @ActionTypeId = (SELECT ActionTypeId FROM Intelimetrica.ADMINISTRADOR.TipoAccion WHERE ActionType = 'DELETE');
             END
          ELSE
             BEGIN
                 SET @ActionTypeId = (SELECT ActionTypeId FROM Intelimetrica.ADMINISTRADOR.TipoAccion WHERE ActionType = 'DESCONOCIDO');
             END
    
          SET @TableId = 0; 
          SET @RowCount = (SELECT COUNT(*) FROM inserted) + (SELECT COUNT(*) FROM deleted);
          SET @UserName = SYSTEM_USER;

          INSERT INTO Intelimetrica.ADMINISTRADOR.RowChangeLog (ActionTypeId, TableId, [RowCount], UserName)
          VALUES (@ActionTypeId, @TableId, @RowCount, @UserName);
      END;


GO
CREATE TRIGGER trg_Audit_Restaurant_Restaurants
   ON Restaurant.Restaurants
   AFTER INSERT, UPDATE, DELETE
   AS
      BEGIN
          SET NOCOUNT ON;
          DECLARE @ActionTypeId TINYINT;
          DECLARE @TableId SMALLINT;
          DECLARE @RowCount INT;
          DECLARE @UserName NVARCHAR(128);
          DECLARE @ActionType NVARCHAR(12);

          IF EXISTS (SELECT 1 FROM inserted)
          BEGIN
              IF EXISTS (SELECT 1 FROM deleted)
                  SET @ActionTypeId = (SELECT ActionTypeId FROM Intelimetrica.ADMINISTRADOR.TipoAccion WHERE ActionType = 'UPDATE');
              ELSE
                  SET @ActionTypeId = (SELECT ActionTypeId FROM Intelimetrica.ADMINISTRADOR.TipoAccion WHERE ActionType = 'INSERT');
          END
          ELSE IF EXISTS (SELECT 1 FROM deleted)
             BEGIN
                 SET @ActionTypeId = (SELECT ActionTypeId FROM Intelimetrica.ADMINISTRADOR.TipoAccion WHERE ActionType = 'DELETE');
             END
          ELSE
             BEGIN
                 SET @ActionTypeId = (SELECT ActionTypeId FROM Intelimetrica.ADMINISTRADOR.TipoAccion WHERE ActionType = 'DESCONOCIDO');
             END
    
          SET @TableId = 0; 
          SET @RowCount = (SELECT COUNT(*) FROM inserted) + (SELECT COUNT(*) FROM deleted);
          SET @UserName = SYSTEM_USER;
          IF @UserName <> 'API_Intelimetrica'
             BEGIN
                 INSERT INTO Intelimetrica.ADMINISTRADOR.RowChangeLog (ActionTypeId, TableId, [RowCount], UserName)
                 VALUES (@ActionTypeId, @TableId, @RowCount, @UserName);
             END
      END;

