USE [DynamicDB]
GO

/*
Table Creation Script
©Nathan Motyl
http://nmotyl.github.io/
*/

PRINT 'Creating table Table_Columns'
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Table_Columns](
	[ColumnID] [bigint] IDENTITY(1,1) NOT NULL,
	[PartitionID] [tinyint] NOT NULL,
	[TableID] [bigint] NOT NULL,
	[Ordinal_Position] [int] NOT NULL,
	[DataTypeID] [int] NOT NULL,
	[Column_Name] [nvarchar](100) NOT NULL,
	[Status] [bit] NOT NULL,
	[Date_Record_Last_Modified] [datetime] NOT NULL,
	[Date_Record_Added] [datetime] NOT NULL,
	[User_Record_Last_Modified] [nvarchar](255) NOT NULL,
	[User_Record_Added] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_Table_Columns] PRIMARY KEY CLUSTERED 
(
	[ColumnID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, DATA_COMPRESSION = PAGE) 
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Table_Columns]  WITH CHECK ADD  CONSTRAINT [FK_Table_Columns_Data_Types] FOREIGN KEY([DataTypeID])
REFERENCES [dbo].[Data_Types] ([DataTypeID])
GO

ALTER TABLE [dbo].[Table_Columns] CHECK CONSTRAINT [FK_Table_Columns_Data_Types]
GO

ALTER TABLE [dbo].[Table_Columns]  WITH CHECK ADD  CONSTRAINT [FK_Table_Columns_Tables] FOREIGN KEY([TableID])
REFERENCES [dbo].[Tables] ([TableID])
GO

ALTER TABLE [dbo].[Table_Columns] CHECK CONSTRAINT [FK_Table_Columns_Tables]
GO

ALTER TABLE [dbo].[Table_Columns] ADD  CONSTRAINT [DF_Table_Columns_PartitionID]  DEFAULT ((1)) FOR [PartitionID]
GO

ALTER TABLE [dbo].[Table_Columns] ADD  CONSTRAINT [DF_Table_Columns_Column_Status]  DEFAULT ((1)) FOR [Status]
GO

ALTER TABLE [dbo].[Table_Columns] ADD  CONSTRAINT [Date_Record_Last_Modified]  DEFAULT (getdate()) FOR [Date_Record_Last_Modified]
GO

ALTER TABLE [dbo].[Table_Columns] ADD  CONSTRAINT [DF_Table_Columns_Date_Record_Added]  DEFAULT (getdate()) FOR [Date_Record_Added]
GO

ALTER TABLE [dbo].[Table_Columns] ADD  CONSTRAINT [DF_Table_Columns_User_Record_Last_Modified]  DEFAULT (suser_sname()) FOR [User_Record_Last_Modified]
GO

ALTER TABLE [dbo].[Table_Columns] ADD  CONSTRAINT [DF_Table_Columns_User_Record_Added]  DEFAULT (suser_sname()) FOR [User_Record_Added]
GO

PRINT 'Table created'
GO

