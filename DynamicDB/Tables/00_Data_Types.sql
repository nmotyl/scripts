USE [DynamicDB]
GO

/*
Table Creation Script
©Nathan Motyl
http://nmotyl.github.io/
*/

PRINT 'Creating table Data_Types'
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Data_Types](
	[DataTypeID] [int] IDENTITY(1,1) NOT NULL,
	[Data_Type] [nvarchar](50) NOT NULL,
	[Date_Record_Last_Modified] [datetime] NOT NULL,
	[Date_Record_Added] [datetime] NOT NULL,
	[User_Record_Last_Modified] [nvarchar](255) NOT NULL,
	[User_Record_Added] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_Data_Types] PRIMARY KEY CLUSTERED 
(
	[DataTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, DATA_COMPRESSION = PAGE) 
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Data_Types] ADD  CONSTRAINT [DF_Data_Types_Date_Record_Last_Modified]  DEFAULT (getdate()) FOR [Date_Record_Last_Modified]
GO

ALTER TABLE [dbo].[Data_Types] ADD  CONSTRAINT [DF_Data_Types_Date_Record_Added]  DEFAULT (getdate()) FOR [Date_Record_Added]
GO

ALTER TABLE [dbo].[Data_Types] ADD  CONSTRAINT [DF_Data_Types_User_Record_Last_Modified]  DEFAULT (suser_sname()) FOR [User_Record_Last_Modified]
GO

ALTER TABLE [dbo].[Data_Types] ADD  CONSTRAINT [DF_Data_Types_User_Record_Added]  DEFAULT (suser_sname()) FOR [User_Record_Added]
GO

PRINT 'Table created'
GO


/***********************/
--SEED DATA
/***********************/

PRINT 'Seeding supported data types'
GO

INSERT INTO [dbo].[Data_Types] ([Data_Type])
SELECT 'DateTime'
UNION ALL
SELECT 'Integer'
UNION ALL
SELECT 'Character'
UNION ALL
SELECT 'Money'
UNION ALL
SELECT 'XML'
GO

PRINT 'Data types seeded'
GO
