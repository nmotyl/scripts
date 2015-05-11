USE [DynamicDB]
GO

PRINT 'Creating sproc [usp_Create_Team]'
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_Create_Team] (@Team nvarchar(100), @PartitionID tinyint =1)
AS

/*
Sproc Creation Script
©Nathan Motyl
http://nmotyl.github.io/
*/

SET NOCOUNT ON;

--perform insert
BEGIN TRY
INSERT INTO [dbo].[Teams]
           ([PartitionID]
           ,[Team_Name])
     VALUES
           (@PartitionID, @Team);
END TRY			
BEGIN CATCH
	RAISERROR ('Issue with team insert!',16,1);
	GOTO _END
END CATCH

--error endpoint
_END:
--statement term

GO

PRINT 'Sproc created'
GO