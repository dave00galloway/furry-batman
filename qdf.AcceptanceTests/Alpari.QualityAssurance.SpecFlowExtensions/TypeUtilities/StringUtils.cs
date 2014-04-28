using System;
using System.Globalization;
using System.Linq;

namespace Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities
{
    /// <summary>
    ///     methods for converting to/from strings
    /// </summary>
    public static class StringUtils
    {
        /// <summary>
        ///     get all numbers from the char array and create a double from it
        ///     additional overloads may be required if non-contiguous numbers are to be treated as seperate numbers or ignored
        /// </summary>
        /// <param name="characters"></param>
        /// <returns></returns>
        public static double ExtractDoubleFromCharArray(this char[] characters)
        {
            var doubleAsString = characters.Where(char.IsNumber).Aggregate<char, string>(null, (current, character) => current + character);
            var magnitude = Convert.ToDouble(doubleAsString);
            return magnitude;
        }

        public static string ExtractLettersFromCharArray(this char[] characters)
        {
            return characters.Where(char.IsLetter).Aggregate<char, string>(null, (current, character) => current + character);
            //foreach (var character in characters)
            //{
            //    if (char.IsLetter(character))
            //    {
            //        letters += character;
            //    }
            //}
            //return letters;
        }

        public static string PadZeros(this object digit, int length)
        {
            var padZeros = digit.ToString();
            while (padZeros.Length < length)
                padZeros = string.Format("0{0}", padZeros);
            return padZeros;
        }

        public static byte[] ConvertStringToByteArray(this string stringToConvert)
        {
            var query = stringToConvert.ToArray().Select(Convert.ToByte);
            return query.ToArray();
        }

        public static string ByteArrayToString(this byte[] data, string separator)
        {
            string byteArrayAsString = String.Join(separator, data.Select(x => x.ToString(CultureInfo.InvariantCulture)).ToArray());
            //
            return byteArrayAsString;
        }

        public static byte[] StringToByteArray(this string data, char separator)
        {
            var byteArray = data.Split(separator).Select(x => Convert.ToByte(x)).ToArray();
            return byteArray;
        }
    }
}