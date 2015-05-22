USE [LogData]
GO

PRINT 'Creating sproc [usp_FileTransfer_SetFileStatusDownloaded]'
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[usp_FileTransfer_SetFileStatusDownloaded]
(
@iFile_Transfer_Files_ID int,
@sDestination_File_Name nvarchar(1000)
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

SELECT @TransferStatus = 2;

UPDATE [dbo].[FILE_TRANSFER_FILES]
   SET [Transfer_Status] = @TransferStatus
	  ,[Output_File_Name] = @sDestination_File_Name
      ,[Download_Date] = GETDATE()
 WHERE (File_Transfer_Files_ID = @iFile_Transfer_Files_ID);

END TRY

BEGIN CATCH
	 SELECT @sBaseErr = 'Errors experienced running ' + @sSprocName + '. Processing aborted.';
     RAISERROR (@sBaseErr,16,1)
END CATCH


GO

PRINT 'Sproc created'
GO

