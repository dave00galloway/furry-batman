﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using Alpari.QualityAssurance.SpecFlowExtensions.LoggingUtilities;
using NUnit.Framework;
using TechTalk.SpecFlow;

namespace Alpari.QualityAssurance.SpecFlowExtensions.StepBases
{
    /// <summary>
    ///     Class for holding data being used in actual/expected comparisons, and methods to do comparisons
    ///     Should really have created this as a set of extension methods on Specflow.Table, but now have a more up to date class for that
    ///     Now using actual System.Data.DataTable for most comparisons, this class is mainly for backward compatibility
    /// </summary>
    public static class DataTableOperations
    {
        /// <summary>
        ///     Use Reflection to get all of the property names and values from an object as a dictionary as a string,Object
        ///     dictionary
        ///     Calling methods will be expected to know the types of the objects when accessing them for comparison
        ///     Note this returns only Properties, not Fields
        ///     A possible overload would be to store the dictionary keys as key value pairs of name/PropertyType
        ///     solution adapted from StackOverflow q 4943817
        /// </summary>
        /// <param name="objectToGetPropertiesFrom"></param>
        /// <param name="objectType"></param>
        /// <returns></returns>
        public static IDictionary<string, object> GetObjectPropertiesAsDictionary(object objectToGetPropertiesFrom,
            Type objectType)
        {
            PropertyInfo[] propertyInfoArray = objectType.GetProperties();
            IDictionary<string, object> dict = new Dictionary<string, object>();
            var indexer = new object[0];
            foreach (PropertyInfo propertyInfoItem in propertyInfoArray)
            {
                object value = propertyInfoItem.GetValue(objectToGetPropertiesFrom, indexer);
                dict.Add(propertyInfoItem.Name, value);
            }
            return dict;
        }

        /// <summary>
        ///     Search a list of dictionaries and return the first dictionary that matches the matchingCriteria
        ///     Candidate for simplifications using Linq, generics etc.
        /// </summary>
        /// <param name="matchingCriteria"></param>
        /// <param name="listOfDictionaries"></param>
        /// <returns></returns>
        public static Dictionary<string, object> GetDictionaryFromListOfDictionariesByKeyValuePair(
            KeyValuePair<string, object> matchingCriteria, IList<Dictionary<string, object>> listOfDictionaries)
        {
            var matchingDictionary = new Dictionary<string, object>();
            foreach (var dictionary in listOfDictionaries)
            {
                if (dictionary.Contains(matchingCriteria))
                {
                    matchingDictionary = dictionary;
                    break;
                }
            }
            return matchingDictionary;
        }

        /// <summary>
        ///     Find a dictionary in a list of dictionaries
        /// </summary>
        /// <param name="matchingCriteria">KVP to search for</param>
        /// <param name="comparisonMode">type of check to do - ony contains supported so far</param>
        /// <param name="listOfDictionaries"></param>
        /// <returns></returns>
        public static Dictionary<string, object> GetDictionaryFromListOfDictionariesByKeyValuePair(
            KeyValuePair<string, object> matchingCriteria, string comparisonMode,
            IList<Dictionary<string, object>> listOfDictionaries)
        {
            switch (comparisonMode)
            {
                case "ContainsListEntry":
                    foreach (var dictionary in listOfDictionaries)
                    {
                        try
                        {
                            if (!dictionary[matchingCriteria.Key].ToString().Split(',').Contains(matchingCriteria.Value))
                                continue;
                            return dictionary;
                        }
                        catch (Exception e)
                        {
                            ConsoleLogger.ConsoleExceptionLogger(e);
                        }
                    }
                    break;
            }
            throw new Exception(String.Format("couldn't find a match for {0}", matchingCriteria.Key));
        }

        /// <summary>
        ///     convert the TechTalk.SpecFlow.Table to a list of string,object dictionaries
        ///     equivalent to asMaps() in cucumber-jvm
        /// </summary>
        /// <param name="tableToConvert"></param>
        /// <returns></returns>
        public static IList<IDictionary<string, object>> GetTableAsList(Table tableToConvert)
        {
            IList<IDictionary<string, object>> tableAsList = new List<IDictionary<string, object>>();
            TableRows rows = tableToConvert.Rows;
            foreach (TableRow rowRecord in rows)
            {
                IDictionary<string, object> rowAsDictionary = new Dictionary<string, object>();
                foreach (var itemCell in rowRecord)
                {
                    rowAsDictionary.Add(itemCell.Key, itemCell.Value);
                }
                tableAsList.Add(rowAsDictionary);
            }
            return tableAsList;
        }

