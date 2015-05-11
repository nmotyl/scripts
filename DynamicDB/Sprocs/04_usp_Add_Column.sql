USE [DynamicDB]
GO

PRINT 'Creating sproc [usp_Update_Data]'
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_Add_Column] (@Team nvarchar(100), @Table_Name nvarchar(100), @Column_Name nvarchar(100), @Data_Type nvarchar(50), @PartitionID tinyint =1)
AS

/*
Sproc Creation Script
©Nathan Motyl
http://nmotyl.github.io/
*/

SET NOCOUNT ON;

DECLARE @TeamID int, @TableID bigint, @DataTypeID int, @Ordinal_Position int;

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

--get datatypeid
SELECT @DataTypeID = [DataTypeID] FROM [dbo].[Data_Types] WITH (NOLOCK) WHERE ([Data_Type] = @Data_Type);

	IF ISNULL(@TableID,0) = 0
	BEGIN
	 RAISERROR ('Invalid data type!',16,1);
	 GOTO _END
	END

--get ordinal position
SELECT @Ordinal_Position = MAX(Ordinal_Position) FROM [dbo].[Table_Columns] WITH (NOLOCK) WHERE (TableID = @TableID)
SELECT @Ordinal_Position = ISNULL(@Ordinal_Position,0) + 1;

--perform add
BEGIN TRY
INSERT INTO [dbo].[Table_Columns]
           ([PartitionID]
           ,[TableID]
           ,[Ordinal_Position]
           ,[DataTypeID]
           ,[Column_Name])
     VALUES
           (@PartitionID, @TableID, @Ordinal_Position, @DataTypeID, @Column_Name);

END TRY			
BEGIN CATCH
	RAISERROR ('Issue with column add!',16,1);
	GOTO _END
END CATCH

--error endpoint
_END:
--statement term

GO

PRINT 'Sproc created'
GO
