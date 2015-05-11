USE [DynamicDB]
GO

PRINT 'Creating sproc [usp_Delete_Team]'
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_Delete_Team] (@Team nvarchar(100))
AS

/*
Sproc Creation Script
©Nathan Motyl
http://nmotyl.github.io/
*/

SET NOCOUNT ON;

--perform delete
BEGIN TRY
	UPDATE [dbo].[Teams] 
	SET [Status] = 0
	WHERE ([Team_Name] = @Team);
END TRY			
BEGIN CATCH
	RAISERROR ('Issue with team delete!',16,1);
	GOTO _END
END CATCH

--error endpoint
_END:
--statement term

GO

PRINT 'Sproc created'
GO
