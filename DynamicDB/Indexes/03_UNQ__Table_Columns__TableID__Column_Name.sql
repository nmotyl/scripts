USE [DynamicDB]
GO

/*
Index Creation Script
©Nathan Motyl
http://nmotyl.github.io/
*/

PRINT 'Creating index UNQ__Table_Columns__TableID__Column_Name'
GO

CREATE NONCLUSTERED INDEX [UNQ__Table_Columns__TableID__Column_Name] ON [dbo].[Table_Columns] 
(
	[TableID] ASC,
	[Column_Name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, DATA_COMPRESSION = PAGE) 
GO

PRINT 'Index seeded'
GO