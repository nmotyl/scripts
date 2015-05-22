@echo off

:::::::::::::::::::::::::::::::::::
::Deployment script for FileTransfer
::©Nathan Motyl
::http://nmotyl.github.io/
:::::::::::::::::::::::::::::::::::


::------------------------::
:: Establish system vars
::------------------------::
FOR /F "tokens=2-4 delims=/ " %%a IN ('DATE /T') DO SET SDATE=%%a%%b%%c

::------------------------::
:: Init Log
::------------------------::
ECHO. > %0\..\FileTransfer_DeployLog_%SDATE%.log

::------------------------::
::------------------------::
:: Warehouse
::------------------------::
::------------------------::
set /p sn=Enter SQL Server Name for Warehouse Database: 
set db=LogData
ECHO ------------------------>> %0\..\FileTransfer_DeployLog_%SDATE%.log
DATE /T >>%0\..\FileTransfer_DeployLog_%SDATE%.log
TIME /T >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO Server Name: %sn%
ECHO Database Name: %db%
ECHO ------------------------>> %0\..\FileTransfer_DeployLog_%SDATE%.log

ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log

ECHO Creating %db% database...
ECHO ------------------------ >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
FOR /F %%D IN ('dir %0\..\0_CreateWarehouseDB.sql /b /s /on') DO SQLCMD -S %sn% -E -i %%D >> %0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO. >> %0\..\FileTransfer_DeployLog_%SDATE%.log

::------------------------::
:: Create Tables
::------------------------::
ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO Creating tables...
ECHO ------------------------ >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
FOR /F %%D IN ('dir %0\..\Tables\*%db%*.sql /b /s /on') DO SQLCMD -S %sn% -E -i %%D >> %0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO. >> %0\..\FileTransfer_DeployLog_%SDATE%.log

::------------------------::
:: Create Indexes
::------------------------::
ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO Creating indexes...
ECHO ------------------------ >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
FOR /F %%D IN ('dir %0\..\Indexes\*%db%*.sql /b /s /on') DO SQLCMD -S %sn% -E -i %%D >> %0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO. >> %0\..\FileTransfer_DeployLog_%SDATE%.log

::------------------------::
:: Create Views
::------------------------::
ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO Creating sprocs...
ECHO ------------------------ >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
FOR /F %%D IN ('dir %0\..\Views\*%db%*.sql /b /s /on') DO SQLCMD -S %sn% -E -i %%D >> %0\..\FileTransfer_DeployLog_%SDATE%.log

::------------------------::
:: Create Functions
::------------------------::
ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO Creating sprocs...
ECHO ------------------------ >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
FOR /F %%D IN ('dir %0\..\Functions\*%db%*.sql /b /s /on') DO SQLCMD -S %sn% -E -i %%D >> %0\..\FileTransfer_DeployLog_%SDATE%.log

::------------------------::
:: Create Sprocs
::------------------------::
ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO Creating sprocs...
ECHO ------------------------ >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
FOR /F %%D IN ('dir %0\..\Sprocs\*%db%*.sql /b /s /on') DO SQLCMD -S %sn% -E -i %%D >> %0\..\FileTransfer_DeployLog_%SDATE%.log

::------------------------::
::------------------------::
:: BootStrap
::------------------------::
::------------------------::
set /p sn=Enter SQL Server Name for BootStrap Database: 
set db=BootStrap
ECHO ------------------------>> %0\..\FileTransfer_DeployLog_%SDATE%.log
DATE /T >>%0\..\FileTransfer_DeployLog_%SDATE%.log
TIME /T >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO Server Name: %sn%
ECHO Database Name: %db%
ECHO ------------------------>> %0\..\FileTransfer_DeployLog_%SDATE%.log

ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log

ECHO Creating %db% database...
ECHO ------------------------ >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
FOR /F %%D IN ('dir %0\..\1_Create_BootStrapDB.sql /b /s /on') DO SQLCMD -S %sn% -E -i %%D >> %0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO. >> %0\..\FileTransfer_DeployLog_%SDATE%.log

