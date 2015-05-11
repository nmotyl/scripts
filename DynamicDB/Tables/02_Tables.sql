USE [DynamicDB]
GO

/*
Table Creation Script
©Nathan Motyl
http://nmotyl.github.io/
*/

PRINT 'Creating table Tables'
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Tables](
	[TableID] [bigint] IDENTITY(1,1) NOT NULL,
	[PartitionID] [tinyint] NOT NULL,
	[TeamID] [int] NOT NULL,
	[Table_Name] [nvarchar](100) NOT NULL,
	[Status] [bit] NOT NULL,
	[Date_Record_Last_Modified] [datetime] NOT NULL,
	[Date_Record_Added] [datetime] NOT NULL,
	[User_Record_Last_Modified] [nvarchar](255) NOT NULL,
	[User_Record_Added] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_Tables_1] PRIMARY KEY CLUSTERED 
(
	[TableID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, DATA_COMPRESSION = PAGE) 
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Tables]  WITH CHECK ADD  CONSTRAINT [FK_Tables_Teams] FOREIGN KEY([TeamID])
REFERENCES [dbo].[Teams] ([TeamID])
GO

ALTER TABLE [dbo].[Tables] CHECK CONSTRAINT [FK_Tables_Teams]
GO

ALTER TABLE [dbo].[Tables] ADD  CONSTRAINT [DF_Tables_PartitionID]  DEFAULT ((1)) FOR [PartitionID]
GO

ALTER TABLE [dbo].[Tables] ADD  CONSTRAINT [DF_Tables_Status]  DEFAULT ((1)) FOR [Status]
GO

ALTER TABLE [dbo].[Tables] ADD  CONSTRAINT [DF_Tables_Date_Record_Last_Modified]  DEFAULT (getdate()) FOR [Date_Record_Last_Modified]
GO

ALTER TABLE [dbo].[Tables] ADD  CONSTRAINT [DF_Tables_Date_Record_Added]  DEFAULT (getdate()) FOR [Date_Record_Added]
GO

ALTER TABLE [dbo].[Tables] ADD  CONSTRAINT [DF_Tables_User_Record_Last_Modified]  DEFAULT (suser_sname()) FOR [User_Record_Last_Modified]
GO

ALTER TABLE [dbo].[Tables] ADD  CONSTRAINT [DF_Tables_User_Record_Added]  DEFAULT (suser_sname()) FOR [User_Record_Added]
GO


PRINT 'Table created'
GO
