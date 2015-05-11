USE [DynamicDB]
GO

PRINT 'Creating sproc [usp_Drop_Table]'
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_Drop_Table] (@Team nvarchar(100), @Table_Name nvarchar(100))
AS

/*
Sproc Creation Script
©Nathan Motyl
http://nmotyl.github.io/
*/

SET NOCOUNT ON;

DECLARE @TeamID int;

--get teamid
SELECT @TeamID = TeamID FROM Teams WITH (NOLOCK) WHERE Team_Name = @Team;

	IF ISNULL(@TeamID,0) = 0
	BEGIN
	 RAISERROR ('Invalid team!',16,1);
	 GOTO _END
	END
	
--perform delete
BEGIN TRY
	UPDATE [dbo].[Tables] 
	SET [Status] = 0
	WHERE ([TeamID] = @TeamID) AND ([Table_Name] = @Table_Name);
END TRY			
BEGIN CATCH
	RAISERROR ('Issue with table drop!',16,1);
	GOTO _END
END CATCH

--error endpoint
_END:
--statement term


GO

PRINT 'Sproc created'
GO