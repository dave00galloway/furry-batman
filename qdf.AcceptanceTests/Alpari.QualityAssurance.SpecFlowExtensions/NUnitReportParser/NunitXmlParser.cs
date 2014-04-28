using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Xml;
using Alpari.QualityAssurance.SpecFlowExtensions.LoggingUtilities;

namespace Alpari.QualityAssurance.SpecFlowExtensions.NUnitReportParser
{
    public class NunitXmlParser
    {
        public NunitXmlParser(string path, FileMode mode)
        {
            SetupFileStreamAndXmlReader(path, mode);
            LoadDocumentAndSetRootNode();
        }

        #region relative path constructor oveload

        //was going to overload the constrcutor to allow relative paths, but it was a bit of a specific solution to the problem, so instead the build copies the "Content" of the project (all the "other" files not directly used by the build) to the output folder.
        //  <Target Name="AfterBuild">
        //  <Copy
        //  DestinationFolder="$(OutputPath)\TestData"
        //  SourceFiles="@(Content)"
        //  SkipUnchangedFiles="false"
        //      />
        //</Target>
        //public NunitXmlParser(string fileNamePath, bool isRelative, FileMode fileMode)
        //{
        //    if (isRelative)
        //    {
        //        var assemplyPath = Assembly.GetExecutingAssembly().Location;
        //        //strip off last 2 folders from 
        //        fileNamePath = "";
        //    }

        //    SetupFileStreamAndXmlReader(fileNamePath, fileMode);
        //    loadDocumentAndSetRootNode();  
        //}

        #endregion

        public FileStream FileStream { get; private set; }
        public XmlReader XmlReader { get; private set; }
        public XmlDocument XmlDocument { get; private set; }
        public XmlNode XmlRoot { get; private set; }
        //public string XmlString { get; private set; }
        public ResultType TestResults { get; private set; }

        /// <summary>
        ///     the LAST environmentType node found in the report
        /// </summary>
        public EnvironmentType HostTestEnvironment { get; private set; }

        /// <summary>
        ///     provided so a check can be done on number of envts (should be 1)
        ///     If multiple envts are supported in a single report, then a List"environmentType" will be needed in place of a
        ///     single environmentType property
        /// </summary>
        public XmlNodeList HostTestEnvironmentList { get; private set; }

        /// <summary>
        ///     the LAST cultureinfoType node found in the report
        /// </summary>
        public CultureinfoType CultureinfoType { get; private set; }

        /// <summary>
        ///     provided so a check can be done on number of cultureinfoType (should be 1)
        ///     If multiple CultureinfoTypes are supported in a single report, then a List"CultureinfoType" will be needed in place
        ///     of a single environmentType property
        /// </summary>
        public XmlNodeList CultureinfoTypeList { get; private set; }

        /// <summary>
        ///     List of test suites in the entire TestResults (resultType)
        ///     May need to replace this with String,testSuiteType dictionary, but at the moment there'sno way of guaranteeing a
        ///     unique key - testSuiteType will need a method to build one based on it's ancestry in the TestResult
        /// </summary>
        public List<TestsuiteType> TestSuiteTypeCollection { get; private set; }

        public XmlNodeList TestSuiteTypeList { get; private set; }

        public void SetTestSuiteCollection()
        {
            TestSuiteTypeCollection = ParseAsTestSuiteTypeList();
        }

        public IList<IDictionary<string, object>> GetTestCasesByTestSuiteAsList()
        {
            IList<IDictionary<string, object>> testCasesByTestSuiteAsList = new List<IDictionary<string, object>>();
            foreach (var testSuite in TestSuiteTypeCollection)
            {
                if (testSuite.Type == "TestFixture")
                {
                    foreach (TestcaseType testCase in testSuite.Results.Items)
                    {
                        var testSuiteTestCasesDictionary = new Dictionary<string, object>();
                        testSuiteTestCasesDictionary["Test suite name"] = testSuite.Name;
                        testSuiteTestCasesDictionary["Test case name"] = testCase.Name;
                        testSuiteTestCasesDictionary["Test case short name"] = testCase.Name.Split('.').Last();
                        testSuiteTestCasesDictionary["Executed"] = testCase.Executed;
                        testSuiteTestCasesDictionary["Result"] = testCase.Result;
                        testSuiteTestCasesDictionary["Success"] = testCase.Success;
                        testSuiteTestCasesDictionary["Time"] = testCase.Time;
                        testSuiteTestCasesDictionary["Asserts"] = testCase.Asserts;
                        testSuiteTestCasesDictionary["Tags"] = JoinTags(testCase);
                        AddFailure(testCase, testSuiteTestCasesDictionary);
                        testCasesByTestSuiteAsList.Add(testSuiteTestCasesDictionary);
                    }
                }
            }
            return testCasesByTestSuiteAsList;
        }