        /// <summary>
        ///     getTableAsList for dictionaruies - returns a single list with KVPs of dictionaries
        /// </summary>
        /// <param name="results"></param>
        /// <returns></returns>
        public static IList<IDictionary<string, object>> DictionaryToIlist(IDictionary<string, object> results)
        {
            IList<IDictionary<string, object>> tableAsList = new List<IDictionary<string, object>>();

            //tableAsList.Add(results);

            foreach (string key in results.Keys)
            {
                IDictionary<string, object> rowAsDictionary = new Dictionary<string, object>();
                rowAsDictionary.Add(key, results[key]);
                tableAsList.Add(rowAsDictionary);
            }

            return tableAsList;
        }

        /// <summary>
        ///     very simple table diffing method
        ///     returns a string with differences
        ///     Key names must match, and values must match when compared using ToString()
        ///     Compare expected vs actual only, ignore extra entries in Actual
        ///     TODO:- create a results type with diffs, comparison output, and detailed stack trace to rreturn rather than string
        /// </summary>
        /// <param name="expectedDictionary"></param>
        /// <param name="actualDictionary"></param>
        /// <returns>a string detailing diffences</returns>
        public static string VerifyTables(IDictionary<string, object> expectedDictionary,
            IDictionary<string, object> actualDictionary
            //, bool treatZeroAsNull = false
            )
        {
            var diffs = new StringBuilder();
            Dictionary<string, object> actualDictionaryAsDictionary = ConvertIDictionaryToDictionary(actualDictionary);
            foreach (var entry in expectedDictionary)
            {
                //pull all the data out first in case retrieving one or more data parts returns an error and the assertion doesn't take place
                string entryKey = "";
                string expectedValue = "";
                string actualValue = "";
                string comparisonDescription;
                try
                {
                    CompareDictionaryEntries(actualDictionaryAsDictionary, entry, out entryKey, out expectedValue,
                        out actualValue, out comparisonDescription);
                }
                //catch (KeyNotFoundException keyNotFoundException)
                //{
                //    if (!treatZeroAsNull || Convert.ToInt16(expectedValue) != 0)
                //    {
                //        throw new Exception("check for expected 0 failed",keyNotFoundException);
                //    }
                //}
                catch (Exception e)
                {
                    comparisonDescription = GetComparisonDescription(entryKey, expectedValue, actualValue,
                        out comparisonDescription);
                    diffs.AppendLine(String.Format("{0} threw exception {1}", comparisonDescription, e.Message));
                    if (e.InnerException != null)
                    {
                        diffs.AppendLine(String.Format("caused by {0}", e.InnerException.Message));
                    }
                }
            }
            return diffs.ToString();
        }

        public static string VerifyTables(IDictionary<string, object> expectedDictionary,
            Dictionary<string, int> actualDictionary)
        {
            var diffs = new StringBuilder();
            Dictionary<string, object> actualDictionaryToObjectDictionary =
                ConvertDictionaryToDictionary(actualDictionary);
            foreach (var entry in expectedDictionary)
            {
                //pull all the data out first in case retrieving one or more data parts returns an error and the assertion doesn't take place
                string entryKey = "";
                string expectedValue = "";
                string actualValue = "";
                string comparisonDescription;
                try
                {
                    CompareDictionaryEntries(actualDictionaryToObjectDictionary, entry, out entryKey, out expectedValue,
                        out actualValue, out comparisonDescription);
                }
                catch (Exception e)
                {
                    comparisonDescription = GetComparisonDescription(entryKey, expectedValue, actualValue,
                        out comparisonDescription);
                    diffs.AppendLine(String.Format("{0} threw exception {1}", comparisonDescription, e.Message));
                    if (e.InnerException != null)
                    {
                        diffs.AppendLine(String.Format("caused by {0}", e.InnerException.Message));
                    }
                }
            }
            return diffs.ToString();
        }

