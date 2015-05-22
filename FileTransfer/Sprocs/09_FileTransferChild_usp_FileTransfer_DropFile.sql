USE [_FileTransferChild]
GO

PRINT 'Creating sproc [usp_FileTransfer_DropFile]'
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[usp_FileTransfer_DropFile]
(
@iFile_Transfer_Files_ID int
)

AS

/*
Sproc Creation Script
©Nathan Motyl
http://nmotyl.github.io/
*/

BEGIN TRY

SET NOCOUNT ON;

DECLARE @TransferStatus int, @sSprocName nvarchar(255), @sBaseErr nvarchar(1000);

SELECT @sSprocName = object_name(@@procid); 

/*
1 = LOAD
2 = UNLOAD
3 = PURGE
*/

SELECT @TransferStatus = 3;

UPDATE [dbo].[FILE_TRANSFER_FILES]
   SET [FILE_BINARY] = '0',
	   [Transfer_Status] = @TransferStatus
 WHERE [File_Transfer_Instance_ID] = @iFile_Transfer_Files_ID;

END TRY

BEGIN CATCH
	 SELECT @sBaseErr = 'Errors experienced running ' + @sSprocName + '. Processing aborted.';
     RAISERROR (@sBaseErr,16,1)
END CATCH

GO

PRINT 'Sproc created'
GO

