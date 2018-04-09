sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO
sp_configure 'clr enabled', 1;
GO
RECONFIGURE;
GO

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.databases)
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
CREATE FUNCTION GetRandomNumberString(@count int) RETURNS nVarChar(256)
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

EXEC dbo.InitializeRandom 'C:\CLR\DataRandomizer\Data'
go

SELECT
	dbo.GetRandomNumberString(10) as GetRandomNumberString,
	dbo.GetRandomFullAddress() as GetRandomFullAddress,
	dbo.GetRandomStreetAddress() as GetRandomStreetAddress,
	dbo.GetRandomPhoneNumber() as GetRandomPhoneNumber,
	dbo.GetRandomNumberOfWords(2, 5) as GetRandomNumberOfWords,
	dbo.GetRandomCompanyName() as GetRandomCompanyName

SELECT
	dbo.GetRandomWords(3) as GetRandomWords,
	dbo.GetRandomCity() as GetRandomCity,
	dbo.GetRandomStreetSuffix() as GetRandomStreetSuffix,
	dbo.GetRandomWord() as GetRandomWord,
	dbo.GetRandomStreetName() as GetRandomStreetName,
	dbo.GetRandomNumberStringLengthBetween(3, 5) as GetRandomNumberStringLengthBetween

SELECT
	dbo.FlipCoin() as FlipCoin,
	dbo.GetRandomDomainSuffix() as GetRandomDomainSuffix,
	dbo.GetRandomStateName() as GetRandomStateName,
	dbo.GetRandomEmailAddress() as GetRandomEmailAddress,
	dbo.GetRandomNumber(10, 20) as GetRandomNumber,
	dbo.GetRandomCounty() as GetRandomCounty
GO

drop procedure InitializeRandom
drop function GetRandomNumberString
drop function GetRandomFullAddress
drop function GetRandomStreetAddress
drop function GetRandomPhoneNumber
drop function GetRandomNumberOfWords
drop function GetRandomCompanyName
drop function GetRandomWords
drop function GetRandomCity
drop function GetRandomCounty
drop function GetRandomStreetSuffix
drop function GetRandomWord
drop function GetRandomStreetName
drop function GetRandomNumberStringLengthBetween
drop function FlipCoin
drop function GetRandomDomainSuffix
drop function GetRandomStateName
drop function GetRandomEmailAddress
drop function GetRandomNumber
go

DROP ASSEMBLY DataRandomizerCLR
