USE [DynamicDB]
GO

/*
Table Creation Script
©Nathan Motyl
http://nmotyl.github.io/
*/

PRINT 'Creating table Table_Values'
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Table_Values](
	[ColumnID] [bigint] NOT NULL,
	[RowID] [bigint] NOT NULL,
	[PartitionID] [tinyint] NOT NULL,
	[Value_DateTime] [datetime] NULL,
	[Value_Integer] [int] NULL,
	[Value_Money] [decimal](19,4) NULL,
	[Value_Character] [nvarchar](max) NULL,
	[Value_XML] [xml] NULL,
	[Status] [bit] NOT NULL,
	[Txn_Guid] [uniqueidentifier] NOT NULL,
	[Date_Record_Last_Modified] [datetime] NOT NULL,
	[Date_Record_Added] [datetime] NOT NULL,
	[User_Record_Last_Modified] [nvarchar](255) NOT NULL,
	[User_Record_Added] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_Table_Values] PRIMARY KEY CLUSTERED 
(
	[ColumnID] ASC,
	[RowID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, DATA_COMPRESSION = PAGE) 
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Table_Values]  WITH CHECK ADD  CONSTRAINT [FK_Table_Values_Table_Columns] FOREIGN KEY([ColumnID])
REFERENCES [dbo].[Table_Columns] ([ColumnID])
GO

ALTER TABLE [dbo].[Table_Values] CHECK CONSTRAINT [FK_Table_Values_Table_Columns]
GO

ALTER TABLE [dbo].[Table_Values] ADD  CONSTRAINT [DF_Table_Values_PartitionID]  DEFAULT ((1)) FOR [PartitionID]
GO

ALTER TABLE [dbo].[Table_Values] ADD  CONSTRAINT [DF_Table_Values_Status]  DEFAULT ((1)) FOR [Status]
GO

ALTER TABLE [dbo].[Table_Values] ADD  CONSTRAINT [DF_Table_Values_Date_Record_Last_Modified]  DEFAULT (getdate()) FOR [Date_Record_Last_Modified]
GO

ALTER TABLE [dbo].[Table_Values] ADD  CONSTRAINT [DF_Table_Values_Date_Record_Added]  DEFAULT (getdate()) FOR [Date_Record_Added]
GO

ALTER TABLE [dbo].[Table_Values] ADD  CONSTRAINT [DF_Table_Values_User_Record_Last_Modified]  DEFAULT (suser_sname()) FOR [User_Record_Last_Modified]
GO

ALTER TABLE [dbo].[Table_Values] ADD  CONSTRAINT [DF_Table_Values_User_Record_Added]  DEFAULT (suser_sname()) FOR [User_Record_Added]
GO

PRINT 'Table created'
GO
