USE [_Release_Admin]
GO

PRINT 'Creating sproc [usp_Get_Default_SystemConfigs]'
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[usp_Get_Default_SystemConfigs]
(
@iServer_Collection_Group_ID int = 1
)
AS

/*
Sproc Creation Script
©Nathan Motyl
http://nmotyl.github.io/
*/

BEGIN TRY

SET NOCOUNT ON;

-- vars
DECLARE @sSprocName nvarchar(255), @sBaseErr nvarchar(1000);

SELECT @sSprocName = object_name(@@procid);

SELECT TOP 1 [ZIP_COMMAND], [ZIP_COMMAND_OPTIONS],
  [SCRIPT_FORMAT_FILE],[BCP_FILE],[BCP_SCRIPT_ERRFILE]
  FROM [dbo].[SYSTEM_CONFIG] WHERE [Server_Collection_Group_ID] = @iServer_Collection_Group_ID;
    
END TRY

BEGIN CATCH
	 SELECT @sBaseErr = 'Errors experienced running ' + @sSprocName + '. Processing aborted.';
     RAISERROR (@sBaseErr,16,1)
END CATCH

GO

PRINT 'Sproc created'
GO