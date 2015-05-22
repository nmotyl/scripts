USE [_BootStrap]
GO

/*
Table Creation Script
©Nathan Motyl
http://nmotyl.github.io/
*/

PRINT 'Creating table SSISEncryptedConfigurations'
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[SSISEncryptedConfigurations](
	[ssisConfigurationId] [int] IDENTITY(1,1) NOT NULL,
	[ConfigurationFilter] [nvarchar](255) NOT NULL,
	[ConfiguredValue] [varbinary](512) NULL,
	[PackagePath] [nvarchar](255) NOT NULL,
	[ConfiguredValueType] [nvarchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ssisConfigurationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

PRINT 'Table created'
GO