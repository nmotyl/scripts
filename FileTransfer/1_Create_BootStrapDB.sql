USE master
GO

/*
Database Creation Script
�Nathan Motyl
http://nmotyl.github.io/
*/

PRINT 'Creating _BootStrap database'
GO

CREATE DATABASE [_BootStrap]
 ON  PRIMARY 
( NAME = N'_BootStrap', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQL2014\MSSQL\DATA\_BootStrap.mdf' , SIZE = 32768KB , MAXSIZE = UNLIMITED, FILEGROWTH = 32768KB )
 LOG ON 
( NAME = N'_BootStrap_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQL2014\MSSQL\DATA\_BootStrap_log.ldf' , SIZE = 32768KB , MAXSIZE = UNLIMITED, FILEGROWTH = 32768KB )
GO
ALTER DATABASE [_BootStrap] SET COMPATIBILITY_LEVEL = 120
GO
ALTER DATABASE [_BootStrap] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [_BootStrap] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [_BootStrap] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [_BootStrap] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [_BootStrap] SET ARITHABORT OFF 
GO
ALTER DATABASE [_BootStrap] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [_BootStrap] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [_BootStrap] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [_BootStrap] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [_BootStrap] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [_BootStrap] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [_BootStrap] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [_BootStrap] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [_BootStrap] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [_BootStrap] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [_BootStrap] SET  DISABLE_BROKER 
GO
ALTER DATABASE [_BootStrap] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [_BootStrap] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [_BootStrap] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [_BootStrap] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [_BootStrap] SET  READ_WRITE 
GO
ALTER DATABASE [_BootStrap] SET RECOVERY FULL 
GO
ALTER DATABASE [_BootStrap] SET  MULTI_USER 
GO
ALTER DATABASE [_BootStrap] SET PAGE_VERIFY CHECKSUM  
GO
USE [_BootStrap]
GO
IF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N'PRIMARY') ALTER DATABASE [_BootStrap] MODIFY FILEGROUP [PRIMARY] DEFAULT
GO
