USE master
GO

/*
Database Creation Script
�Nathan Motyl
http://nmotyl.github.io/
*/

PRINT 'Creating _FileTransferChild database'
GO

CREATE DATABASE [_FileTransferChild]
 ON  PRIMARY 
( NAME = N'_FileTransferChild', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQL2014\MSSQL\DATA\_FileTransferChild.mdf' , SIZE = 2048MB , MAXSIZE = UNLIMITED, FILEGROWTH = 512MB )
 LOG ON 
( NAME = N'_FileTransferChild_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQL2014\MSSQL\DATA\_FileTransferChild_log.ldf' , SIZE = 512MB , MAXSIZE = UNLIMITED, FILEGROWTH = 128MB )
GO
ALTER DATABASE [_FileTransferChild] SET COMPATIBILITY_LEVEL = 120
GO
ALTER DATABASE [_FileTransferChild] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [_FileTransferChild] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [_FileTransferChild] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [_FileTransferChild] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [_FileTransferChild] SET ARITHABORT OFF 
GO
ALTER DATABASE [_FileTransferChild] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [_FileTransferChild] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [_FileTransferChild] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [_FileTransferChild] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [_FileTransferChild] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [_FileTransferChild] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [_FileTransferChild] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [_FileTransferChild] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [_FileTransferChild] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [_FileTransferChild] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [_FileTransferChild] SET  DISABLE_BROKER 
GO
ALTER DATABASE [_FileTransferChild] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [_FileTransferChild] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [_FileTransferChild] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [_FileTransferChild] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [_FileTransferChild] SET  READ_WRITE 
GO
ALTER DATABASE [_FileTransferChild] SET RECOVERY FULL 
GO
ALTER DATABASE [_FileTransferChild] SET  MULTI_USER 
GO
ALTER DATABASE [_FileTransferChild] SET PAGE_VERIFY CHECKSUM  
GO
USE [_FileTransferChild]
GO
IF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N'PRIMARY') ALTER DATABASE [_FileTransferChild] MODIFY FILEGROUP [PRIMARY] DEFAULT
GO
