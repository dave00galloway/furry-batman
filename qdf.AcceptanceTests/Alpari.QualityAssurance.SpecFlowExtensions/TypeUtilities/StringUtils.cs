using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using Alpari.QualityAssurance.SpecFlowExtensions.LoggingUtilities;

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
            string doubleAsString = characters.Where(char.IsNumber)
                .Aggregate<char, string>(null, (current, character) => current + character);
            double magnitude = Convert.ToDouble(doubleAsString);
            return magnitude;
        }

        public static string ExtractLettersFromCharArray(this char[] characters)
        {
            return characters.Where(char.IsLetter)
                .Aggregate<char, string>(null, (current, character) => current + character);
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
            string padZeros = digit.ToString();
            while (padZeros.Length < length)
                padZeros = string.Format("0{0}", padZeros);
            return padZeros;
        }

        public static byte[] ConvertStringToByteArray(this string stringToConvert)
        {
            IEnumerable<byte> query = stringToConvert.ToArray().Select(Convert.ToByte);
            return query.ToArray();
        }

        public static string ByteArrayToString(this byte[] data, string separator)
        {
            string byteArrayAsString = String.Join(separator,
                data.Select(x => x.ToString(CultureInfo.InvariantCulture)).ToArray());
            //
            return byteArrayAsString;
        }

        public static byte[] StringToByteArray(this string data, char separator)
        {
            byte[] byteArray = data.Split(separator).Select(x => Convert.ToByte(x)).ToArray();
            return byteArray;
        }

        /// <summary>
        /// will always return the default ToString defined for the objectToSafeString, or an empty string instead of null
        /// if objectToSafeString is likley to be numeric or a date, and the format is important, 
        /// then consider creating an oveload to detect these types and specify a CultureInfo or use Invariant as a default
        /// </summary>
        /// <param name="objectToSafeString"></param>
        /// <returns></returns>
        public static string ToSafeString(this object objectToSafeString)
        {
            try
            {
                return objectToSafeString.ToString();
            }
            catch (Exception)
            {
                return String.Empty;
            }
        }

        /// <summary>
        ///     Turn a string into a CSV cell output
        ///    http://stackoverflow.com/questions/6377454/escaping-tricky-string-to-csv-format
        /// </summary>
        /// <param name="str">String to output</param>
        /// <returns>The CSV cell formatted string</returns>
        public static string StringToCsvCell(this string str)
        {
            bool mustQuote = (str.Contains(",") || str.Contains("\"") || str.Contains("\r") || str.Contains("\n"));
            if (mustQuote)
            {
                var sb = new StringBuilder();
                sb.Append("\"");
                foreach (char nextChar in str)
                {
                    sb.Append(nextChar);
                    if (nextChar == '"')
                        sb.Append("\"");
                }
                sb.Append("\"");
                return sb.ToString();
            }

            return str;
        }
    }
}