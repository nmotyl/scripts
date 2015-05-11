USE [DynamicDB]
GO


PRINT 'Creating sproc [usp_Insert_Data_by_Item]'
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_Insert_Data_by_Item] 
(
@ColumnID bigint, @RowID bigint, @PartitionID tinyint, 
@Value_DateTime datetime  = NULL, @Value_Integer int  = NULL, @Value_Money money = NULL, @Value_Character nvarchar(max)  = NULL, @Value_XML xml  = NULL,
@Txn_Guid uniqueidentifier
)
AS

/*
Sproc Creation Script
©Nathan Motyl
http://nmotyl.github.io/
*/

SET NOCOUNT ON;

BEGIN TRY
INSERT INTO [dbo].[Table_Values]
           ([ColumnID]
           ,[RowID]
           ,[PartitionID]
           ,[Value_DateTime]
           ,[Value_Integer]
           ,[Value_Money]
           ,[Value_Character]
           ,[Value_XML]
           ,[Txn_Guid])
     VALUES
           (@ColumnID, 
            @RowID, 
            @PartitionID, 
			@Value_DateTime, 
			@Value_Integer,
			@Value_Money, 
			@Value_Character,
			@Value_XML,
			@Txn_Guid);
END TRY
BEGIN CATCH
	RAISERROR ('Problem with row item insert!',16,1);
	EXECUTE dbo.usp_GetErrorInfo;
END CATCH
			
GO

PRINT 'Sproc created'
GO