        private static void AddFailure(TestcaseType testCase, Dictionary<string, object> testSuiteTestCasesDictionary)
        {
            try
            {
                var failure = (FailureType) testCase.Item;
                testSuiteTestCasesDictionary["Message"] = failure.Message;
                testSuiteTestCasesDictionary["Stack trace"] = failure.Stacktrace;
            }
            catch (Exception e)
            {
                ConsoleLogger.ConsoleExceptionLogger(e);
            }
        }



        private static string JoinTags(TestcaseType testCase)
        {
            var ret = String.Format("@{0}",
                String.Join(",@", testCase.Categories.Select(x => x.Name.Replace('_', '-')).ToArray()));
            return ret;
        }

        private List<TestsuiteType> ParseAsTestSuiteTypeList()
        {
            TestSuiteTypeCollection = new List<TestsuiteType>();
            TestSuiteTypeList = XmlRoot.SelectNodes("//test-suite");
            if (TestSuiteTypeList == null) return TestSuiteTypeCollection;
            foreach (XmlNode testSuiteTypeListItem in TestSuiteTypeList)
            {
                var testSuiteType = new TestsuiteType();
                if (testSuiteTypeListItem.Attributes != null)
                {
                    testSuiteType.Type = testSuiteTypeListItem.Attributes["type"].Value;
                    testSuiteType.Name = testSuiteTypeListItem.Attributes["name"].Value;
                    testSuiteType.Executed = testSuiteTypeListItem.Attributes["executed"].Value;
                    testSuiteType.Result = testSuiteTypeListItem.Attributes["result"].Value;
                    testSuiteType.Success = testSuiteTypeListItem.Attributes["success"].Value;
                    testSuiteType.Time = testSuiteTypeListItem.Attributes["time"].Value;
                    testSuiteType.Asserts = testSuiteTypeListItem.Attributes["asserts"].Value;
                }
                TestSuiteTypeCollection.Add(testSuiteType);
                GetResultsForTestSuite(testSuiteTypeListItem, testSuiteType);
            }
            return TestSuiteTypeCollection;
        }

