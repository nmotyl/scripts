USE [LogData]
GO

PRINT 'Creating sproc [usp_FileTransfer_GetSourceInstanceInfo]'
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[usp_FileTransfer_GetSourceInstanceInfo]
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

DECLARE @sSprocName nvarchar(255), @sBaseErr nvarchar(1000);

SELECT @sSprocName = object_name(@@procid); 

SELECT [File_Transfer_Instance_ID]
	  ,CASE RIGHT([Source_Directory],1) WHEN '\' THEN [Source_Directory] ELSE ([Source_Directory] + '\') END AS Source_Directory
      ,[Source_Search_Filename_Wildcard]
	  ,CASE RIGHT([Source_Archive_Directory],1) WHEN '\' THEN [Source_Archive_Directory] ELSE ([Source_Archive_Directory] + '\') END AS Source_Archive_Directory
 FROM [dbo].[FILE_TRANSFER_INSTANCES]
  WHERE ([Server_Collection_Group_ID] = @iServer_Collection_Group_ID)
      AND ([Transfer_Instance_Name] = @sTransfer_Instance_Name);

END TRY

BEGIN CATCH
	 SELECT @sBaseErr = 'Errors experienced running ' + @sSprocName + '. Processing aborted.';
     RAISERROR (@sBaseErr,16,1)
END CATCH
GO

PRINT 'Sproc created'
GO