
/*
Table Creation Script
©Nathan Motyl
http://nmotyl.github.io/
*/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[__ADMIN_TABLE_AUDIT](
	[HistoryID] [bigint] IDENTITY(1,1) NOT NULL,
	[TableSchema] [nvarchar](50) NOT NULL,
	[TableName] [nvarchar](256) NOT NULL,
	[Before_Value] [xml] NULL,
	[After_Value] [xml] NULL,
	[Create_Date] [datetime] NOT NULL CONSTRAINT [DF___ADMIN_TABLE_AUDIT_Create_Date]  DEFAULT (getdate()),
	[Create_User] [nvarchar](256) NOT NULL CONSTRAINT [DF___ADMIN_TABLE_AUDIT_Create_User]  DEFAULT (suser_sname()),
 CONSTRAINT [PK___ADMIN_TABLE_AUDIT] PRIMARY KEY NONCLUSTERED 
(
	[HistoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
) 

GO


