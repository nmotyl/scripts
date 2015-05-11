USE [DynamicDB]
GO


PRINT 'Creating sproc [usp_Select_Data]'
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_Select_Data] (@Team nvarchar(100), @Table_Name nvarchar(100), @Top int = 0, @SQL_Where nvarchar(200) = '')
AS

/*
Sproc Creation Script
©Nathan Motyl
http://nmotyl.github.io/
*/

SET NOCOUNT ON;

--SELECT @Team = 'DBA', @Table_Name = 'user'

/**Create Dynamic Table**/

DECLARE @SQL_TableDDL nvarchar(4000), @SQL_Select nvarchar(4000);
DECLARE @RowTerm char(1), @CastData varchar(25);
DECLARE @SessionID varchar(255), @LoopCount int;
DECLARE @ColumnID bigint, @Column_Name nvarchar(100), @Data_Type nvarchar(50);

SELECT @Top=ISNULL(@Top,0);
SELECT @SQL_Where=ISNULL(@SQL_Where,''); 

SELECT @SessionID = NEWID(), @LoopCount =1;

--set where clause
SELECT @SQL_Where =
	CASE @SQL_Where
		WHEN '' THEN ' ) V'
		ELSE ' ) V WHERE ' + @SQL_Where
	END;

SELECT @SQL_TableDDL = 'CREATE TABLE [##__' + @SessionID + '__' + @Table_Name + ']	([RowID] [bigint] NOT NULL, ';

SELECT @RowTerm = ','

DECLARE BuildSQL_Table CURSOR FOR
SELECT C.Column_Name, D.Data_Type
FROM Table_Columns C WITH (NOLOCK) 
	JOIN [Tables] T WITH (NOLOCK) ON C.TableID = T.TableID 
	JOIN Teams TM WITH (NOLOCK) ON T.TeamID = TM.TeamID 
	JOIN Data_Types D WITH (NOLOCK) ON C.DataTypeID = D.DataTypeID
 WHERE (TM.Team_Name = @Team) AND (T.Table_Name = @Table_Name)
 AND (TM.[Status] = 1) AND (T.[Status] = 1) AND (C.[Status] = 1)
 ORDER BY C.Ordinal_Position;

OPEN BuildSQL_Table;

FETCH NEXT FROM BuildSQL_Table INTO @Column_Name, @Data_Type;

WHILE @@FETCH_STATUS = 0
BEGIN

	SELECT @CastData =
	CASE @Data_Type
		WHEN 'Character' THEN 'nvarchar(MAX)'
		WHEN 'Money' THEN 'decimal(19,4)'
		WHEN 'Integer' THEN 'int'
		WHEN 'DateTime' THEN 'DateTime'
		WHEN 'XML' THEN 'xml'
	END;

	SELECT @SQL_TableDDL = @SQL_TableDDL + '[' + @Column_Name + '] ' + @CastData + ' NULL' + @RowTerm 

 FETCH NEXT FROM BuildSQL_Table INTO @Column_Name, @Data_Type;

END

/******Create session table*************/
SELECT @SQL_TableDDL = LEFT(@SQL_TableDDL, (LEN(@SQL_TableDDL) - 1)) + ')';

--PRINT @SQL_TableDDL;
EXEC (@SQL_TableDDL);

CLOSE BuildSQL_Table;
DEALLOCATE BuildSQL_Table;

/**Create Dynamic Select**/

--row ID loop
DECLARE @RowID bigint;

DECLARE RowID_Loop CURSOR FOR
SELECT DISTINCT RowID 
FROM Table_Values WITH (NOLOCK)
WHERE ColumnID IN 
(
SELECT C.ColumnID
FROM Table_Columns C WITH (NOLOCK) 
	JOIN [Tables] T WITH (NOLOCK) ON C.TableID = T.TableID 
	JOIN Teams TM WITH (NOLOCK) ON T.TeamID = TM.TeamID 
 WHERE (TM.Team_Name = @Team) AND (T.Table_Name = @Table_Name)
 AND (TM.[Status] = 1) AND (T.[Status] = 1) AND (C.[Status] = 1)
 ) AND ([Status] = 1);
  
OPEN RowID_Loop;

FETCH NEXT FROM RowID_Loop INTO @RowID;

WHILE @@FETCH_STATUS = 0
BEGIN

	SELECT @SQL_Select = 'INSERT INTO [##__' + @SessionID + '__' + @Table_Name + '] SELECT * FROM ( SELECT ' + LTRIM(STR(@RowID)) + ' AS RowID' + @RowTerm + ' '; 

	DECLARE BuildSQL_Select CURSOR FOR
	SELECT C.ColumnID, C.Column_Name, D.Data_Type
	FROM Table_Columns C WITH (NOLOCK) 
		JOIN [Tables] T WITH (NOLOCK) ON C.TableID = T.TableID 
		JOIN Teams TM WITH (NOLOCK) ON T.TeamID = TM.TeamID 
		JOIN Data_Types D WITH (NOLOCK) ON C.DataTypeID = D.DataTypeID
	 WHERE (TM.Team_Name = @Team) AND (T.Table_Name = @Table_Name)
	 AND (TM.[Status] = 1) AND (T.[Status] = 1) AND (C.[Status] = 1)
	 ORDER BY C.Ordinal_Position;

	OPEN BuildSQL_Select;

	FETCH NEXT FROM BuildSQL_Select INTO @ColumnID, @Column_Name, @Data_Type;

	WHILE @@FETCH_STATUS = 0
	BEGIN

		SELECT @CastData =
		CASE @Data_Type
			WHEN 'Character' THEN 'nvarchar(MAX)'
			WHEN 'Money' THEN 'decimal(19,4)'
			WHEN 'Integer' THEN 'int'
			WHEN 'DateTime' THEN 'DateTime'
			WHEN 'XML' THEN 'xml'
		END;

		SELECT @SQL_Select = @SQL_Select + 
		'(SELECT CAST([Value_' + @Data_Type + '] AS ' + @CastData + ') FROM dbo.Table_Values WITH (NOLOCK) WHERE (ColumnID = ' + LTRIM(STR(@ColumnID)) + ') AND (RowID = ' + LTRIM(STR(@RowID)) + ')) AS ' + '[' + @Column_Name + ']' + @RowTerm 

			FETCH NEXT FROM BuildSQL_Select INTO @ColumnID, @Column_Name, @Data_Type;
		END

		SELECT @SQL_Select = LEFT(@SQL_Select, (LEN(@SQL_Select) - 1)) + @SQL_Where;

		--PRINT @SQL_Select;
		EXEC (@SQL_Select);

	CLOSE BuildSQL_Select;
	DEALLOCATE BuildSQL_Select;

/*****************TOP n break*******************/
	IF (@Top <> 0) AND (@LoopCount = @Top)
		BREAK
/*****************TOP n break*******************/

SELECT @LoopCount = @LoopCount + 1;
FETCH NEXT FROM RowID_Loop INTO @RowID;
END
CLOSE RowID_Loop;
DEALLOCATE RowID_Loop;

SELECT @SQL_Select = 'SELECT * FROM [##__' + @SessionID + '__' + @Table_Name + '];'
EXEC (@SQL_Select);

SELECT @SQL_Select = 'DROP TABLE [##__' + @SessionID + '__' + @Table_Name + '];'
EXEC (@SQL_Select);


GO

PRINT 'Sproc created'
GO