        private static void GetResultsForTestSuite(XmlNode testSuiteTypeListItem, TestsuiteType testSuiteType)
        {
            try
            {
                if (testSuiteType.Type == "TestFixture")
                {
                    var result = new ResultsType();
                    var resultNode = testSuiteTypeListItem.SelectSingleNode("descendant::results");
                    result.Items = GetTestCasesForResultsItem(resultNode);
                    testSuiteType.Results = result;
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(
                    "Exception thrown while looking for results in testSuite {0}, Exception details {1} {2} {3}",
                    testSuiteType.Name, e.Message, e.Source, e.StackTrace);
                //throw;
            }
        }

        private static object[] GetTestCasesForResultsItem(XmlNode resultNode)
        {
            IList<TestcaseType> testCaseList = new List<TestcaseType>();
            var testCaseNodes = resultNode.SelectNodes("descendant::test-case");
            if (testCaseNodes == null) return testCaseList.Cast<object>().ToArray();
            foreach (XmlNode testCaseNode in testCaseNodes)
            {
                var testCase = new TestcaseType();
                if (testCaseNode.Attributes != null)
                {
                    testCase.Name = testCaseNode.Attributes["name"].Value;
                    testCase.Description = testCaseNode.Attributes["description"].Value;
                    testCase.Success = testCaseNode.Attributes["success"].Value;
                    testCase.Time = testCaseNode.Attributes["time"].Value;
                    testCase.Executed = testCaseNode.Attributes["executed"].Value;
                    testCase.Asserts = testCaseNode.Attributes["asserts"].Value;
                    testCase.Result = testCaseNode.Attributes["result"].Value;
                }
                testCase.Categories = GetTestcaseCategories(testCaseNode);
                testCase.Item = GetTestCaseItem(testCaseNode);
                testCaseList.Add(testCase);
            }

            return testCaseList.Cast<object>().ToArray();
        }

        private static object GetTestCaseItem(XmlNode testCaseNode)
        {
            var itemList = new object();
            var itemNode = testCaseNode.SelectSingleNode("descendant::failure");
            if (itemNode != null)
            {
                var failure = new FailureType();
                var selectSingleNode = itemNode.SelectSingleNode("descendant::message");
                if (selectSingleNode != null)
                    failure.Message = selectSingleNode.InnerText;
                var singleNode = itemNode.SelectSingleNode("descendant::stack-trace");
                if (singleNode != null)
                    failure.Stacktrace = singleNode.InnerText;
                itemList = failure;
            }
            //could potentially be a reasonType added here instead, but ignoring that for now as there aren't any in the current data sets
            return itemList;
        }

        public static XmlNode FindChildNodeByName(XmlNode itemNode, string nodeName)
        {
            for (var i = 0; i < itemNode.ChildNodes.Count; i++)
            {
                if (itemNode.ChildNodes[i].Name == nodeName)
                {
                    return itemNode.ChildNodes[i];
                }
            }
            return null;
        }

        private static CategoryType[] GetTestcaseCategories(XmlNode testCaseNode)
        {
            IList<CategoryType> categoryList = new List<CategoryType>();
            var categoryNodes = testCaseNode.SelectNodes("descendant::category");
            if (categoryNodes != null)
                foreach (XmlNode categoryNode in categoryNodes)
                {
                    var category = new CategoryType();
                    if (categoryNode.Attributes != null) category.Name = categoryNode.Attributes["name"].Value;
                    categoryList.Add(category);
                }
            return categoryList.ToArray();
        }

        public void SetTestResults()
        {
            TestResults = ParseAsTestResults();
        }

        public void SetTestEnvironment()
        {
            HostTestEnvironment = ParseAsHostTestEnvironment();
        }

        public void SetCultureInfo()
        {
            CultureinfoType = ParseAsCultureinfoType();
        }

        private CultureinfoType ParseAsCultureinfoType()
        {
            var cultureinfoType = new CultureinfoType();
            cultureinfoType = GetLastCultureinfoTypeNode(cultureinfoType);
            return cultureinfoType;
        }

        private CultureinfoType GetLastCultureinfoTypeNode(CultureinfoType cultureinfoType)
        {
            CultureinfoTypeList = XmlRoot.SelectNodes("culture-info");
            if (CultureinfoTypeList == null) return cultureinfoType;
            foreach (XmlNode cultureinfoTypeListItem in CultureinfoTypeList)
            {
                var cultureinfoTypeItem = new CultureinfoType();
                var cultureinfoTypeItemAttributes = cultureinfoTypeListItem.Attributes;
                if (cultureinfoTypeItemAttributes != null)
                {
                    cultureinfoTypeItem.Currentculture = cultureinfoTypeItemAttributes["current-culture"].Value;
                    cultureinfoTypeItem.Currentuiculture = cultureinfoTypeItemAttributes["current-uiculture"].Value;
                }
                cultureinfoType = cultureinfoTypeItem;
            }
            return cultureinfoType;
        }

        private EnvironmentType ParseAsHostTestEnvironment()
        {
            var environmentType = new EnvironmentType();
            environmentType = GetLastEnvironmentTypeNode(environmentType);
            return environmentType;
        }

        private EnvironmentType GetLastEnvironmentTypeNode(EnvironmentType environmentType)
        {
            HostTestEnvironmentList = XmlRoot.SelectNodes("//environment");
            if (HostTestEnvironmentList != null)
                foreach (XmlNode hostTestEnvironment in HostTestEnvironmentList)
                {
                    var hostTestEnvironmentType = new EnvironmentType();
                    var hostTestEnvironmentAttributes = hostTestEnvironment.Attributes;
                    if (hostTestEnvironmentAttributes != null)
                    {
                        hostTestEnvironmentType.Nunitversion = hostTestEnvironmentAttributes["nunit-version"].Value;
                        hostTestEnvironmentType.Clrversion = hostTestEnvironmentAttributes["clr-version"].Value;
                        hostTestEnvironmentType.Osversion = hostTestEnvironmentAttributes["os-version"].Value;
                        hostTestEnvironmentType.Platform = hostTestEnvironmentAttributes["platform"].Value;
                        hostTestEnvironmentType.Cwd = hostTestEnvironmentAttributes["cwd"].Value;
                        hostTestEnvironmentType.Machinename = hostTestEnvironmentAttributes["machine-name"].Value;
                        hostTestEnvironmentType.User = hostTestEnvironmentAttributes["user"].Value;
                        hostTestEnvironmentType.Userdomain = hostTestEnvironmentAttributes["user-domain"].Value;
                    }
                    environmentType = hostTestEnvironmentType;
                }
            return environmentType;
        }

        private ResultType ParseAsTestResults()
        {
            var testResults = new ResultType();
            var rootAttributes = XmlRoot.Attributes;
            if (rootAttributes == null) return testResults;
            testResults.Name = rootAttributes["name"].Value;
            testResults.Total = decimal.Parse(rootAttributes["total"].Value);
            testResults.Errors = decimal.Parse(rootAttributes["errors"].Value);
            testResults.Failures = decimal.Parse(rootAttributes["failures"].Value);
            testResults.Notrun = decimal.Parse(rootAttributes["not-run"].Value);
            testResults.Inconclusive = decimal.Parse(rootAttributes["inconclusive"].Value);
            testResults.Ignored = decimal.Parse(rootAttributes["ignored"].Value);
            testResults.Skipped = decimal.Parse(rootAttributes["skipped"].Value);
            testResults.Invalid = decimal.Parse(rootAttributes["invalid"].Value);
            testResults.Date = rootAttributes["date"].Value;
            testResults.Time = rootAttributes["time"].Value;
            return testResults;
        }

        /// <summary>
        ///     Use this to check there is some xml content, but don't use it for vlaidating the content!
        ///     based on
        ///     http://msdn.microsoft.com/en-us/library/xaxy929c.aspx
        /// </summary>
        /// <returns>a string containing some of the xml</returns>
        public string DebugReadXmlAsString()
        {
            var xmlAsString = new StringBuilder();
            while (XmlReader.Read())
            {
                if (XmlReader.IsStartElement())
                {
                    if (XmlReader.IsEmptyElement)
                        xmlAsString.AppendFormat("<{0}/>", XmlReader.Name);
                    else
                    {
                        xmlAsString.AppendFormat("<{0}/>", XmlReader.Name);
                        // Read the start tag. 
                        XmlReader.Read();
                        // Handle nested elements.
                        if (XmlReader.IsStartElement())
                            xmlAsString.AppendFormat("<{0}/>", XmlReader.Name);
                        //Read the text content of the element.
                        xmlAsString.AppendFormat(XmlReader.ReadString());
                    }
                }
            }
            return xmlAsString.ToString();
        }

        private void SetupFileStreamAndXmlReader(string path, FileMode mode)
        {
            FileStream = new FileStream(path, mode);
            XmlReader = XmlReader.Create(FileStream);
        }

        private void SetXmlDocument()
        {
            XmlDocument = new XmlDocument();
            XmlDocument.Load(XmlReader);
            XmlReader.Close();
            FileStream.Close();
        }

        private void SetXmlRoot()
        {
            XmlRoot = XmlDocument.DocumentElement;
        }

        private void LoadDocumentAndSetRootNode()
        {
            SetXmlDocument();
            SetXmlRoot();
        }

        #region obsolete code

        //public NunitXmlParser(string path, FileMode mode)
        //{
        //    SetupFileStreamAndXmlReader(path, mode);
        //    //xmlString = DebugReadXmlAsString(); //doing this in constructor locks the file for loading. need a different constructor, but at this point its not worth it. 
        //    loadDocumentAndSetRootNode();
        //}

        //[Obsolete("unfortuantely doesn't work, and since the xsd is very complex, it would take a lot of effort to fix!")]
        //public NunitXmlParser(string path, FileMode mode, Type type)
        //{
        //    SetupFileStreamAndXmlReader(path, mode);
        //    SetXmlSerializerType(type);
        //}

        //[Obsolete("unfortuantely doesn't work, and since the xsd is very complex, it would take a lot of effort to fix!")]
        //public XmlSerializer xmlSerializer { get; private set; }

        //[Obsolete("unfortuantely doesn't work, and since the xsd is very complex, it would take a lot of effort to fix!")]
        //public void SetXmlSerializerType(Type type)
        //{
        //    xmlSerializer = new XmlSerializer(type);
        //}

        //public resultType ParseAsTestResults()
        //{
        //    // unfortuantely doesn't work, and since the xsd is very complex, it would take a lot of effort to fix!
        //    //return (TestResults)xmlSerializer.Deserialize(xmlReader);

        //    resultType TestResults = new resultType();
        //    XmlAttributeCollection rootAttributes = xmlRoot.Attributes;
        //    TestResults.name = rootAttributes["name"].Value;
        //    return TestResults;
        //}

        ///// <summary>
        ///// attempt at using the built in Nunit Schema rather than the Visual Studio generated one
        ///// </summary>
        ///// <returns></returns>
        //public resultType ParseAsNUnitSchemaTestResults()
        //{
        //    xmlSerializer = new XmlSerializer(typeof(resultType));
        //    //throw new NotImplementedException();
        //    return (resultType)xmlSerializer.Deserialize(xmlReader);
        //}

        #endregion
    }
}