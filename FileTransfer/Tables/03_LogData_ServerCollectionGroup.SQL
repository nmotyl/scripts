USE [LogData]
GO

PRINT 'Creating table [SERVER_COLLECTION_GROUP]'
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

CREATE TABLE [dbo].[SERVER_COLLECTION_GROUP](
	[Server_Collection_Group_ID] [int] IDENTITY(1,1) NOT NULL,
	[Server_Collection_Group_Name] [nvarchar](50) NOT NULL,
	[SMTP_Server] [nvarchar](50) NULL,
	[Alert_Email_Address] [nvarchar](50) NULL
 CONSTRAINT [PK_SERVER_COLLECTION_GROUP] PRIMARY KEY CLUSTERED 
(
	[Server_Collection_Group_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

PRINT 'Table created'
GO

PRINT 'Seeding data'
GO

INSERT INTO [dbo].[SERVER_COLLECTION_GROUP]
           ([Server_Collection_Group_Name]
           ,[SMTP_Server]
           ,[Alert_Email_Address])
     VALUES
           ('Default',
		   '.',
		   'nmotyl@gmail.com')
GO

PRINT 'Data seeded'
GO

