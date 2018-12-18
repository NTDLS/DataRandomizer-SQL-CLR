using DataRandomizer.Classes;
using DataRandomizer.Extensions;
using Microsoft.SqlServer.Server;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;

public partial class UserDefinedFunctions
{
    private static string NotInitializedMessage = "The DataRandomizer is not initialized. Call [InitializeRandom] to initialize the random data set. (Example: EXEC InitializeRandom 'C:\\DataPath')";
    private static bool initialized = false;
    private static Random random = null;

    private static List<string> words = null;
    private static List<string> companySuffixes = null;
    private static List<string> streetSuffixes = null;
    private static List<string> states = null;
    private static List<string> counties = null;
    private static List<string> cities = null;
    private static List<string> domainSuffixes = null;

    private static List<string> ParseFile(string fileName)
    {
        using (StreamReader sr = new StreamReader(fileName))
        {
            return sr.ReadToEnd().Split(new char[] { '\n' }, StringSplitOptions.RemoveEmptyEntries).Select(p => p.Trim()).ToList();
        }
    }

    [SqlProcedure]
    public static void InitializeRandom(string randomDataPath)
    {
        random = new Random(Utility.Checksum(Guid.NewGuid().ToString()));

        words = ParseFile(Path.Combine(randomDataPath, "Words.txt"));
        companySuffixes = ParseFile(Path.Combine(randomDataPath, "CompanySuffixes.txt"));
        streetSuffixes = ParseFile(Path.Combine(randomDataPath, "StreetSuffixes.txt"));
        states = ParseFile(Path.Combine(randomDataPath, "States.txt"));
        counties = ParseFile(Path.Combine(randomDataPath, "Counties.txt"));
        cities = ParseFile(Path.Combine(randomDataPath, "Cities.txt"));
        domainSuffixes = ParseFile(Path.Combine(randomDataPath, "DomainSuffixes.txt"));

        initialized = true;
    }

    [SqlFunction]
    public static int GetRandomNumber(int min, int max)
    {
        return random.Next(min, max + 1);
    }

    [SqlFunction]
    public static string GetRandomNumberOfWords(int min, int max)
    {
        if (initialized == false)
        {
            throw new Exception(NotInitializedMessage);
        }

        StringBuilder builder = new StringBuilder();
        int randomNumber = random.Next(min, max + 1);

        for (int i = 0; i < randomNumber; i++)
        {
            builder.AppendFormat("{0} ", GetRandomWord());
        }

        return builder.ToString().Trim();
    }

    [SqlFunction]
    public static string GetRandomWords(int count)
    {
        if (initialized == false)
        {
            throw new Exception(NotInitializedMessage);
        }

        StringBuilder builder = new StringBuilder();

        for (int i = 0; i < count; i++)
        {
            builder.AppendFormat("{0} ", GetRandomWord());
        }

        return builder.ToString().Trim();
    }

    [SqlFunction]
    public static string GetRandomDomainSuffix()
    {
        if (initialized == false)
        {
            throw new Exception(NotInitializedMessage);
        }

        return domainSuffixes[random.Next(0, domainSuffixes.Count)];
    }

    [SqlFunction]
    public static string GetRandomEmailAddress()
    {
        if (initialized == false)
        {
            throw new Exception(NotInitializedMessage);
        }

        return string.Format("{0}@{1}.{2}", GetRandomWord(), GetRandomWord(), GetRandomDomainSuffix());
    }

    [SqlFunction]
    public static string GetRandomWord()
    {
        if (initialized == false)
        {
            throw new Exception(NotInitializedMessage);
        }

        return words[random.Next(0, words.Count)];
    }

    [SqlFunction]
    public static string GetRandomCompanySuffix()
    {
        if (initialized == false)
        {
            throw new Exception(NotInitializedMessage);
        }

        string suffix = companySuffixes[random.Next(0, companySuffixes.Count)];

        int chance = random.Next(0, 100);

        if (chance >= 66)
        {
            suffix = suffix.ToUpper();
        }
        else if (chance >= 33)
        {
            suffix = suffix.ToLower();
        }
        else
        {
            suffix = suffix.Substring(0, 1).ToUpper() + suffix.Substring(1, suffix.Length - 1).ToLower();
        }

        if (FlipCoin())
        {
            suffix += ".";
        }

        return suffix;
    }

    [SqlFunction]
    public static bool FlipCoin()
    {
        if (initialized == false)
        {
            throw new Exception(NotInitializedMessage);
        }

        return (random.Next(0, 100) >= 50);
    }

    [SqlFunction]
    public static bool IsInitialized()
    {

        return initialized;
    }

    [SqlFunction]
    public static string GetRandomCompanyName()
    {
        if (initialized == false)
        {
            throw new Exception(NotInitializedMessage);
        }

        string seperator = " ";

        if (FlipCoin())
        {
            seperator = ", ";
        }

        return GetRandomWords(2) + seperator + GetRandomCompanySuffix();
    }

