using System;
using System.Collections.Generic;
using System.Linq;

namespace Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities
{
    public static class EnumExtensions
    {
        /// <summary>
        /// http://stackoverflow.com/questions/1424971/parse-string-to-enum-type
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="input"></param>
        /// <returns></returns>
        public static Nullable<T> Parse<T>(this string input) where T : struct
        {
            //since we cant do a generic type constraint
            if (!typeof(T).IsEnum)
            {
                throw new ArgumentException("Generic Type 'T' must be an Enum");
            }
            if (!string.IsNullOrEmpty(input))
            {
                if (Enum.GetNames(typeof(T)).Any(
                      e => e.Trim().ToUpperInvariant() == input.Trim().ToUpperInvariant()))
                {
                    return (T)Enum.Parse(typeof(T), input, true);
                }
            }
            return null;
        }

        public static object ParseEnum(this object value, Type type)
        {
            var enumType = type;
            if (enumType.IsEnum)
            {
                return Enum.ToObject(enumType, value);
            }
            return null;
        }

        /// <summary>
        /// http://stackoverflow.com/questions/972307/can-you-loop-through-all-enum-values
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <returns></returns>
        public static IEnumerable<T> GetValues<T>()
        {
            return Enum.GetValues(typeof(T)).Cast<T>();
        }
    }
}
