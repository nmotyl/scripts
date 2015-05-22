USE [_FileTransferChild]
GO

PRINT 'Creating table [FILE_TRANSFER_FILES]'
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

CREATE TABLE [dbo].[FILE_TRANSFER_FILES](
	[File_Transfer_Files_ID] [int] IDENTITY(1,1) NOT NULL,
	[File_Transfer_Instance_ID] [int] NOT NULL,
	[Input_File_Name] [nvarchar](1000) NOT NULL,
	[Output_File_Name] [nvarchar](1000) NULL,
	[FILE_BINARY] [nvarchar](max) NOT NULL,
	[Transfer_Status] [int] NOT NULL,
	[Upload_Date] [datetime] NULL,
	[Download_Date] [datetime] NULL,
	[Purge_Date] [datetime] NULL,
 CONSTRAINT [PK_FILE_TRANSFER_FILES] PRIMARY KEY CLUSTERED 
(
	[File_Transfer_Files_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

ALTER TABLE [dbo].[FILE_TRANSFER_FILES] ADD  CONSTRAINT [DF_FILE_TRANSFER_FILES_Transfer_Status]  DEFAULT ((0)) FOR [Transfer_Status]
GO


PRINT 'Table created'
GO
