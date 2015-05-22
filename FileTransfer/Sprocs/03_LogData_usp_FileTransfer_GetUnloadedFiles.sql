USE [LogData]
GO

PRINT 'Creating sproc usp_FileTransfer_GetUnloadedFiles'
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[usp_FileTransfer_GetUnloadedFiles]
(
@iServer_Collection_Group_ID int,
@sTransfer_Instance_Name nvarchar(50)
)

AS

/*
Sproc Creation Script
©Nathan Motyl
http://nmotyl.github.io/
*/

BEGIN TRY

SET NOCOUNT ON;

DECLARE @iFile_Transfer_Instance_ID int, @iFile_Transfer_Files_ID int, @TransferStatus int, @sSprocName nvarchar(255), @sBaseErr nvarchar(1000);

SELECT @sSprocName = object_name(@@procid); 

/*
1 = LOAD
2 = UNLOAD
3 = PURGE
*/

SELECT @TransferStatus = 2;

SELECT @iFile_Transfer_Instance_ID = [File_Transfer_Instance_ID]
 FROM [dbo].[FILE_TRANSFER_INSTANCES]
  WHERE ([Server_Collection_Group_ID] = @iServer_Collection_Group_ID)
      AND ([Transfer_Instance_Name] = @sTransfer_Instance_Name);

SELECT [File_Transfer_Files_ID] FROM [dbo].[FILE_TRANSFER_FILES]
 WHERE ([File_Transfer_Instance_ID] = @iFile_Transfer_Instance_ID) AND ([Transfer_Status] = @TransferStatus);

END TRY

BEGIN CATCH
	 SELECT @sBaseErr = 'Errors experienced running ' + @sSprocName + '. Processing aborted.';
     RAISERROR (@sBaseErr,16,1)
END CATCH

GO

PRINT 'Sproc created'
GO
