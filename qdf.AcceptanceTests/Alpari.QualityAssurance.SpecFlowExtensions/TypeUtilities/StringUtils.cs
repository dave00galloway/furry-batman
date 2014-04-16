using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities
{
    /// <summary>
    /// methods for converting to/from strings
    /// </summary>
    public static class StringUtils
    {
        /// <summary>
        /// get all numbers from the char array and create a double from it
        /// additional overloads may be required if non-contiguous numbers are to be treated as seperate numbers or ignored
        /// </summary>
        /// <param name="characters"></param>
        /// <returns></returns>
        public static double ExtractDoubleFromCharArray(this char[] characters)
        {
            double magnitude;
            string doubleAsString = null;
            foreach (char character in characters)
            {
                if (char.IsNumber(character))
                {
                    doubleAsString += character;
                }
            }
            magnitude = Convert.ToDouble(doubleAsString);
            return magnitude;
        }

        public static string ExtractLettersFromCharArray(this char[] characters)
        {
            string Letters = null;
            foreach (char character in characters)
            {
                if (char.IsLetter(character))
                {
                    Letters += character;
                }
            }
            return Letters;
        }

    }
}
