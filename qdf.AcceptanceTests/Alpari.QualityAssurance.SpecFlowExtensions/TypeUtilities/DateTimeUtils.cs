using System;

namespace Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities
{
    /// <summary>
    ///     methods for converting to/from datetime
    /// </summary>
    public static class DateTimeUtils
    {
        /// <summary>
        ///     use this where MySql expects date time in the format yyyy-MM-dd H:mm:ss e.g. 2014-04-17 10:47:34
        /// </summary>
        public const string MySqlDateFormatToSeconds = "yyyy-MM-dd H:mm:ss";

        public static string ConvertDateTimeToMySqlDateFormatToSeconds(this DateTime dateTime)
        {
            string dateAsString = String.Format("{0}-{1}-{2} {3}:{4}:{5}", dateTime.Year, dateTime.Month.PadZeros(2),
                dateTime.Day.PadZeros(2), dateTime.Hour.PadZeros(2), dateTime.Minute.PadZeros(2),
                dateTime.Second.PadZeros(2));
            return dateAsString;
        }

        public static string ConvertDateTimeToFileFriendlyTime(this DateTime dateTime)
        {
            string dateAsString = String.Format("{0}{1}{2}{3}{4}{5}{6}", dateTime.Year, dateTime.Month.PadZeros(2),
                dateTime.Day.PadZeros(2), dateTime.Hour.PadZeros(2), dateTime.Minute.PadZeros(2),
                dateTime.Second.PadZeros(2),dateTime.Millisecond.PadZeros(3));
            return dateAsString;
        }

        /// <summary>
        ///     Create a datetime from a shorthand string code relative to current date
        /// </summary>
        /// <param name="shortCode">format +\- magnitude units</param>
        /// <returns>equivalent datetime</returns>
        public static DateTime GetTimeFromShortCode(this string shortCode)
        {
            //char[] characters = shortCode.ToCharArray();
            ////get the sign. if plus or a number then assume +
            //bool sign = IsCharAPlus(characters, 0);
            //double magnitude = sign ? characters.ExtractDoubleFromCharArray() : characters.ExtractDoubleFromCharArray()*-1;
            //string units = characters.ExtractLettersFromCharArray();
            double magnitude;
            string units;
            ParseShortCode(shortCode, out magnitude, out units);
            return ConvertShortCodeToDate(DateTime.UtcNow, magnitude, units);
        }

        /// <summary>
        ///     overload that allows a refernce start date
        /// </summary>
        /// <param name="shortCode">format +\- magnitude units</param>
        /// <param name="startDate">reference date</param>
        /// <returns></returns>
        public static DateTime GetTimeFromShortCode(this string shortCode, DateTime startDate)
        {
            double magnitude;
            string units;
            ParseShortCode(shortCode, out magnitude, out units);

            return ConvertShortCodeToDate(startDate, magnitude, units);
        }

        private static DateTime ConvertShortCodeToDate(DateTime startDate, double magnitude, string units)
        {
            switch (units.ToUpper())
            {
                case "DAYS":
                case "DAY":
                case "D":
                    return startDate.AddDays(magnitude);
                case "HOURS":
                case "HR":
                case "H":
                    return startDate.AddHours(magnitude);
                case "MILLISECONDS":
                case "MILLIS":
                case "MILLI":
                case "MILLS":
                case "MLS":
                    return startDate.AddMilliseconds(magnitude);
                case "MINUTES":
                case "MIN":
                    return startDate.AddMinutes(magnitude);
                case "MONTHS":
                case "MONS":
                case "MON":
                case "M":
                    return startDate.AddMonths(Convert.ToInt32(magnitude));
                case "SECONDS":
                case "SECS":
                case "SEC":
                case "S":
                    return startDate.AddSeconds(magnitude);
                case "TICKS":
                case "T":
                    return startDate.AddTicks((long) magnitude);
                case "YEARS":
                case "YRS":
                case "YR":
                case "YS":
                case "Y":
                    return startDate.AddYears(Convert.ToInt32(magnitude));
                default:
                    throw new ArgumentException(
                        String.Format("parameter units '{0}' is not recognised as a valid time period", units));
            }
        }

        private static void ParseShortCode(string shortCode, out double magnitude, out string units)
        {
            char[] characters = shortCode.ToCharArray();
            //get the sign. if plus or a number then assume +
            bool sign = IsCharAPlus(characters, 0);
            magnitude = sign ? characters.ExtractDoubleFromCharArray() : characters.ExtractDoubleFromCharArray()*-1;
            units = characters.ExtractLettersFromCharArray();
        }

        private static bool IsCharAPlus(char[] characters, int digit)
        {
            bool sign = characters[digit] == '+' || Char.IsNumber(characters[digit]);
            return sign;
        }
    }
}