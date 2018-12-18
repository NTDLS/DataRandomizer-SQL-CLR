sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO
sp_configure 'clr enabled', 1;
GO
RECONFIGURE;
GO

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.databases WHERE name = 'RandomData')
BEGIN--IF
	CREATE DATABASE RandomData
END--IF
GO

USE [RandomData]
GO

EXEC sp_changedbowner 'sa'
GO

ALTER DATABASE [RandomData] SET trustworthy ON
GO

CREATE ASSEMBLY DataRandomizerCLR from 'C:\CLR\DataRandomizer\DataRandomizer.dll' WITH PERMISSION_SET = UNSAFE 
GO

CREATE FUNCTION GetRandomDomainSuffix() RETURNS nVarChar(256)
AS EXTERNAL NAME DataRandomizerCLR.UserDefinedFunctions.GetRandomDomainSuffix;
GO
CREATE FUNCTION GetRandomEmailAddress() RETURNS nVarChar(256)
AS EXTERNAL NAME DataRandomizerCLR.UserDefinedFunctions.GetRandomEmailAddress;
GO
CREATE FUNCTION GetRandomWord() RETURNS nVarChar(256)
AS EXTERNAL NAME DataRandomizerCLR.UserDefinedFunctions.GetRandomWord;
GO
CREATE FUNCTION GetRandomNumber(@min int, @max int) RETURNS Int
AS EXTERNAL NAME DataRandomizerCLR.UserDefinedFunctions.GetRandomNumber;
GO
CREATE FUNCTION GetRandomNumberOfWords(@min int, @max int) RETURNS nVarChar(256)
AS EXTERNAL NAME DataRandomizerCLR.UserDefinedFunctions.GetRandomNumberOfWords;
GO
CREATE FUNCTION GetRandomNumberString(@length int) RETURNS nVarChar(256)
AS EXTERNAL NAME DataRandomizerCLR.UserDefinedFunctions.GetRandomNumberString;
GO
CREATE FUNCTION GetRandomNumberStringLengthBetween(@minLength int, @maxLength int) RETURNS nVarChar(256)
AS EXTERNAL NAME DataRandomizerCLR.UserDefinedFunctions.GetRandomNumberStringLengthBetween;
GO
CREATE FUNCTION GetRandomWords(@count int) RETURNS nVarChar(256)
AS EXTERNAL NAME DataRandomizerCLR.UserDefinedFunctions.GetRandomWords;
GO
CREATE PROCEDURE InitializeRandom(@randomDataPath nVarChar(256))
AS EXTERNAL NAME DataRandomizerCLR.UserDefinedFunctions.InitializeRandom;
GO
CREATE FUNCTION GetRandomCompanyName() RETURNS nVarChar(256)
AS EXTERNAL NAME DataRandomizerCLR.UserDefinedFunctions.GetRandomCompanyName;
GO
CREATE FUNCTION GetRandomStreetSuffix() RETURNS nVarChar(256)
AS EXTERNAL NAME DataRandomizerCLR.UserDefinedFunctions.GetRandomStreetSuffix;
GO
CREATE FUNCTION GetRandomStreetName() RETURNS nVarChar(256)
AS EXTERNAL NAME DataRandomizerCLR.UserDefinedFunctions.GetRandomStreetName;
GO
CREATE FUNCTION FlipCoin() RETURNS Bit
AS EXTERNAL NAME DataRandomizerCLR.UserDefinedFunctions.FlipCoin;
GO
CREATE FUNCTION GetRandomStreetAddress() RETURNS nVarChar(256)
AS EXTERNAL NAME DataRandomizerCLR.UserDefinedFunctions.GetRandomStreetAddress;
GO
CREATE FUNCTION GetRandomCounty() RETURNS nVarChar(256)
AS EXTERNAL NAME DataRandomizerCLR.UserDefinedFunctions.GetRandomCounty;
GO
CREATE FUNCTION GetRandomFullAddress() RETURNS nVarChar(256)
AS EXTERNAL NAME DataRandomizerCLR.UserDefinedFunctions.GetRandomFullAddress;
GO
CREATE FUNCTION GetRandomCity() RETURNS nVarChar(256)
AS EXTERNAL NAME DataRandomizerCLR.UserDefinedFunctions.GetRandomCity;
GO
CREATE FUNCTION GetRandomStateName() RETURNS nVarChar(256)
AS EXTERNAL NAME DataRandomizerCLR.UserDefinedFunctions.GetRandomStateName;
GO
CREATE FUNCTION GetRandomPhoneNumber() RETURNS nVarChar(256)
AS EXTERNAL NAME DataRandomizerCLR.UserDefinedFunctions.GetRandomPhoneNumber;
GO
CREATE FUNCTION GetRandomAlphaStringLengthBetween(@minLength int, @maxLength int) RETURNS nVarChar(256)
AS EXTERNAL NAME DataRandomizerCLR.UserDefinedFunctions.GetRandomAlphaStringLengthBetween;
GO
CREATE FUNCTION GetRandomStringLengthBetween(@minLength int, @maxLength int) RETURNS nVarChar(256)
AS EXTERNAL NAME DataRandomizerCLR.UserDefinedFunctions.GetRandomStringLengthBetween;
GO
CREATE FUNCTION IsInitialized() RETURNS Bit
AS EXTERNAL NAME DataRandomizerCLR.UserDefinedFunctions.IsInitialized;
GO
CREATE FUNCTION GetRandomString(@length int) RETURNS nVarChar(256)
AS EXTERNAL NAME DataRandomizerCLR.UserDefinedFunctions.GetRandomString;
GO
CREATE FUNCTION GetRandomAlphaString(@length int) RETURNS nVarChar(256)
AS EXTERNAL NAME DataRandomizerCLR.UserDefinedFunctions.GetRandomAlphaString;
GO
