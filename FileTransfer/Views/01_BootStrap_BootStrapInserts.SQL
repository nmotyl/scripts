USE [_BootStrap]
GO

DECLARE @sChildNode nvarchar(40);
SELECT @sChildNode = '.\SQL2014';

INSERT INTO [dbo].[SSIS_Configurations]
           ([ConfigurationFilter]
           ,[ConfiguredValue]
           ,[PackagePath]
           ,[ConfiguredValueType])
SELECT 'connReleaseDB','Data Source=.\SQL2014;Initial Catalog=_Release_Admin;Provider=SQLNCLI11.1;Integrated Security=SSPI;','\Package.Connections[ReleaseDB].Properties[ConnectionString]','String' UNION ALL
SELECT 'connWarehouse','Data Source=.\SQL2014;Initial Catalog=LogData;Provider=SQLNCLI11.1;Integrated Security=SSPI;','\Package.Connections[Warehouse].Properties[ConnectionString]','String' UNION ALL
SELECT 'connSSISLoggingDB','Data Source=.\SQL2014;Initial Catalog=SSIS_LoggingDB;Provider=SQLNCLI11.1;Integrated Security=SSPI;','\Package.Connections[SSISLoggingDB].Properties[ConnectionString]','String' UNION ALL
SELECT 'conn_var_sMasterBCPAuth','-T -S .\SQL2014 -d LogData','\Package.Variables[User::sMasterBCPAuth].Properties[Value]','String' UNION ALL
SELECT 'connFileTransferChild','Data Source=' + @sChildNode + ';Initial Catalog=_FileTransferChild;Provider=SQLNCLI11.1;Integrated Security=SSPI;','\Package.Connections[FileTransferChild].Properties[ConnectionString]','String'

GO
