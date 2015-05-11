USE [DynamicDB]
GO

PRINT 'Creating sproc [usp_Show_Schema]'
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_Show_Schema] (@Team nvarchar(100) = 'ALL', @Table_Name nvarchar(100) = 'ALL')
AS

/*
Sproc Creation Script
©Nathan Motyl
http://nmotyl.github.io/
*/

SET NOCOUNT ON;

/*
DECLARE @Team nvarchar(100), @Table_Name nvarchar(100);
SELECT @Team = 'DBA', @Table_Name = 'user';
SELECT @Team = 'ALL', @Table_Name = 'ALL';
*/

SELECT tm.TeamID
      ,tc.[TableID]
      ,tc.[ColumnID]
      ,tc.[DataTypeID]
      ,tm.Team_Name
      ,t.Table_Name
      ,tc.[Column_Name]
      ,d.Data_Type
      ,tm.[Status] AS Team_Status
      ,t.[Status] AS Table_Status
      ,tc.[Status] AS Table_Column_Status
      ,tm.[PartitionID] AS Team_PartitionID
      ,t.[PartitionID] AS Table_PartitionID
      ,tc.[PartitionID] AS Table_Column_PartitionID
  FROM [dbo].[Table_Columns] tc WITH (NOLOCK) 
	JOIN dbo.[Tables] t WITH (NOLOCK)
		ON tc.TableID = t.TableID
	JOIN dbo.Data_Types d WITH (NOLOCK)
		ON tc.DataTypeID = d.DataTypeID
	JOIN dbo.Teams tm WITH (NOLOCK)
		ON t.TeamID = tm.TeamID
  WHERE ((tm.Team_Name = @Team) OR (@Team = 'ALL')) AND ((t.Table_Name = @Table_Name) OR (@Table_Name = 'ALL'))
  

GO

PRINT 'Sproc created'
GO
