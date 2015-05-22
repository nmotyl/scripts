USE [LogData]
GO

PRINT 'Creating sproc [usp_FileTransfer_GenerateOutputFileName]'
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[usp_FileTransfer_GenerateOutputFileName]
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

DECLARE @sInput_File_Name nvarchar(1000), @sOldFileName nvarchar(50), @sOldDirectory nvarchar(500), 
	 @sOldExtension nvarchar(10), @sTarget_Extension nvarchar(10), @sTarget_Directory nvarchar(500), 
     @sTarget_Filename_Front_Inject nvarchar(10), @sTarget_Filename_Middle_Inject nvarchar(10), @sTarget_Filename_End_Inject nvarchar(10),
     @iFile_Transfer_Instance_ID int, @sSprocName nvarchar(255), @sBaseErr nvarchar(1000);

SELECT @sSprocName = object_name(@@procid); 

SELECT @iFile_Transfer_Instance_ID = [File_Transfer_Instance_ID], @sInput_File_Name = REPLACE([Input_File_Name],'.LOAD','')
FROM [dbo].[FILE_TRANSFER_FILES] WHERE ([File_Transfer_Files_ID] = @iFile_Transfer_Files_ID);

--GET TARGET VALUES
SELECT @sTarget_Extension = [Target_Extension],
       @sTarget_Directory = CASE WHEN RIGHT(@sTarget_Directory,1) = '\' THEN [Target_Directory] ELSE [Target_Directory] + '\' END,
       @sTarget_Filename_Front_Inject = ISNULL([Target_Filename_Front_Inject],''),
       @sTarget_Filename_Middle_Inject = ISNULL([Target_Filename_Middle_Inject],''),
       @sTarget_Filename_End_Inject = ISNULL([Target_Filename_End_Inject],'')
  FROM [dbo].[FILE_TRANSFER_INSTANCES] WHERE ([File_Transfer_Instance_ID] = @iFile_Transfer_Instance_ID);

--GET OLD FILE VALUES
SELECT @sOldDirectory = LEFT(@sInput_File_Name, (LEN(@sInput_File_Name) - CHARINDEX('\', REVERSE(@sInput_File_Name))));
--SELECT @sOldDirectory

SELECT @sOldFileName = SUBSTRING(@sInput_File_Name, 
						(LEN(@sInput_File_Name) - CHARINDEX('\', REVERSE(@sInput_File_Name)) + 2) , 
							(CHARINDEX('\', REVERSE(@sInput_File_Name)) - CHARINDEX('.', REVERSE(@sInput_File_Name)) - 1));
--SELECT @sOldFileName
				 
SELECT @sOldExtension = RIGHT(@sInput_File_Name, CHARINDEX('.', REVERSE(@sInput_File_Name)) - 1);
--SELECT @sOldExtension				 

--FILE NAME CREATION
SELECT @sTarget_Directory + @sTarget_Filename_Front_Inject + LEFT(@sOldFileName, (LEN(@sOldFileName)/2)) + @sTarget_Filename_Middle_Inject + RIGHT(@sOldFileName, (LEN(@sOldFileName) - LEN(@sOldFileName)/2)) + @sTarget_Filename_End_Inject + '.' + ISNULL(@sTarget_Extension, @sOldExtension) AS NewFile;

END TRY

BEGIN CATCH
	 SELECT @sBaseErr = 'Errors experienced running ' + @sSprocName + '. Processing aborted.';
     RAISERROR (@sBaseErr,16,1)
END CATCH

GO

PRINT 'Sproc created'
GO