::------------------------::
:: Create Tables
::------------------------::
ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO Creating tables...
ECHO ------------------------ >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
FOR /F %%D IN ('dir %0\..\Tables\*%db%*.sql /b /s /on') DO SQLCMD -S %sn% -E -i %%D >> %0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO. >> %0\..\FileTransfer_DeployLog_%SDATE%.log

::------------------------::
:: Create Indexes
::------------------------::
ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO Creating indexes...
ECHO ------------------------ >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
FOR /F %%D IN ('dir %0\..\Indexes\*%db%*.sql /b /s /on') DO SQLCMD -S %sn% -E -i %%D >> %0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO. >> %0\..\FileTransfer_DeployLog_%SDATE%.log

::------------------------::
:: Create Views
::------------------------::
ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO Creating sprocs...
ECHO ------------------------ >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
FOR /F %%D IN ('dir %0\..\Views\*%db%*.sql /b /s /on') DO SQLCMD -S %sn% -E -i %%D >> %0\..\FileTransfer_DeployLog_%SDATE%.log

::------------------------::
:: Create Functions
::------------------------::
ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO Creating sprocs...
ECHO ------------------------ >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
FOR /F %%D IN ('dir %0\..\Functions\*%db%*.sql /b /s /on') DO SQLCMD -S %sn% -E -i %%D >> %0\..\FileTransfer_DeployLog_%SDATE%.log

::------------------------::
:: Create Sprocs
::------------------------::
ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO Creating sprocs...
ECHO ------------------------ >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
FOR /F %%D IN ('dir %0\..\Sprocs\*%db%*.sql /b /s /on') DO SQLCMD -S %sn% -E -i %%D >> %0\..\FileTransfer_DeployLog_%SDATE%.log

::------------------------::
::------------------------::
:: Release_Admin
::------------------------::
::------------------------::
set /p sn=Enter SQL Server Name for Release_Admin Database: 
set db=Release_Admin
ECHO ------------------------>> %0\..\FileTransfer_DeployLog_%SDATE%.log
DATE /T >>%0\..\FileTransfer_DeployLog_%SDATE%.log
TIME /T >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO Server Name: %sn%
ECHO Database Name: %db%
ECHO ------------------------>> %0\..\FileTransfer_DeployLog_%SDATE%.log

ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log

ECHO Creating %db% database...
ECHO ------------------------ >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
FOR /F %%D IN ('dir %0\..\2_Create_Release_Admin.sql /b /s /on') DO SQLCMD -S %sn% -E -i %%D >> %0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO. >> %0\..\FileTransfer_DeployLog_%SDATE%.log

::------------------------::
:: Create Tables
::------------------------::
ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO Creating tables...
ECHO ------------------------ >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
FOR /F %%D IN ('dir %0\..\Tables\*%db%*.sql /b /s /on') DO SQLCMD -S %sn% -E -i %%D >> %0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO. >> %0\..\FileTransfer_DeployLog_%SDATE%.log

::------------------------::
:: Create Indexes
::------------------------::
ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO Creating indexes...
ECHO ------------------------ >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
FOR /F %%D IN ('dir %0\..\Indexes\*%db%*.sql /b /s /on') DO SQLCMD -S %sn% -E -i %%D >> %0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO. >> %0\..\FileTransfer_DeployLog_%SDATE%.log

::------------------------::
:: Create Views
::------------------------::
ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO Creating sprocs...
ECHO ------------------------ >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
FOR /F %%D IN ('dir %0\..\Views\*%db%*.sql /b /s /on') DO SQLCMD -S %sn% -E -i %%D >> %0\..\FileTransfer_DeployLog_%SDATE%.log

::------------------------::
:: Create Functions
::------------------------::
ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO Creating sprocs...
ECHO ------------------------ >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
FOR /F %%D IN ('dir %0\..\Functions\*%db%*.sql /b /s /on') DO SQLCMD -S %sn% -E -i %%D >> %0\..\FileTransfer_DeployLog_%SDATE%.log

