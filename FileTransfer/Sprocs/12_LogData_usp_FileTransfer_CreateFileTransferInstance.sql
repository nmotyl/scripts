USE [LogData]
GO

PRINT 'Creating sproc [usp_FileTransfer_CreateFileTransferInstance]'
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[usp_FileTransfer_CreateFileTransferInstance]
(
@iServer_Collection_Group_ID int = 1,
@sTransfer_Instance_Name nvarchar(50),
@sSource_Directory nvarchar(500),
@sSource_Search_Filename_Wildcard nvarchar(50),
@sSource_Archive_Directory nvarchar(500) = 'NONE',
@sTarget_Directory  nvarchar(500),
@sTarget_Extension nvarchar(10) = NULL,
@sTarget_Filename_Front_Inject nvarchar(10) = NULL,
@sTarget_Filename_Middle_Inject nvarchar(10) = NULL,
@sTarget_Filename_End_Inject nvarchar(10) = NULL
)

AS

/*
Sproc Creation Script
©Nathan Motyl
http://nmotyl.github.io/
*/

BEGIN TRY

SET NOCOUNT ON;

DECLARE @sSprocName nvarchar(255), @sBaseErr nvarchar(1000);

SELECT @sSprocName = object_name(@@procid); 

INSERT INTO [dbo].[FILE_TRANSFER_INSTANCES]
           ([Server_Collection_Group_ID]
           ,[Transfer_Instance_Name]
           ,[Source_Directory]
           ,[Source_Search_Filename_Wildcard]
           ,[Source_Archive_Directory]
           ,[Target_Directory]
           ,[Target_Extension]
           ,[Target_Filename_Front_Inject]
           ,[Target_Filename_Middle_Inject]
           ,[Target_Filename_End_Inject])
     VALUES
           (@iServer_Collection_Group_ID
           ,@sTransfer_Instance_Name
           ,@sSource_Directory
           ,@sSource_Search_Filename_Wildcard
           ,@sSource_Archive_Directory
           ,@sTarget_Directory
           ,@sTarget_Extension
           ,@sTarget_Filename_Front_Inject
           ,@sTarget_Filename_Middle_Inject
           ,@sTarget_Filename_End_Inject);

END TRY

BEGIN CATCH
	 SELECT @sBaseErr = 'Errors experienced running ' + @sSprocName + '. Processing aborted.';
     RAISERROR (@sBaseErr,16,1)
END CATCH

GO

PRINT 'Sproc created'
GO