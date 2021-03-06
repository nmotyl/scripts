USE [_FileTransferChild]
GO

PRINT 'Creating sproc usp_FileTransfer_SelectFile'
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[usp_FileTransfer_SelectFile] 
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

SELECT @TransferStatus = 1;

SELECT [File_Transfer_Instance_ID]
      ,[Input_File_Name]
      ,[FILE_BINARY]
      ,@TransferStatus AS [Transfer_Status]
      ,Getdate() AS [Upload_Date]
  FROM [dbo].[FILE_TRANSFER_FILES]
  WHERE [File_Transfer_Files_ID] = @iFile_Transfer_Files_ID

END TRY

BEGIN CATCH
	 SELECT @sBaseErr = 'Errors experienced running ' + @sSprocName + '. Processing aborted.';
     RAISERROR (@sBaseErr,16,1)
END CATCH

GO

PRINT 'Sproc created'
GO