    [SqlFunction]
    public static string GetRandomStreetSuffix()
    {
        if (initialized == false)
        {
            throw new Exception(NotInitializedMessage);
        }

        string suffix = streetSuffixes[random.Next(0, streetSuffixes.Count())];

        int chance = random.Next(0, 100);

        if (chance >= 66)
        {
            suffix = suffix.ToUpper();
        }
        else if (chance >= 33)
        {
            suffix = suffix.ToLower();
        }
        else
        {
            suffix = suffix.Substring(0, 1).ToUpper() + suffix.Substring(1, suffix.Length - 1).ToLower();
        }

        if (FlipCoin())
        {
            suffix += ".";
        }

        return suffix;
    }

    [SqlFunction]
    public static string GetRandomStreetName()
    {
        if (initialized == false)
        {
            throw new Exception(NotInitializedMessage);
        }

        string seperator = " ";

        if (FlipCoin())
        {
            seperator = ", ";
        }

        return GetRandomWords(2) + seperator + GetRandomStreetSuffix();
    }

    [SqlFunction]
    public static string GetRandomNumberString(int length)
    {
        if (initialized == false)
        {
            throw new Exception(NotInitializedMessage);
        }

        string result = string.Empty;

        while (result.Length < length)
        {
            result += random.Next(0, 10000000).ToString();
        }

        return result.Substring(0, length);
    }

    [SqlFunction]
    public static string GetRandomAlphaString(int length)
    {
        if (initialized == false)
        {
            throw new Exception(NotInitializedMessage);
        }

        string result = string.Empty;

        while (result.Length < length)
        {
            if (FlipCoin())
            {
                result += (char)random.Next(65, 90);
            }
            else
            {
                result += (char)random.Next(97, 122);
            }
        }

        return result.Substring(0, length);
    }

    [SqlFunction]
    public static string GetRandomString(int length)
    {
        if (initialized == false)
        {
            throw new Exception(NotInitializedMessage);
        }

        string result = string.Empty;

        while (result.Length < length)
        {
            result += (char)random.Next(32, 126);
        }

        return result.Substring(0, length);
    }

    [SqlFunction]
    public static string GetRandomNumberStringLengthBetween(int minLength, int maxLength)
    {
        if (initialized == false)
        {
            throw new Exception(NotInitializedMessage);
        }

        string result = string.Empty;
        int length = random.Next(minLength, maxLength + 1);

        while (result.Length < length)
        {
            result += random.Next(0, 10000000).ToString();
        }

        return result.Substring(0, length);
    }

    [SqlFunction]
    public static string GetRandomAlphaStringLengthBetween(int minLength, int maxLength)
    {
        if (initialized == false)
        {
            throw new Exception(NotInitializedMessage);
        }

        string result = string.Empty;
        int length = random.Next(minLength, maxLength + 1);

        while (result.Length < length)
        {
            if (FlipCoin())
            {
                result += (char)random.Next(65, 90);
            }
            else
            {
                result += (char)random.Next(97, 122);
            }
        }

        return result.Substring(0, length);
    }

    [SqlFunction]
    public static string GetRandomStringLengthBetween(int minLength, int maxLength)
    {
        if (initialized == false)
        {
            throw new Exception(NotInitializedMessage);
        }

        string result = string.Empty;
        int length = random.Next(minLength, maxLength + 1);

        while (result.Length < length)
        {
            result += (char)random.Next(32, 126);
        }

        return result.Substring(0, length);
    }

    [SqlFunction]
    public static string GetRandomStreetAddress()
    {
        if (initialized == false)
        {
            throw new Exception(NotInitializedMessage);
        }

        return GetRandomNumberStringLengthBetween(3, 6) + " " + GetRandomStreetName();
    }

    [SqlFunction]
    public static string GetRandomFullAddress()
    {
        if (initialized == false)
        {
            throw new Exception(NotInitializedMessage);
        }

        return GetRandomStreetAddress() + " " + GetRandomCity() + ", " + GetRandomStateName() + " " + GetRandomNumberString(5);
    }

    [SqlFunction]
    public static string GetRandomCity()
    {
        if (initialized == false)
        {
            throw new Exception(NotInitializedMessage);
        }

        return cities[random.Next(0, cities.Count)];
    }


    [SqlFunction]
    public static string GetRandomCounty()
    {
        if (initialized == false)
        {
            throw new Exception(NotInitializedMessage);
        }

        return counties[random.Next(0, counties.Count)];
    }


    [SqlFunction]
    public static string GetRandomStateName()
    {
        if (initialized == false)
        {
            throw new Exception(NotInitializedMessage);
        }

        return states[random.Next(0, states.Count)];
    }

    [SqlFunction]
    public static string GetRandomPhoneNumber()
    {
        if (initialized == false)
        {
            throw new Exception(NotInitializedMessage);
        }

        string areaCode = string.Empty;
        string seperator = string.Empty;

        if (FlipCoin())
        {
            areaCode = "(" + GetRandomNumberString(3) + ")";
        }
        else
        {
            areaCode = GetRandomNumberString(3);
        }

        int chance = random.Next(0, 100);

        if (chance >= 75)
        {
            seperator = ".";
        }
        else if (chance >= 50)
        {
            seperator = "-";
        }
        else if (chance >= 25)
        {
            seperator = " ";
        }

        return (areaCode.Length > 0 ? areaCode + " " : areaCode + seperator) + GetRandomNumberString(3) + seperator + GetRandomNumberString(4);
    }
}
