USE [DynamicDB]
GO

PRINT 'Creating sproc [usp_GetErrorInfo]'
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_GetErrorInfo]
AS

/*
Sproc Creation Script
©Nathan Motyl
http://nmotyl.github.io/
*/

    SELECT 
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_SEVERITY() AS ErrorSeverity,
        ERROR_STATE() as ErrorState,
        ERROR_PROCEDURE() as ErrorProcedure,
        ERROR_LINE() as ErrorLine,
        ERROR_MESSAGE() as ErrorMessage;

GO

PRINT 'Sproc created'
GO