        /// <summary>
        ///     This overload allows fuzzy matching on the key column for the table - it ignores it entirely
        ///     THe tables must have already been identified as being a pair by using the key column
        /// </summary>
        /// <param name="tableKey"></param>
        /// <param name="expectedDictionary"></param>
        /// <param name="actualDictionary"></param>
        /// <returns></returns>
        public static string VerifyTables(string tableKey, IDictionary<string, object> expectedDictionary,
            Dictionary<string, object> actualDictionary)
        {
            var diffs = new StringBuilder();
            foreach (var entry in expectedDictionary)
            {
                //pull all the data out first in case retrieving one or more data parts returns an error and the assertion doesn't take place
                string entryKey = "";
                string expectedValue = "";
                string actualValue = "";
                string comparisonDescription;
                try
                {
                    if (entry.Key != tableKey)
                    {
                        CompareDictionaryEntries(actualDictionary, entry, out entryKey, out expectedValue,
                            out actualValue, out comparisonDescription);
                    }
                }
                catch (Exception e)
                {
                    comparisonDescription = GetComparisonDescription(entryKey, expectedValue, actualValue,
                        out comparisonDescription);
                    diffs.AppendLine(String.Format("{0} threw exception {1}", comparisonDescription, e.Message));
                    if (e.InnerException != null)
                    {
                        diffs.AppendLine(String.Format("caused by {0}", e.InnerException.Message));
                    }
                }
            }
            return diffs.ToString();
        }

        private static void CompareDictionaryEntries(Dictionary<string, object> actualDictionary,
            KeyValuePair<string, object> entry, out string entryKey, out string expectedValue, out string actualValue,
            out string comparisonDescription)
        {
            entryKey = entry.Key;
            expectedValue = entry.Value.ToString();
            actualValue = actualDictionary[entryKey].ToString();
            comparisonDescription = GetComparisonDescription(entryKey, expectedValue, actualValue,
                out comparisonDescription);
            try
            {
                Assert.AreEqual(expectedValue, actualValue, comparisonDescription);
            }
            catch (Exception e)
            {
                comparisonDescription = GetComparisonDescription(entryKey, expectedValue, actualValue,
                    out comparisonDescription);
                throw new Exception(comparisonDescription, e);
            }
        }

        /// <summary>
        ///     Calls VerifyTables(IDictionary string, object expectedDictionary, IDictionary string, object actualDictionary)
        ///     repeatedly for each Entry in expectedListOfDictionaries. one directional check on object comparisons done by
        ///     ToString Exact Match only
        ///     Extra entries in either the actual list of dictionaries or in the actual dictionaries in the list are ignored
        ///     There's no key supplied, so the dictionaries have to be in the same order
        /// </summary>
        /// <param name="dictionariesAsLists"></param>
        /// <returns></returns>
        public static string VerifyTables(ExpectedAndActualIDictionariesAsIlIsts dictionariesAsLists)
        {
            var diffs = new StringBuilder();
            for (int i = 0; i < dictionariesAsLists.Expected.Count - 1; i++)
            {
                try
                {
                    string diff = VerifyTables(dictionariesAsLists.Expected[i], dictionariesAsLists.Actual[i]);
                    if (diff.Length > 0)
                    {
                        diffs.AppendLine(diff);
                    }
                }
                catch (Exception e)
                {
                    diffs.AppendLine(
                        String.Format("Exception thrown comparing dictionaries. Exception details {0} {1} {2}",
                            e.Message, e.Source, e.StackTrace));
                }
            }
            return diffs.ToString();
        }

        /// <summary>
        ///     Slightly more useful overload of VerifyTables as it allows specification of a key column to identify which
        ///     dictionary in the expected list to compare with which in the actual list
        /// </summary>
        /// <param name="tableKey"></param>
        /// <param name="dictionariesAsLists"></param>
        /// <param name="treatZeroAsNull">if true, and the expected result is 0, then ignore "given key was not present in the dictionary" exception</param>
        /// <returns></returns>
        public static string VerifyTables(string tableKey, ExpectedAndActualIDictionariesAsIlIsts dictionariesAsLists
            //, bool treatZeroAsNull = false
            )
        {
            var diffs = new StringBuilder();
            IList<Dictionary<string, object>> actualListOfDictionaries =
                ConvertIListIDictionaryToIlistDictionary(dictionariesAsLists.Actual);
            foreach (var expectedDictionary in dictionariesAsLists.Expected)
            {
                try
                {
                    var matcher = new KeyValuePair<string, object>(tableKey, expectedDictionary[tableKey]);
                    Dictionary<string, object> actualDictionary =
                        GetDictionaryFromListOfDictionariesByKeyValuePair(matcher, actualListOfDictionaries);
                    string diff = VerifyTables(expectedDictionary, actualDictionary); //, treatZeroAsNull);
                    if (diff.Length > 0)
                    {
                        //diffs.AppendLine("####################################");
                        diffs.AppendLine(String.Format("Diff at key {0} value {1} ", matcher.Key, matcher.Value));
                        diffs.AppendLine(diff);
                        //diffs.AppendLine("####################################");
                    }
                }
                catch (Exception e)
                {
                    // diffs.AppendLine("####################################");
                    diffs.AppendLine(
                        String.Format(
                            "Exception thrown comparing dictionaries using expected key {0} value {1}. Exception details {2} {3} {4}",
                            tableKey, expectedDictionary[tableKey], e.Message, e.Source, e.StackTrace));
                    // diffs.AppendLine("####################################");
                }
            }
            return diffs.ToString();
        }

