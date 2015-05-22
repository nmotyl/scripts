USE [_FileTransferChild]
GO

PRINT 'Creating sproc [usp_FileTransfer_LoadSourceFiles]'
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[usp_FileTransfer_LoadSourceFiles]
(
@iFile_Transfer_Instance_ID int,
@sInput_File_Name nvarchar(1000),
@FileFormat nvarchar(100)
)

AS

/*
Sproc Creation Script
©Nathan Motyl
http://nmotyl.github.io/
*/

BEGIN TRY

SET NOCOUNT ON;

DECLARE @iFile_Transfer_Files_ID int, @FileBin as nvarchar(max),@SQL as nvarchar(max), @TransferStatus int, @sSprocName nvarchar(255), @sBaseErr nvarchar(1000);

SELECT @sSprocName = object_name(@@procid); 

/*
SINGLE_BLOB, which reads a file as varbinary(max) 
SINGLE_CLOB, which reads a file as varchar(max) 
SINGLE_NCLOB, which reads a file as nvarchar(max) 
*/
SELECT @FileFormat = 'SINGLE_BLOB';

/*
1 = LOAD
2 = UNLOAD
3 = PURGE
*/

SELECT @TransferStatus = 1;

/*load blog into variable for insert*/
SELECT @SQL = 'SELECT BulkColumn AS fileblob INTO ##BIN FROM (SELECT * FROM OPENROWSET (BULK ' + CHAR(39) + @sInput_File_Name + CHAR(39) + ', '+ @FileFormat +')A)B;'
 EXECUTE (@SQL);
 SELECT @FileBin = fileblob FROM ##BIN;
 --SELECT @ScriptBin;
 DROP TABLE ##BIN;

--load file and metadata into table
INSERT INTO [dbo].[FILE_TRANSFER_FILES]
           ([File_Transfer_Instance_ID]
           ,[Input_File_Name]
           ,[FILE_BINARY]
           ,[Transfer_Status]
           ,[Upload_Date])
     VALUES
           (@iFile_Transfer_Instance_ID,
            @sInput_File_Name,
            @FileBin,
            @TransferStatus,
            GETDATE());

SELECT @iFile_Transfer_Files_ID = @@IDENTITY;

SELECT @iFile_Transfer_Files_ID AS File_Transfer_Files_ID;


END TRY

BEGIN CATCH
	 SELECT @sBaseErr = 'Errors experienced running ' + @sSprocName + '. Processing aborted.';
     RAISERROR (@sBaseErr,16,1)
END CATCH

GO

PRINT 'Sproc created'
GO

