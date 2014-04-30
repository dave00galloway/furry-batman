using System;
using System.Collections.Generic;

namespace Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities
{
    /// <summary>
    ///     Contains methods for performing operations on numeric types, e.g. maths, rounding etc.
    /// </summary>
    public static class NumericExtensions
    {
        /// <summary>
        ///     http://stackoverflow.com/questions/4823467/using-linq-to-find-the-cumulative-sum-of-an-array-of-numbers-in-c-sharp
        /// </summary>
        /// <param name="sequence"></param>
        /// <returns></returns>
        public static IEnumerable<double> CumulativeSum(this IEnumerable<double> sequence)
        {
            double sum = 0;
            foreach (double item in sequence)
            {
                sum += item;
                yield return sum;
            }
        }

        /// <summary>
        ///     http://stackoverflow.com/questions/4823467/using-linq-to-find-the-cumulative-sum-of-an-array-of-numbers-in-c-sharp
        /// </summary>
        /// <param name="sequence"></param>
        /// <returns></returns>
        public static IEnumerable<decimal> CumulativeSum(this IEnumerable<decimal> sequence)
        {
            decimal sum = 0;
            foreach (decimal item in sequence)
            {
                sum += item;
                yield return sum;
            }
        }

        /// <summary>
        ///     http://stackoverflow.com/questions/4823467/using-linq-to-find-the-cumulative-sum-of-an-array-of-numbers-in-c-sharp
        /// </summary>
        /// /// <typeparam name="T"></typeparam>
        /// <param name="sequence"></param>
        /// <returns></returns>
        public static IEnumerable<decimal> CumulativeSumToDecimal<T>(this IEnumerable<T> sequence)
        {
            decimal sum = 0;
            foreach (T item in sequence)
            {
                sum += Convert.ToDecimal(item);
                yield return sum;
            }
        }

        /// <summary>
        ///     http://stackoverflow.com/questions/4823467/using-linq-to-find-the-cumulative-sum-of-an-array-of-numbers-in-c-sharp
        ///     take a set of numbers of any type and return as a set of doubles, cumulatively summed
        ///     not quite as generic as hoped as the output type is fixed as double, but  better than creating all variations of
        ///     this manually
        ///     will throw errors if T is not convertable to a double
        /// </summary>
        /// /// <typeparam name="T"></typeparam>
        /// <param name="sequence"></param>
        /// <returns></returns>
        public static IEnumerable<double> CumulativeSum<T>(this IEnumerable<T> sequence)
        {
            double sum = 0;
            foreach (T item in sequence)
            {
                sum += Convert.ToDouble(item);
                yield return sum;
            }
        }

        ///// <summary>
        ///// unfortunately this won't compile. see
        ///// http://stackoverflow.com/questions/10951392/implementing-arithmetic-in-generics
        ///// </summary>
        ///// <param name="sequence"></param>
        ///// <returns></returns>
        //public static IEnumerable<T> CumulativeSum<T,U>(this IEnumerable<U> sequence) where T:struct
        //{
        //    T sum = default(T);
        //    foreach (var item in sequence)
        //    {
        //        sum += item;
        //        yield return sum;
        //    }
        //}

        /// <summary>
        /// returns the list of differences between each number in the sequence
        /// </summary>
        /// <param name="sequence"></param>
        /// <returns></returns>
        public static IEnumerable<decimal> CalculateDeltas(this IEnumerable<decimal> sequence)
        {
            decimal prev = default(decimal);
            foreach (var item in sequence)
            {
                var current = item;
                decimal diff = current - prev;
                prev = item;
                yield return diff;
            }
        }

        /// <summary>
        /// http://stackoverflow.com/questions/23391119/error-iterator-cannot-contain-return-statement-when-calling-a-method-that-ret
        /// </summary>
        /// <param name="sequence"></param>
        /// <param name="absolute"></param>
        /// <returns></returns>
        public static IEnumerable<decimal> CalculateDeltas(this IEnumerable<decimal> sequence, bool absolute)
        {
            if (absolute)
            {
                decimal prev = default(decimal);
                foreach (var item in sequence)
                {
                    var current = item;
                    decimal diff = Math.Abs(current - prev);
                    prev = item;
                    yield return diff;
                }
            }
            else
            {
                foreach (var item in sequence.CalculateDeltas())
                    yield return item;
            }
        }

    }
}