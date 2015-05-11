USE [DynamicDB]
GO

PRINT 'Creating sproc [usp_Delete_Data]'
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_Delete_Data] (@Team nvarchar(100), @Table_Name nvarchar(100), @RowID bigint)
AS

/*
Sproc Creation Script
©Nathan Motyl
http://nmotyl.github.io/
*/

SET NOCOUNT ON;

DECLARE @TeamID int, @TableID bigint, @ColumnID bigint;

--get teamid
SELECT @TeamID = TeamID FROM Teams WITH (NOLOCK) WHERE Team_Name = @Team;

	IF ISNULL(@TeamID,0) = 0
	BEGIN
	 RAISERROR ('Invalid team!',16,1);
	 GOTO _END
	END
	
--get tableid
SELECT @TableID = TableID FROM [Tables] WITH (NOLOCK) WHERE (Table_Name = @Table_Name) AND (TeamID = @TeamID);

	IF ISNULL(@TableID,0) = 0
	BEGIN
	 RAISERROR ('Invalid table!',16,1);
	 GOTO _END
	END
	
--perform delete
BEGIN TRY
	UPDATE [dbo].[Table_Values] 
	SET [Status] = 0
	WHERE ColumnID IN 
		(
		 SELECT [ColumnID] FROM [Table_Columns] WITH (NOLOCK)
		 WHERE ([TableID] = @TableID)
		 ) AND (RowID = @RowID);
END TRY			
BEGIN CATCH
	RAISERROR ('Issue with delete!',16,1);
	GOTO _END
END CATCH

--error endpoint
_END:
--statement term


GO

PRINT 'Sproc created'
GO
