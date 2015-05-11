USE [DynamicDB]
GO

PRINT 'Creating sproc [usp_Insert_Data]'
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_Insert_Data] (@InsertSpec xml)
AS

/*
Sproc Creation Script
©Nathan Motyl
http://nmotyl.github.io/
*/

SET NOCOUNT ON;

/*
DECLARE @InsertSpec AS xml;
SELECT @InsertSpec = '<InsertSpec>      
 <name>Authors</name>
 <team>DBA</team>
       <Columns>        
			<column>
				<name>ID</name>
				<value>1</value>
			</column>
			<column>
				<name>description</name>
				<value>Hello world</value>
			</column>
			<column>
				<name>Published</name>
				<value>1/1/12</value>
			</column>
		</Columns>
</InsertSpec>'
*/

DECLARE @TeamID int, @ColumnID bigint, @TableID bigint, @Table_Name nvarchar(100), @RowID bigint;
DECLARE @Validation int;
DECLARE @PartitionID tinyint, @Txn_Guid uniqueidentifier;
DECLARE @Value_DateTime datetime, @Value_Integer int, @Value_Money money, @Value_Character nvarchar(max), @Value_XML xml;

SELECT @PartitionID = 1;
SELECT @Txn_Guid = NEWID();

/********************************/
------get team info
/********************************/
BEGIN TRY
	SELECT 
	@TeamID = tm.TeamID,
	@Validation = 1/ISNULL(tm.TeamID,0)
	FROM @InsertSpec.nodes('/InsertSpec') InsertSpec([InsertSpec])
		LEFT JOIN dbo.Teams tm WITH (NOLOCK) ON [InsertSpec].value('team[1]', 'nvarchar(100)') = tm.Team_Name
END TRY
BEGIN CATCH
	RAISERROR ('Invalid team!',16,1);
		EXECUTE dbo.usp_GetErrorInfo;
	GOTO _END
END CATCH

SELECT @Validation = NULL;

/********************************/
------get table info
/********************************/
BEGIN TRY
	SELECT	@Table_Name = [i].value('name[1]', 'nvarchar(100)'),
			@Validation = ISNULL(t.TableID,0)
	FROM @InsertSpec.nodes('/InsertSpec') InsertSpec([i])
		LEFT JOIN dbo.[Tables] t ON [i].value('name[1]', 'nvarchar(100)') = t.Table_Name
	WHERE t.TeamID = @TeamID;

	--error check
	SELECT @Validation = 1/ISNULL(@Validation,0);

	SELECT @TableID = t.TableID FROM dbo.[Tables] t WITH (NOLOCK) 
	WHERE (t.Table_Name = @Table_Name) AND (T.TeamID = @TeamID);

END TRY
BEGIN CATCH
	RAISERROR ('Invalid table!',16,1);
		EXECUTE dbo.usp_GetErrorInfo;
	GOTO _END
END CATCH


/********************************/
------validate columns
/********************************/
--seed validation
SELECT @Validation = 1;

BEGIN TRY
SELECT 
	TOP 1 @Validation = 0
	FROM @InsertSpec.nodes('/InsertSpec/Columns/column') InsertSpec([i])
			RIGHT JOIN (SELECT * FROM dbo.Table_Columns WITH (NOLOCK) WHERE [Status] = 1) tc   
				ON i.value('name[1]', 'nvarchar(100)') = tc.Column_Name
			LEFT JOIN dbo.[Tables] T WITH (NOLOCK)
				ON tc.TableID = t.TableID
	WHERE (T.TeamID = @TeamID) AND (T.TableID = @TableID) AND (i.value('name[1]', 'nvarchar(100)') IS NULL)

SELECT @Validation = 1/ISNULL(@Validation,0);

END TRY
BEGIN CATCH
	RAISERROR ('Invalid columns!',16,1);
		EXECUTE dbo.usp_GetErrorInfo;
	GOTO _END
END CATCH

/********************************/
------insert loop
/********************************/

DECLARE Table_Inserts CURSOR FOR
SELECT 
	tc.ColumnID,
	Value_DateTime =
		CASE d.Data_Type
			WHEN 'DateTime' THEN [i].value('value[1]', 'datetime')
		 ELSE NULL
		END,
	Value_Integer =
		CASE d.Data_Type
			WHEN 'Integer' THEN [i].value('value[1]', 'int')
		 ELSE NULL
		END,
	Value_Money =
		CASE d.Data_Type
			WHEN 'Money' THEN [i].value('value[1]', 'money')
		 ELSE NULL
		END,
	Value_Character =
		CASE d.Data_Type
			WHEN 'Character' THEN [i].value('value[1]', 'nvarchar(max)')
		 ELSE NULL
		END,
	Value_XML =
		CASE d.Data_Type
			WHEN 'XML' THEN [i].value('value[1]', 'nvarchar(max)')
		 ELSE NULL
		END
	FROM @InsertSpec.nodes('/InsertSpec/Columns/column') InsertSpec([i])
		JOIN dbo.Table_Columns tc WITH (NOLOCK) 
			ON i.value('name[1]', 'nvarchar(100)') = tc.Column_Name
		JOIN dbo.Data_Types d WITH (NOLOCK)
			ON tc.DataTypeID = d.DataTypeID
		JOIN dbo.[Tables] T WITH (NOLOCK)
			ON tc.TableID = t.TableID
	WHERE (t.TeamID = @TeamID) AND (T.TableID = @TableID);

OPEN Table_Inserts;

FETCH NEXT FROM Table_Inserts INTO @ColumnID, @Value_DateTime, @Value_Integer, @Value_Money, @Value_Character, @Value_XML;

/********************************/
------get ROWID
/********************************/
SELECT @RowID = MAX(ISNULL(RowID,0)) FROM dbo.Table_Values tv WITH (NOLOCK) 
WHERE ColumnID IN( 
	SELECT
	tc.ColumnID
	FROM @InsertSpec.nodes('/InsertSpec/Columns/column') InsertSpec([i])
		JOIN dbo.Table_Columns tc WITH (NOLOCK) 
			ON i.value('name[1]', 'nvarchar(100)') = tc.Column_Name
		JOIN dbo.Data_Types d WITH (NOLOCK)
			ON tc.DataTypeID = d.DataTypeID
		JOIN dbo.[Tables] T WITH (NOLOCK)
			ON tc.TableID = t.TableID
	WHERE (t.TeamID = @TeamID) AND (T.TableID = @TableID));

--seed first row and increment
SELECT @RowID = ISNULL(@RowID,0) + 1;

WHILE @@FETCH_STATUS = 0
BEGIN

	BEGIN TRY
	 EXECUTE [dbo].[usp_Insert_Data_by_Item] @ColumnID, @RowID, @PartitionID, @Value_DateTime, @Value_Integer, @Value_Money, @Value_Character, @Value_XML, @Txn_Guid;
	END TRY
	BEGIN CATCH
		RAISERROR ('Problem with insert!',16,1);
		DELETE FROM Table_Values WHERE Txn_Guid = @Txn_Guid;
		CLOSE Table_Inserts;
		DEALLOCATE Table_Inserts;
			EXECUTE dbo.usp_GetErrorInfo;
		GOTO _END
	END CATCH

	FETCH NEXT FROM Table_Inserts INTO @ColumnID, @Value_DateTime, @Value_Integer, @Value_Money, @Value_Character, @Value_XML;

END

CLOSE Table_Inserts;
DEALLOCATE Table_Inserts;

--error endpoint
_END:
--statement term
RETURN (@RowID);

GO

PRINT 'Sproc created'
GO