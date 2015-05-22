USE master
GO

/*
Database Creation Script
�Nathan Motyl
http://nmotyl.github.io/
*/

PRINT 'Creating _Release_Admin database'
GO

CREATE DATABASE [_Release_Admin]
 ON  PRIMARY 
( NAME = N'_Release_Admin', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQL2014\MSSQL\DATA\_Release_Admin.mdf' , SIZE = 32768KB , MAXSIZE = UNLIMITED, FILEGROWTH = 32768KB )
 LOG ON 
( NAME = N'_Release_Admin_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQL2014\MSSQL\DATA\_Release_Admin_log.ldf' , SIZE = 32768KB , MAXSIZE = UNLIMITED, FILEGROWTH = 32768KB )
GO
ALTER DATABASE [_Release_Admin] SET COMPATIBILITY_LEVEL = 120
GO
ALTER DATABASE [_Release_Admin] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [_Release_Admin] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [_Release_Admin] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [_Release_Admin] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [_Release_Admin] SET ARITHABORT OFF 
GO
ALTER DATABASE [_Release_Admin] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [_Release_Admin] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [_Release_Admin] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [_Release_Admin] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [_Release_Admin] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [_Release_Admin] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [_Release_Admin] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [_Release_Admin] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [_Release_Admin] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [_Release_Admin] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [_Release_Admin] SET  DISABLE_BROKER 
GO
ALTER DATABASE [_Release_Admin] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [_Release_Admin] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [_Release_Admin] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [_Release_Admin] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [_Release_Admin] SET  READ_WRITE 
GO
ALTER DATABASE [_Release_Admin] SET RECOVERY FULL 
GO
ALTER DATABASE [_Release_Admin] SET  MULTI_USER 
GO
ALTER DATABASE [_Release_Admin] SET PAGE_VERIFY CHECKSUM  
GO
USE [_Release_Admin]
GO
IF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N'PRIMARY') ALTER DATABASE [_Release_Admin] MODIFY FILEGROUP [PRIMARY] DEFAULT
GO