::------------------------::
:: Create Sprocs
::------------------------::
ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO Creating sprocs...
ECHO ------------------------ >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
FOR /F %%D IN ('dir %0\..\Sprocs\*%db%*.sql /b /s /on') DO SQLCMD -S %sn% -E -i %%D >> %0\..\FileTransfer_DeployLog_%SDATE%.log

::------------------------::
::------------------------::
:: FileTransferChild
::------------------------::
::------------------------::
set /p sn=Enter SQL Server Name for FileTransferChild Database: 
set db=FileTransferChild
ECHO ------------------------>> %0\..\FileTransfer_DeployLog_%SDATE%.log
DATE /T >>%0\..\FileTransfer_DeployLog_%SDATE%.log
TIME /T >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO Server Name: %sn%
ECHO Database Name: %db%
ECHO ------------------------>> %0\..\FileTransfer_DeployLog_%SDATE%.log

ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log

ECHO Creating %db% database...
ECHO ------------------------ >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
FOR /F %%D IN ('dir %0\..\4_Create_FileTransferChild.sql /b /s /on') DO SQLCMD -S %sn% -E -i %%D >> %0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO. >> %0\..\FileTransfer_DeployLog_%SDATE%.log

::------------------------::
:: Create Tables
::------------------------::
ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO Creating tables...
ECHO ------------------------ >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
FOR /F %%D IN ('dir %0\..\Tables\*%db%*.sql /b /s /on') DO SQLCMD -S %sn% -E -i %%D >> %0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO. >> %0\..\FileTransfer_DeployLog_%SDATE%.log

::------------------------::
:: Create Indexes
::------------------------::
ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO Creating indexes...
ECHO ------------------------ >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
FOR /F %%D IN ('dir %0\..\Indexes\*%db%*.sql /b /s /on') DO SQLCMD -S %sn% -E -i %%D >> %0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO. >> %0\..\FileTransfer_DeployLog_%SDATE%.log

::------------------------::
:: Create Views
::------------------------::
ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO Creating sprocs...
ECHO ------------------------ >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
FOR /F %%D IN ('dir %0\..\Views\*%db%*.sql /b /s /on') DO SQLCMD -S %sn% -E -i %%D >> %0\..\FileTransfer_DeployLog_%SDATE%.log

::------------------------::
:: Create Functions
::------------------------::
ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO Creating sprocs...
ECHO ------------------------ >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
FOR /F %%D IN ('dir %0\..\Functions\*%db%*.sql /b /s /on') DO SQLCMD -S %sn% -E -i %%D >> %0\..\FileTransfer_DeployLog_%SDATE%.log

::------------------------::
:: Create Sprocs
::------------------------::
ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO Creating sprocs...
ECHO ------------------------ >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
FOR /F %%D IN ('dir %0\..\Sprocs\*%db%*.sql /b /s /on') DO SQLCMD -S %sn% -E -i %%D >> %0\..\FileTransfer_DeployLog_%SDATE%.log

::------------------------::
::------------------------::
:: SSIS_LoggingDB
::------------------------::
::------------------------::
set /p sn=Enter SQL Server Name for SSIS_LoggingDB Database: 
set db=SSIS_LoggingDB
ECHO ------------------------>> %0\..\FileTransfer_DeployLog_%SDATE%.log
DATE /T >>%0\..\FileTransfer_DeployLog_%SDATE%.log
TIME /T >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO Server Name: %sn%
ECHO Database Name: %db%
ECHO ------------------------>> %0\..\FileTransfer_DeployLog_%SDATE%.log

ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log

ECHO Creating %db% database...
ECHO ------------------------ >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
FOR /F %%D IN ('dir %0\..\3_Create_SSIS_LoggingDB.sql /b /s /on') DO SQLCMD -S %sn% -E -i %%D >> %0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO. >> %0\..\FileTransfer_DeployLog_%SDATE%.log

ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO. >>%0\..\FileTransfer_DeployLog_%SDATE%.log
ECHO Work Completed................... >>%0\..\FileTransfer_DeployLog_%SDATE%.log

pause