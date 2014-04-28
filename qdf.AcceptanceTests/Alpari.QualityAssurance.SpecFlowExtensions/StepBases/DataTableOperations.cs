using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using NUnit.Framework;
using TechTalk.SpecFlow;

namespace Alpari.QualityAssurance.SpecFlowExtensions.StepBases
{
    /// <summary>
    ///     Class for holding data being used in actual/expected comparisons, and methods to do comparisons
    /// </summary>
    public class DataTableOperations
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
        public static IDictionary<string, object> getObjectPropertiesAsDictionary(object objectToGetPropertiesFrom,
            Type objectType)
        {
            var propertyInfoArray = objectType.GetProperties();
            IDictionary<string, object> dict = new Dictionary<string, object>();
            var indexer = new object[0];
            foreach (var propertyInfoItem in propertyInfoArray)
            {
                var value = propertyInfoItem.GetValue(objectToGetPropertiesFrom, indexer);
                dict.Add(propertyInfoItem.Name, value);
            }
            return dict;
        }

        /// <summary>
        ///     Search a list of dictionaries and return the first dictionary that matches the matchingCriteria
        ///     Candidate for simplifications using Linq, generics etc.
        /// </summary>
        /// <param name="matchingCriteria"></param>
        /// <param name="ListOfDictionaries"></param>
        /// <returns></returns>
        public static Dictionary<string, object> GetDictionaryFromListOfDictionariesByKeyValuePair(
            KeyValuePair<string, object> matchingCriteria, IList<Dictionary<string, object>> ListOfDictionaries)
        {
            var matchingDictionary = new Dictionary<string, object>();
            foreach (var dictionary in ListOfDictionaries)
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
        ///     TODO:- implement differnt matching types
        /// </summary>
        /// <param name="matcher"></param>
        /// <param name="ComparisonMode"></param>
        /// <param name="actualListOfDictionaries"></param>
        /// <returns></returns>
        public static Dictionary<string, object> GetDictionaryFromListOfDictionariesByKeyValuePair(
            KeyValuePair<string, object> matchingCriteria, string ComparisonMode,
            IList<Dictionary<string, object>> ListOfDictionaries)
        {
            var matchingDictionary = new Dictionary<string, object>();
            switch (ComparisonMode)
            {
                case "ContainsListEntry":
                    foreach (var dictionary in ListOfDictionaries)
                    {
                        try
                        {
                            if (dictionary[matchingCriteria.Key].ToString().Split(',').Contains(matchingCriteria.Value))
                            {
                                matchingDictionary = dictionary;
                                break;
                            }
                        }
                        catch (Exception)
                        {
                        }
                    }
                    break;
                default:
                    break;
            }
            return matchingDictionary;
        }

        /// <summary>
        ///     convert the TechTalk.SpecFlow.Table to a list of string,object dictionaries
        ///     equivalent to asMaps() in cucumber-jvm
        /// </summary>
        /// <param name="tableToConvert"></param>
        /// <returns></returns>
        public static IList<IDictionary<string, object>> getTableAsList(Table tableToConvert)
        {
            IList<IDictionary<string, object>> tableAsList = new List<IDictionary<string, object>>();
            var rows = tableToConvert.Rows;
            foreach (var rowRecord in rows)
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

            foreach (var key in results.Keys)
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
            IDictionary<string, object> actualDictionary)
        {
            var diffs = new StringBuilder();
            var actualDictionaryAsDictionary = ConvertIDictionaryToDictionary(actualDictionary);
            foreach (var entry in expectedDictionary)
            {
                //pull all the data out first in case retrieving one or more data parts returns an error and the assertion doesn't take place
                var entryKey = "";
                var expectedValue = "";
                var actualValue = "";
                var comparisonDescription = "";
                try
                {
                    CompareDictionaryEntries(actualDictionaryAsDictionary, entry, ref entryKey, ref expectedValue,
                        ref actualValue, ref comparisonDescription);
                }
                catch (Exception e)
                {
                    comparisonDescription = getComparisonDescription(entryKey, expectedValue, actualValue,
                        comparisonDescription);
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
            var actualDictionaryToObjectDictionary =
                ConvertDictionaryToDictionary(actualDictionary);
            foreach (var entry in expectedDictionary)
            {
                //pull all the data out first in case retrieving one or more data parts returns an error and the assertion doesn't take place
                var entryKey = "";
                var expectedValue = "";
                var actualValue = "";
                var comparisonDescription = "";
                try
                {
                    CompareDictionaryEntries(actualDictionaryToObjectDictionary, entry, ref entryKey, ref expectedValue,
                        ref actualValue, ref comparisonDescription);
                }
                catch (Exception e)
                {
                    comparisonDescription = getComparisonDescription(entryKey, expectedValue, actualValue,
                        comparisonDescription);
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
                var entryKey = "";
                var expectedValue = "";
                var actualValue = "";
                var comparisonDescription = "";
                try
                {
                    if (entry.Key != tableKey)
                    {
                        CompareDictionaryEntries(actualDictionary, entry, ref entryKey, ref expectedValue,
                            ref actualValue, ref comparisonDescription);
                    }
                }
                catch (Exception e)
                {
                    comparisonDescription = getComparisonDescription(entryKey, expectedValue, actualValue,
                        comparisonDescription);
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
            KeyValuePair<string, object> entry, ref string entryKey, ref string expectedValue, ref string actualValue,
            ref string comparisonDescription)
        {
            entryKey = entry.Key;
            expectedValue = entry.Value.ToString();
            actualValue = actualDictionary[entryKey].ToString();
            comparisonDescription = getComparisonDescription(entryKey, expectedValue, actualValue, comparisonDescription);
            try
            {
                Assert.AreEqual(expectedValue, actualValue, comparisonDescription);
            }
            catch (Exception e)
            {
                comparisonDescription = getComparisonDescription(entryKey, expectedValue, actualValue,
                    comparisonDescription);
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
        /// <param name="ExpectedAndActualIDictionariesAsIlIsts"></param>
        /// <returns></returns>
        public static string VerifyTables(ExpectedAndActualIDictionariesAsIlIsts dictionariesAsLists)
        {
            var diffs = new StringBuilder();
            for (var i = 0; i < dictionariesAsLists.Expected.Count - 1; i++)
            {
                try
                {
                    var diff = VerifyTables(dictionariesAsLists.Expected[i], dictionariesAsLists.Actual[i]);
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
        /// <param name="tableAsList"></param>
        /// <param name="testCasesBySuite"></param>
        /// <returns></returns>
        public static string VerifyTables(string tableKey, ExpectedAndActualIDictionariesAsIlIsts dictionariesAsLists)
        {
            var diffs = new StringBuilder();
            var actualListOfDictionaries =
                ConvertIListIDictionaryToIlistDictionary(dictionariesAsLists.Actual);
            foreach (var expectedDictionary in dictionariesAsLists.Expected)
            {
                try
                {
                    var matcher = new KeyValuePair<string, object>(tableKey, expectedDictionary[tableKey]);
                    var actualDictionary =
                        GetDictionaryFromListOfDictionariesByKeyValuePair(matcher, actualListOfDictionaries);
                    var diff = VerifyTables(expectedDictionary, actualDictionary);
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
        /// <param name="ComparisonMode"></param>
        /// <param name="expectedAndActualTestCases"></param>
        /// <returns></returns>
        public static string VerifyTables(string tableKey, string ComparisonMode,
            ExpectedAndActualIDictionariesAsIlIsts dictionariesAsLists)
        {
            var diffs = new StringBuilder();
            var actualListOfDictionaries =
                ConvertIListIDictionaryToIlistDictionary(dictionariesAsLists.Actual);
            foreach (var expectedDictionary in dictionariesAsLists.Expected)
            {
                try
                {
                    var matcher = new KeyValuePair<string, object>(tableKey, expectedDictionary[tableKey]);
                    var actualDictionary =
                        GetDictionaryFromListOfDictionariesByKeyValuePair(matcher, ComparisonMode,
                            actualListOfDictionaries);
                    var diff = VerifyTables(tableKey, expectedDictionary, actualDictionary);
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
            IList<Dictionary<string, object>> convertedIList = new List<Dictionary<string, object>>();
            foreach (var iDict in listOfIDictionaries)
            {
                convertedIList.Add(ConvertIDictionaryToDictionary(iDict));
            }

            return convertedIList;
        }

        public static Dictionary<string, object> ConvertIDictionaryToDictionary(IDictionary<string, object> iDict)
        {
            return iDict.ToDictionary(kvp => kvp.Key, kvp => kvp.Value);
        }

        public static Dictionary<string, object> ConvertDictionaryToDictionary(Dictionary<string, int> Dict)
        {
            return Dict.ToDictionary(kvp => kvp.Key, kvp => (object) kvp.Value);
        }

        private static string getComparisonDescription(string entryKey, string expectedValue, string actualValue,
            string comparisonDescription)
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


    public class IDictionaryAsIlist
    {
        public IList<IDictionary<string, object>> iDictionaryAsIlist { get; set; }
    }
}