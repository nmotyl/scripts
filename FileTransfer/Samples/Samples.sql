USE [LogData]
GO

/*
Example to show full functionality of file manipulation:
	1. archive ability - preserves file in archive .zip in archive folder
	2. file name injection - inserts text into the file name front, middle, and rear. 
	3. new file extension
*/

--Declare and set variables
DECLARE @iServer_Collection_Group_ID int,
@sTransfer_Instance_Name nvarchar(50),
@sSource_Directory nvarchar(500),
@sSource_Search_Filename_Wildcard nvarchar(50),
@sSource_Archive_Directory nvarchar(500),
@sTarget_Directory  nvarchar(500),
@sTarget_Extension nvarchar(10),
@sTarget_Filename_Front_Inject nvarchar(10),
@sTarget_Filename_Middle_Inject nvarchar(10),
@sTarget_Filename_End_Inject nvarchar(10);

SELECT @iServer_Collection_Group_ID = 1,
@sTransfer_Instance_Name = 'Full Manipulation',
@sSource_Directory = 'C:\FileTransfer\Source',
@sSource_Search_Filename_Wildcard = '*.log',
@sSource_Archive_Directory = 'C:\FileTransfer\Archive',
@sTarget_Directory  = 'C:\FileTransfer\Target',
@sTarget_Extension = 'dlog',
@sTarget_Filename_Front_Inject = 'front',
@sTarget_Filename_Middle_Inject = 'middle',
@sTarget_Filename_End_Inject = 'end';


--execute creation 
EXEC [dbo].[usp_FileTransfer_CreateFileTransferInstance]
@iServer_Collection_Group_ID,
@sTransfer_Instance_Name,
@sSource_Directory,
@sSource_Search_Filename_Wildcard,
@sSource_Archive_Directory,
@sTarget_Directory,
@sTarget_Extension,
@sTarget_Filename_Front_Inject,
@sTarget_Filename_Middle_Inject,
@sTarget_Filename_End_Inject;


/*
Example to show file extension changing at target location
*/

--set variables
SELECT @iServer_Collection_Group_ID = 1,
@sTransfer_Instance_Name = 'File Extension Swap',
@sSource_Directory = 'C:\FileTransfer\Source',
@sSource_Search_Filename_Wildcard = '*.log',
@sSource_Archive_Directory = 'NONE',
@sTarget_Directory  = 'C:\FileTransfer\Target',
@sTarget_Extension = 'txt',
@sTarget_Filename_Front_Inject = NULL,
@sTarget_Filename_Middle_Inject = NULL,
@sTarget_Filename_End_Inject = NULL;


--execute creation 
EXEC [dbo].[usp_FileTransfer_CreateFileTransferInstance]
@iServer_Collection_Group_ID,
@sTransfer_Instance_Name,
@sSource_Directory,
@sSource_Search_Filename_Wildcard,
@sSource_Archive_Directory,
@sTarget_Directory,
@sTarget_Extension,
@sTarget_Filename_Front_Inject,
@sTarget_Filename_Middle_Inject,
@sTarget_Filename_End_Inject;


/*
Example to show file migration only, with no changes to the file at target location
*/

--set variables
SELECT @iServer_Collection_Group_ID = 1,
@sTransfer_Instance_Name = 'Just Move the File!',
@sSource_Directory = 'C:\FileTransfer\Source',
@sSource_Search_Filename_Wildcard = '*.log',
@sSource_Archive_Directory = 'NONE',
@sTarget_Directory  = 'C:\FileTransfer\Target',
@sTarget_Extension = NULL,
@sTarget_Filename_Front_Inject = NULL,
@sTarget_Filename_Middle_Inject = NULL,
@sTarget_Filename_End_Inject = NULL;


--execute creation 
EXEC [dbo].[usp_FileTransfer_CreateFileTransferInstance]
@iServer_Collection_Group_ID,
@sTransfer_Instance_Name,
@sSource_Directory,
@sSource_Search_Filename_Wildcard,
@sSource_Archive_Directory,
@sTarget_Directory,
@sTarget_Extension,
@sTarget_Filename_Front_Inject,
@sTarget_Filename_Middle_Inject,
@sTarget_Filename_End_Inject;

/*
Example to show file migration only with name marker at front of target file
*/

--set variables
SELECT @iServer_Collection_Group_ID = 1,
@sTransfer_Instance_Name = 'Front file injection',
@sSource_Directory = 'C:\FileTransfer\Source',
@sSource_Search_Filename_Wildcard = '*.log',
@sSource_Archive_Directory = 'NONE',
@sTarget_Directory  = 'C:\FileTransfer\Target',
@sTarget_Extension = NULL,
@sTarget_Filename_Front_Inject = 'Borg',
@sTarget_Filename_Middle_Inject = NULL,
@sTarget_Filename_End_Inject = NULL;


--execute creation 
EXEC [dbo].[usp_FileTransfer_CreateFileTransferInstance]
@iServer_Collection_Group_ID,
@sTransfer_Instance_Name,
@sSource_Directory,
@sSource_Search_Filename_Wildcard,
@sSource_Archive_Directory,
@sTarget_Directory,
@sTarget_Extension,
@sTarget_Filename_Front_Inject,
@sTarget_Filename_Middle_Inject,
@sTarget_Filename_End_Inject;


