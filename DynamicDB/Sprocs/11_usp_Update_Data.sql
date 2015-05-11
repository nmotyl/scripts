USE [DynamicDB]
GO

PRINT 'Creating sproc [usp_Update_Data]'
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Update_Data] (@Team nvarchar(100), @Table_Name nvarchar(100), @Column_Name nvarchar(100), @RowID bigint, @NewVal nvarchar(max))
AS

/*
Sproc Creation Script
©Nathan Motyl
http://nmotyl.github.io/
*/

SET NOCOUNT ON;

DECLARE @TeamID int, @TableID bigint, @ColumnID bigint, @DataTypeID int, @Data_Type nvarchar(50);

--get teamid
SELECT @TeamID = TeamID FROM Teams WITH (NOLOCK) WHERE Team_Name = @Team;

	IF ISNULL(@TeamID,0) = 0
	BEGIN
	 RAISERROR ('Invalid team!',16,1);
	 	EXECUTE dbo.usp_GetErrorInfo;
	 GOTO _END
	END
	
--get tableid
SELECT @TableID = TableID FROM [Tables] WITH (NOLOCK) WHERE (Table_Name = @Table_Name) AND (TeamID = @TeamID);

	IF ISNULL(@TableID,0) = 0
	BEGIN
	 RAISERROR ('Invalid table!',16,1);
	 	EXECUTE dbo.usp_GetErrorInfo;
	 GOTO _END
	END
	

--get columnid
SELECT @ColumnID = ColumnID, @DataTypeID = DataTypeID FROM Table_Columns WITH (NOLOCK) WHERE (Column_Name = @Column_Name) AND (TableID = @TableID);

	IF ISNULL(@ColumnID,0) = 0
	BEGIN
	 RAISERROR ('Invalid column!',16,1);
	 	EXECUTE dbo.usp_GetErrorInfo;
	 GOTO _END
	END

--get data type

SELECT @Data_Type = Data_Type FROM Data_Types WITH (NOLOCK) WHERE DataTypeID = @DataTypeID;

--perform update

BEGIN TRY
IF @Data_Type = 'DateTime'
UPDATE dbo.Table_Values
SET Value_DateTime = @NewVal
WHERE (ColumnID = @ColumnID) AND (RowID = @RowID);

  ELSE IF @Data_Type = 'Money'
	UPDATE dbo.Table_Values
	SET Value_Money = @NewVal
	WHERE (ColumnID = @ColumnID) AND (RowID = @RowID);

  ELSE IF @Data_Type = 'Integer'
	UPDATE dbo.Table_Values
	SET Value_Integer = @NewVal
	WHERE (ColumnID = @ColumnID) AND (RowID = @RowID);

    ELSE IF @Data_Type = 'Character'
	UPDATE dbo.Table_Values
	 SET Value_Character = @NewVal
	 WHERE (ColumnID = @ColumnID) AND (RowID = @RowID);
	 
	   ELSE IF @Data_Type = 'XML'
	   UPDATE dbo.Table_Values
	    SET Value_XML = @NewVal
	    WHERE (ColumnID = @ColumnID) AND (RowID = @RowID);

END TRY			
BEGIN CATCH
	RAISERROR ('Issue with update!',16,1);
	EXECUTE dbo.usp_GetErrorInfo;
	GOTO _END
END CATCH

--error endpoint
_END:
--statement term

GO

PRINT 'Sproc created'
GO