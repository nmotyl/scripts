USE [DynamicDB]
GO

PRINT 'Creating sproc [usp_Drop_Column]'
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_Drop_Column] (@Team nvarchar(100), @Table_Name nvarchar(100), @Column_Name nvarchar(100))
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
	
--perform drop
BEGIN TRY
	UPDATE [dbo].[Table_Columns] 
	SET [Status] = 0
	WHERE (TableID = @TableID) AND (Column_Name = @Column_Name);
END TRY			
BEGIN CATCH
	RAISERROR ('Issue with column drop!',16,1);
	GOTO _END
END CATCH

--error endpoint
_END:
--statement term

GO

PRINT 'Sproc created'
GO
