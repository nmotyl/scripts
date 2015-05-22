USE [LogData]
GO

/*
Function Creation Script
©Nathan Motyl
http://nmotyl.github.io/
*/

PRINT 'Creating function fn_datetag'
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE FUNCTION [dbo].[fn_datetag] (@curtime datetime = NULL)  
RETURNS varchar(15) AS  

/*
Function to return a datetimestamp as a string
©Nathan Motyl
http://nmotyl.github.io/
*/

BEGIN 

	SELECT @curtime = ISNULL(@curtime,GETDATE());

	DECLARE @strdate varchar(15);

	SET @strdate = RIGHT(STR(DATEPART(month,@curtime)),2) + RIGHT(STR(DATEPART(day,@curtime)),2)  + RIGHT(STR(DATEPART(year,@curtime)),2) + '-' + RIGHT(STR(DATEPART(hour,@curtime)),2) + RIGHT(STR(DATEPART(minute,@curtime)),2)  + RIGHT(STR(DATEPART(second,@curtime)),2);

	SET @strdate = REPLACE(@strdate,' ','0');

RETURN (@strdate) 

END





GO


