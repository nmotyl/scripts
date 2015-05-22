USE [LogData]
GO

PRINT 'Creating table [FILE_TRANSFER_INSTANCES]'
GO

/*
Table Creation Script
©Nathan Motyl
http://nmotyl.github.io/
*/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[FILE_TRANSFER_INSTANCES](
	[File_Transfer_Instance_ID] [int] IDENTITY(1,1) NOT NULL,
	[Server_Collection_Group_ID] [int] NOT NULL CONSTRAINT [DF_FILE_TRANSFER_INSTANCES_Server_Collection_Group_ID]  DEFAULT ((1)),
	[Transfer_Instance_Name] [nvarchar](50) NOT NULL,
	[Source_Directory] [nvarchar](500) NOT NULL,
	[Source_Search_Filename_Wildcard] [nvarchar](50) NOT NULL CONSTRAINT [DF_FILE_TRANSFER_INSTANCES_Source_Search_Filename_Wildcard]  DEFAULT (N'*.*'),
	[Source_Archive_Directory] [nvarchar](500) NOT NULL CONSTRAINT [DF_FILE_TRANSFER_INSTANCES_Source_Archive_Directory]  DEFAULT (N'NONE'),
	[Target_Directory] [nvarchar](500) NOT NULL,
	[Target_Extension] [nvarchar](10) NULL,
	[Target_Filename_Front_Inject] [nvarchar](10) NULL,
	[Target_Filename_Middle_Inject] [nvarchar](10) NULL,
	[Target_Filename_End_Inject] [nvarchar](10) NULL,
	[Instance_Create_Date] [datetime] NULL CONSTRAINT [DF_FILE_TRANSFER_INSTANCES_Instance_Create_Date]  DEFAULT (getdate()),
	[Instance_Create_User] [nvarchar](50) NULL CONSTRAINT [DF_FILE_TRANSFER_INSTANCES_Instance_Create_User]  DEFAULT (suser_sname())
) ON [PRIMARY]

GO


PRINT 'Table created'
GO