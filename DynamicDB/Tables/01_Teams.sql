USE [DynamicDB]
GO

/*
Table Creation Script
©Nathan Motyl
http://nmotyl.github.io/
*/

PRINT 'Creating table Teams'
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Teams](
	[TeamID] [int] IDENTITY(1,1) NOT NULL,
	[PartitionID] [tinyint] NOT NULL,
	[Team_Name] [nvarchar](100) NOT NULL,
	[Status] [bit] NOT NULL,
	[Date_Record_Last_Modified] [datetime] NOT NULL,
	[Date_Record_Added] [datetime] NOT NULL,
	[User_Record_Last_Modified] [nvarchar](255) NOT NULL,
	[User_Record_Added] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_Teams] PRIMARY KEY CLUSTERED 
(
	[TeamID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, DATA_COMPRESSION = PAGE) 
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Teams] ADD  CONSTRAINT [DF_Teams_PartitionID]  DEFAULT ((1)) FOR [PartitionID]
GO

ALTER TABLE [dbo].[Teams] ADD  CONSTRAINT [DF_Teams_Status]  DEFAULT ((1)) FOR [Status]
GO

ALTER TABLE [dbo].[Teams] ADD  CONSTRAINT [DF_Teams_Date_Record_Last_Modified]  DEFAULT (getdate()) FOR [Date_Record_Last_Modified]
GO

ALTER TABLE [dbo].[Teams] ADD  CONSTRAINT [DF_Teams_Date_Record_Added]  DEFAULT (getdate()) FOR [Date_Record_Added]
GO

ALTER TABLE [dbo].[Teams] ADD  CONSTRAINT [DF_Teams_User_Record_Last_Modified]  DEFAULT (suser_sname()) FOR [User_Record_Last_Modified]
GO

ALTER TABLE [dbo].[Teams] ADD  CONSTRAINT [DF_Teams_User_Record_Added]  DEFAULT (suser_sname()) FOR [User_Record_Added]
GO

PRINT 'Table created'
GO
