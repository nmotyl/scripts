USE [DynamicDB]
GO

PRINT 'Creating sproc [usp_Create_Table]'
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_Create_Table] (@TableSpec AS xml)
AS

/*
Sproc Creation Script
©Nathan Motyl
http://nmotyl.github.io/
*/

SET NOCOUNT ON;

/*
DECLARE @TableSpec AS xml;
SELECT @TableSpec = '<TableSpec>      
 <name>Authors</name>
 <team>DBA</team>
       <Columns>        
			<column>
				<name>ID</name>
				<datatype>integer</datatype>
			</column>
			<column>
				<name>description</name>
				<datatype>character</datatype>
			</column>
			<column>
				<name>Published</name>
				<datatype>datetime</datatype>
			</column>
		</Columns>
</TableSpec>'
*/

DECLARE @TeamID int, @DataTypeID int, @TableID bigint, @Table_Name nvarchar(100), @Column_Name nvarchar(100), @Ordinal_Position int;
DECLARE @Validation int;

/********************************/
------get table name
/********************************/
SELECT @Table_Name = [TableSpec].value('name[1]', 'nvarchar(100)')
FROM @TableSpec.nodes('/TableSpec') TableSpec([TableSpec])
--PRINT @Table_Name

/********************************/
----get team ID and do validation on team name
/********************************/
BEGIN TRY
	SELECT 
	@TeamID = T.TeamID,
	@Validation = 1/ISNULL(T.TeamID,0)
	FROM @TableSpec.nodes('/TableSpec') TableSpec([TableSpec])
			LEFT JOIN dbo.Teams T WITH (NOLOCK) ON [TableSpec].value('team[1]', 'nvarchar(100)') = T.Team_Name
END TRY
BEGIN CATCH
	RAISERROR ('Invalid team!',16,1);
	GOTO _END
END CATCH

/********************************/
-----validate data types
/********************************/
BEGIN TRY
	SELECT 
	1/ISNULL(D.DataTypeID, 0) AS val
	INTO #__datatypevalidation
	FROM @TableSpec.nodes('/TableSpec/Columns/column') TableSpec([TableSpec])
		LEFT JOIN dbo.Data_Types D WITH (NOLOCK) ON [TableSpec].value('datatype[1]', 'nvarchar(50)') = D.Data_Type
END TRY
BEGIN CATCH
	RAISERROR ('Invalid data type!',16,1);
	GOTO _END
END CATCH

/********************************/
----create table record
/********************************/
BEGIN TRY
	INSERT INTO dbo.[Tables] (TeamID, Table_Name)
		VALUES (@TeamID, @Table_Name);
	--get table ID
	SELECT @TableID = @@IDENTITY;
END TRY
BEGIN CATCH
	RAISERROR ('Issue with table create!',16,1);
	GOTO _END
END CATCH

/********************************/
----create columns
/********************************/
SELECT @Ordinal_Position = 1;

DECLARE BuildSQL_Columns CURSOR FOR
SELECT 
	[TableSpec].value('name[1]', 'nvarchar(100)') AS Column_Name,
	D.DataTypeID
	FROM @TableSpec.nodes('/TableSpec/Columns/column') TableSpec([TableSpec])
		JOIN dbo.Data_Types D WITH (NOLOCK) ON [TableSpec].value('datatype[1]', 'nvarchar(50)') = D.Data_Type;
		
OPEN BuildSQL_Columns;

FETCH NEXT FROM BuildSQL_Columns INTO @Column_Name, @DataTypeID;

WHILE @@FETCH_STATUS = 0
BEGIN

	BEGIN TRY
		INSERT INTO [dbo].[Table_Columns]([TableID],[Ordinal_Position],[DataTypeID],[Column_Name])
		SELECT @TableID, @Ordinal_Position, @DataTypeID, @Column_Name;
	END TRY
	BEGIN CATCH
		DELETE FROM dbo.[Tables] WHERE TableID = @TableID;
		DELETE FROM [dbo].[Table_Columns] WHERE TableID = @TableID;
		CLOSE BuildSQL_Columns;
		DEALLOCATE BuildSQL_Columns;
		RAISERROR ('Issue with column create!',16,1);
		GOTO _END
	END CATCH

	 SELECT @Ordinal_Position = @Ordinal_Position + 1;
	 FETCH NEXT FROM BuildSQL_Columns INTO @Column_Name, @DataTypeID;

END

CLOSE BuildSQL_Columns;
DEALLOCATE BuildSQL_Columns;

PRINT @Table_Name + ' table created successfully.'
--error endpoint
_END:
--statement term

GO

PRINT 'Sproc created'
GO