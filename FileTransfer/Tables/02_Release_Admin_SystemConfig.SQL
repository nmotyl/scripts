USE [_Release_Admin]
GO

PRINT 'Creating table [SYSTEM_CONFIG]'
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

CREATE TABLE [dbo].[SYSTEM_CONFIG](
	[Server_Collection_Group_ID] [int] NOT NULL CONSTRAINT [DF_SYSTEM_CONFIG_SYSTEM_CONFIG_ID]  DEFAULT ((0)),
	[SCRIPT_FILE_FORMAT] [nvarchar](100) NULL,
	[SCRIPT_FORMAT_FILE] [nvarchar](100) NULL,
	[BCP_FILE] [nvarchar](200) NULL,
	[BCP_SCRIPT_ERRFILE] [nvarchar](100) NULL,
	[ZIP_COMMAND] [nvarchar](1000) NULL,
	[ZIP_COMMAND_OPTIONS] [nvarchar](100) NULL,
 CONSTRAINT [PK_SYSTEM_CONFIG] PRIMARY KEY CLUSTERED 
(
	[Server_Collection_Group_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

PRINT 'Table created'
GO

PRINT 'Seeding data'
GO

INSERT INTO [dbo].[SYSTEM_CONFIG]
           ([Server_Collection_Group_ID] 
           ,[SCRIPT_FILE_FORMAT]
           ,[SCRIPT_FORMAT_FILE]
           ,[BCP_FILE]
           ,[BCP_SCRIPT_ERRFILE]
           ,[ZIP_COMMAND]
           ,[ZIP_COMMAND_OPTIONS])
     VALUES
           (1, 
		   'SINGLE_BLOB',
		   'C:\FileTransfer\SYSTEM\SCRIPT.fmt',
		   'C:\Program Files\Microsoft SQL Server\100\Tools\Binn\bcp.exe',
		   'C:\FileTransfer\SYSTEM\BCPSCRIPT.OUT',
		   'C:\FileTransfer\SYSTEM\PKZIPC.EXE',
		   '-add -move')
GO

PRINT 'Data seeded'
GO

