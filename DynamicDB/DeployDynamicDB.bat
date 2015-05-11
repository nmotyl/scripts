@echo off

:::::::::::::::::::::::::::::::::::
::Deployment script for Dynamic DB
::©Nathan Motyl
::http://nmotyl.github.io/
:::::::::::::::::::::::::::::::::::


::------------------------::
:: Establish system vars
::------------------------::
FOR /F "tokens=2-4 delims=/ " %%a IN ('DATE /T') DO SET SDATE=%%a%%b%%c

set /p sn=Enter SQL Server Name: 


::------------------------::
:: Init Log
::------------------------::
ECHO. > %0\..\DynamicDB_DeployLog_%SDATE%.log
ECHO ------------------------>> %0\..\DynamicDB_DeployLog_%SDATE%.log
DATE /T >>%0\..\DynamicDB_DeployLog_%SDATE%.log
TIME /T >>%0\..\DynamicDB_DeployLog_%SDATE%.log
ECHO Server Name: %sn%
ECHO ------------------------>> %0\..\DynamicDB_DeployLog_%SDATE%.log
ECHO. >>%0\..\DynamicDB_DeployLog_%SDATE%.log


::------------------------::
:: Create DB
::------------------------::
ECHO. >>%0\..\DynamicDB_DeployLog_%SDATE%.log
ECHO Creating database...
ECHO ------------------------ >>%0\..\DynamicDB_DeployLog_%SDATE%.log
ECHO. >>%0\..\DynamicDB_DeployLog_%SDATE%.log
FOR /F %%D IN ('dir %0\..\Create_DynamicDB.sql /b /s /on') DO SQLCMD -S %sn% -E -i %%D >> %0\..\DynamicDB_DeployLog_%SDATE%.log
ECHO. >> %0\..\DynamicDB_DeployLog_%SDATE%.log

::------------------------::
:: Create Tables
::------------------------::
ECHO. >>%0\..\DynamicDB_DeployLog_%SDATE%.log
ECHO Creating tables...
ECHO ------------------------ >>%0\..\DynamicDB_DeployLog_%SDATE%.log
ECHO. >>%0\..\DynamicDB_DeployLog_%SDATE%.log
FOR /F %%D IN ('dir %0\..\Tables\*.sql /b /s /on') DO SQLCMD -S %sn% -E -i %%D >> %0\..\DynamicDB_DeployLog_%SDATE%.log
ECHO. >> %0\..\DynamicDB_DeployLog_%SDATE%.log

::------------------------::
:: Create Indexes
::------------------------::
ECHO. >>%0\..\DynamicDB_DeployLog_%SDATE%.log
ECHO Creating indexes...
ECHO ------------------------ >>%0\..\DynamicDB_DeployLog_%SDATE%.log
ECHO. >>%0\..\DynamicDB_DeployLog_%SDATE%.log
FOR /F %%D IN ('dir %0\..\Indexes\*.sql /b /s /on') DO SQLCMD -S %sn% -E -i %%D >> %0\..\DynamicDB_DeployLog_%SDATE%.log
ECHO. >> %0\..\DynamicDB_DeployLog_%SDATE%.log

::------------------------::
:: Create Sprocs
::------------------------::
ECHO. >>%0\..\DynamicDB_DeployLog_%SDATE%.log
ECHO Creating sprocs...
ECHO ------------------------ >>%0\..\DynamicDB_DeployLog_%SDATE%.log
ECHO. >>%0\..\DynamicDB_DeployLog_%SDATE%.log
FOR /F %%D IN ('dir %0\..\Sprocs\*.sql /b /s /on') DO SQLCMD -S %sn% -E -i %%D >> %0\..\DynamicDB_DeployLog_%SDATE%.log



pause