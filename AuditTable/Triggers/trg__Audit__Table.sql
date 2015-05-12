

/*
Trigger Creation Script
©Nathan Motyl
http://nmotyl.github.io/
*/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[trg__Audit__Table]
   ON  [dbo].[SERVERS]
   AFTER UPDATE,DELETE
AS 

    SET NOCOUNT ON;

--This IF block is used to prevent trigger recursion, should you have triggers that update system data like this. If you don't, the IF can be removed.
IF NOT ( UPDATE (Last_Update_Date) OR UPDATE (Last_Update_User) )
  BEGIN
    DECLARE @Before_AuditValue xml, @After_AuditValue xml; 

    SET @Before_AuditValue = 
    (
        SELECT TOP 1 *
        FROM DELETED
        FOR XML AUTO
    )

    SET @After_AuditValue = 
    (
        SELECT TOP 1 *
        FROM INSERTED
        FOR XML AUTO
    )

    INSERT INTO [dbo].[__ADMIN_TABLE_AUDIT]
           (
           [TableSchema],
           [TableName],
           [Before_Value],
           [After_Value]
           )
           
    SELECT
        OBJECT_SCHEMA_NAME(so.parent_obj),
        OBJECT_NAME(so.parent_obj),
        @Before_AuditValue,
        @After_AuditValue
    FROM sysobjects so
    WHERE (so.id = @@PROCID)
    
  END
GO


