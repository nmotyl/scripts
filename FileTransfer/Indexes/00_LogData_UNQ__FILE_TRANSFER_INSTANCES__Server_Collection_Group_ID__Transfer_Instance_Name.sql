USE [LogData]
GO


PRINT 'Creating index [UNQ__FILE_TRANSFER_INSTANCES__Server_Collection_Group_ID__Transfer_Instance_Name]'
GO

/*
Index Creation Script
©Nathan Motyl
http://nmotyl.github.io/
*/

CREATE UNIQUE NONCLUSTERED INDEX [UNQ__FILE_TRANSFER_INSTANCES__Server_Collection_Group_ID__Transfer_Instance_Name] ON [dbo].[FILE_TRANSFER_INSTANCES]
(
	[Server_Collection_Group_ID] ASC,
	[Transfer_Instance_Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

PRINT 'Index created'
GO