        /// <summary>
        ///     TODO:- implement an enum for comparison types
        /// </summary>
        /// <param name="tableKey"></param>
        /// <param name="comparisonMode"></param>
        /// <param name="dictionariesAsLists"></param>
        /// <returns></returns>
        public static string VerifyTables(string tableKey, string comparisonMode,
            ExpectedAndActualIDictionariesAsIlIsts dictionariesAsLists)
        {
            var diffs = new StringBuilder();
            IList<Dictionary<string, object>> actualListOfDictionaries =
                ConvertIListIDictionaryToIlistDictionary(dictionariesAsLists.Actual);
            foreach (var expectedDictionary in dictionariesAsLists.Expected)
            {
                try
                {
                    var matcher = new KeyValuePair<string, object>(tableKey, expectedDictionary[tableKey]);
                    Dictionary<string, object> actualDictionary =
                        GetDictionaryFromListOfDictionariesByKeyValuePair(matcher, comparisonMode,
                            actualListOfDictionaries);
                    string diff = VerifyTables(tableKey, expectedDictionary, actualDictionary);
                    if (diff.Length > 0)
                    {
                        //diffs.AppendLine("####################################");
                        diffs.AppendLine(String.Format("Diff at key {0} value {1} ", matcher.Key, matcher.Value));
                        diffs.AppendLine(diff);
                        //diffs.AppendLine("####################################");
                    }
                }
                catch (Exception e)
                {
                    // diffs.AppendLine("####################################");
                    diffs.AppendLine(
                        String.Format(
                            "Exception thrown comparing dictionaries using expected key {0} value {1}. Exception details {2} {3} {4}",
                            tableKey, expectedDictionary[tableKey], e.Message, e.Source, e.StackTrace));
                    // diffs.AppendLine("####################################");
                }
            }
            return diffs.ToString();
            // throw new NotImplementedException();
        }

        /// <summary>
        ///     Converts an Ilist of Idicts to an IList of Dicts.
        ///     Probably a more efficient way of doing this in Linq, or using generics to avoid needing to convert the
        ///     dictionaries!
        /// </summary>
        /// <param name="listOfIDictionaries"></param>
        /// <returns></returns>
        public static IList<Dictionary<string, object>> ConvertIListIDictionaryToIlistDictionary(
            IList<IDictionary<string, object>> listOfIDictionaries)
        {
            return listOfIDictionaries.Select(ConvertIDictionaryToDictionary).ToList();
        }

        public static Dictionary<string, object> ConvertIDictionaryToDictionary(IDictionary<string, object> iDict)
        {
            return iDict.ToDictionary(kvp => kvp.Key, kvp => kvp.Value);
        }

        public static Dictionary<string, object> ConvertDictionaryToDictionary(Dictionary<string, int> dict)
        {
            return dict.ToDictionary(kvp => kvp.Key, kvp => (object) kvp.Value);
        }

        private static string GetComparisonDescription(string entryKey, string expectedValue, string actualValue,
            out string comparisonDescription)
        {
            comparisonDescription = String.Format("Comparing key '{0}' expected value '{1}' with actual value '{2}'",
                entryKey, expectedValue, actualValue);
            return comparisonDescription;
        }
    }

    public class ExpectedAndActualIDictionariesAsIlIsts
    {
        public ExpectedAndActualIDictionariesAsIlIsts()
        {
        }

        public ExpectedAndActualIDictionariesAsIlIsts(IList<IDictionary<string, object>> expected,
            IList<IDictionary<string, object>> actual)
        {
            Expected = expected;
            Actual = actual;
        }

        public IList<IDictionary<string, object>> Expected { get; set; }
        public IList<IDictionary<string, object>> Actual { get; set; }
    }


    public class DictionaryAsIlist
    {
        public IList<IDictionary<string, object>> IdictionaryAsIlist { get; set; }
    }
}