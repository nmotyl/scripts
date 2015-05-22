USE [_BootStrap]
GO

/*
View Creation Script
©Nathan Motyl
http://nmotyl.github.io/
*/

PRINT 'Creating view SSIS_Configurations'
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*note - you may want to change the password below before deploying*/

CREATE VIEW [dbo].[SSIS_Configurations] 
WITH ENCRYPTION 
AS 
SELECT    [ssisConfigurationId] 
 , [ConfigurationFilter] 
 , CAST(DecryptByPassPhrase(N'P@ssw0rd', [ConfiguredValue]) AS NVARCHAR(255)) AS [ConfiguredValue] 
 , [PackagePath] 
 , [ConfiguredValueType] 
FROM  [dbo].[SSISEncryptedConfigurations] 
GO

CREATE TRIGGER [dbo].[SSISConfigurations_Insert] 
ON [dbo].[SSIS_Configurations] 
WITH ENCRYPTION 
INSTEAD OF INSERT 
AS 
BEGIN 
INSERT INTO [dbo].[SSISEncryptedConfigurations] ( 
     [ConfigurationFilter] 
      , [ConfiguredValue] 
      , [PackagePath] 
      , [ConfiguredValueType] 
    ) 
 SELECT 
       [ConfigurationFilter] 
       , EncryptByPassphrase( 'P@ssw0rd', [ConfiguredValue] ) 
       , [PackagePath] 
       , [ConfiguredValueType] 
 FROM inserted 
END 
GO

CREATE TRIGGER SSISConfigurations_Delete 
ON [dbo].[SSIS_Configurations] 
WITH ENCRYPTION 
INSTEAD OF DELETE 
AS 
BEGIN 
DELETE FROM [dbo].[SSISEncryptedConfigurations] 
 FROM [dbo].[SSISEncryptedConfigurations] A 
 WHERE EXISTS (SELECT 1 
       FROM deleted B 
       WHERE A.[ssisConfigurationId] = B.[ssisConfigurationId] 
      ) 
END 
GO

CREATE TRIGGER SSISConfigurations_Update 
ON [dbo].[SSIS_Configurations] 
WITH ENCRYPTION 
INSTEAD OF UPDATE 
AS 
BEGIN 
UPDATE [dbo].[SSISEncryptedConfigurations] 
   SET  [ConfigurationFilter] = B.[ConfigurationFilter] 
   , [ConfiguredValue] = EncryptByPassphrase('P@ssw0rd', CAST(B.[ConfiguredValue] as nvarchar(255)) ) 
   , [PackagePath] = B.[PackagePath] 
   , [ConfiguredValueType] = B.[ConfiguredValueType] 
 FROM [dbo].[SSISEncryptedConfigurations] A 
   INNER JOIN inserted B 
 ON  A.[ssisConfigurationId] = B.[ssisConfigurationId] 
END 
GO

PRINT 'View created'
GO
