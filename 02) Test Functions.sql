IF dbo.IsInitialized() = 0
BEGIN
    EXEC dbo.InitializeRandom 'C:\CLR\DataRandomizer\Data'
END

SELECT
    dbo.IsInitialized() as IsInitialized,
	dbo.FlipCoin() as FlipCoin

SELECT
	dbo.GetRandomString(10) as GetRandomString,
	dbo.GetRandomAlphaString(10) as GetRandomAlphaString,
	dbo.GetRandomNumberString(10) as GetRandomNumberString

SELECT
	dbo.GetRandomStringLengthBetween(5, 10) as GetRandomStringLengthBetween,
   	dbo.GetRandomAlphaStringLengthBetween(5, 10) as GetRandomAlphaStringLengthBetween,
	dbo.GetRandomNumberStringLengthBetween(5, 10) as GetRandomNumberStringLengthBetween

SELECT
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
	dbo.GetRandomStreetName() as GetRandomStreetName

SELECT
	dbo.GetRandomDomainSuffix() as GetRandomDomainSuffix,
	dbo.GetRandomStateName() as GetRandomStateName,
	dbo.GetRandomEmailAddress() as GetRandomEmailAddress,
	dbo.GetRandomNumber(10, 20) as GetRandomNumber,
	dbo.GetRandomCounty() as GetRandomCounty
