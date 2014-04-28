using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Xml;

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
        public string XmlString { get; private set; }
        public resultType TestResults { get; private set; }

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
        public List<testsuiteType> TestSuiteTypeCollection { get; private set; }

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
                if (testSuite.type == "TestFixture")
                {
                    foreach (testcaseType testCase in testSuite.results.Items)
                    {
                        var testSuiteTestCasesDictionary = new Dictionary<string, object>();
                        testSuiteTestCasesDictionary["test suite name"] = testSuite.name;
                        testSuiteTestCasesDictionary["test case name"] = testCase.name;
                        testSuiteTestCasesDictionary["test case short name"] = testCase.name.Split('.').Last();
                        testSuiteTestCasesDictionary["executed"] = testCase.executed;
                        testSuiteTestCasesDictionary["result"] = testCase.result;
                        testSuiteTestCasesDictionary["success"] = testCase.success;
                        testSuiteTestCasesDictionary["time"] = testCase.time;
                        testSuiteTestCasesDictionary["asserts"] = testCase.asserts;
                        testSuiteTestCasesDictionary["tags"] = JoinTags(testCase);
                        AddFailure(testCase, testSuiteTestCasesDictionary);
                        testCasesByTestSuiteAsList.Add(testSuiteTestCasesDictionary);
                    }
                }
            }
            return testCasesByTestSuiteAsList;
        }

        private static void AddFailure(testcaseType testCase, Dictionary<string, object> testSuiteTestCasesDictionary)
        {
            try
            {
                var failure = new FailureType();
                failure = (FailureType) testCase.Item;
                testSuiteTestCasesDictionary["message"] = failure.Message;
                testSuiteTestCasesDictionary["stack trace"] = failure.Stacktrace;
            }
            catch (Exception)
            {
            }
        }

        private static string JoinTags(testcaseType testCase)
        {
            var ret = String.Format("@{0}",
                String.Join(",@", testCase.categories.Select(x => x.Name.Replace('_', '-')).ToArray()));
            return ret;
        }

        private List<testsuiteType> ParseAsTestSuiteTypeList()
        {
            TestSuiteTypeCollection = new List<testsuiteType>();
            TestSuiteTypeList = XmlRoot.SelectNodes("//test-suite");
            if (TestSuiteTypeList == null) return TestSuiteTypeCollection;
            foreach (XmlNode testSuiteTypeListItem in TestSuiteTypeList)
            {
                var testSuiteType = new testsuiteType();
                if (testSuiteTypeListItem.Attributes != null)
                {
                    testSuiteType.type = testSuiteTypeListItem.Attributes["type"].Value;
                    testSuiteType.name = testSuiteTypeListItem.Attributes["name"].Value;
                    testSuiteType.executed = testSuiteTypeListItem.Attributes["executed"].Value;
                    testSuiteType.result = testSuiteTypeListItem.Attributes["result"].Value;
                    testSuiteType.success = testSuiteTypeListItem.Attributes["success"].Value;
                    testSuiteType.time = testSuiteTypeListItem.Attributes["time"].Value;
                    testSuiteType.asserts = testSuiteTypeListItem.Attributes["asserts"].Value;
                }
                TestSuiteTypeCollection.Add(testSuiteType);
                GetResultsForTestSuite(testSuiteTypeListItem, testSuiteType);
            }
            return TestSuiteTypeCollection;
        }

        private static void GetResultsForTestSuite(XmlNode testSuiteTypeListItem, testsuiteType testSuiteType)
        {
            try
            {
                if (testSuiteType.type == "TestFixture")
                {
                    var result = new resultsType();
                    var resultNode = testSuiteTypeListItem.SelectSingleNode("descendant::results");
                    result.Items = GetTestCasesForResultsItem(resultNode);
                    testSuiteType.results = result;
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(
                    "Exception thrown while looking for results in testSuite {0}, Exception details {1} {2} {3}",
                    testSuiteType.name, e.Message, e.Source, e.StackTrace);
                //throw;
            }
        }

        private static object[] GetTestCasesForResultsItem(XmlNode resultNode)
        {
            IList<testcaseType> testCaseList = new List<testcaseType>();
            var testCaseNodes = resultNode.SelectNodes("descendant::test-case");
            if (testCaseNodes == null) return testCaseList.Cast<object>().ToArray();
            foreach (XmlNode testCaseNode in testCaseNodes)
            {
                var testCase = new testcaseType();
                if (testCaseNode.Attributes != null)
                {
                    testCase.name = testCaseNode.Attributes["name"].Value;
                    testCase.description = testCaseNode.Attributes["description"].Value;
                    testCase.success = testCaseNode.Attributes["success"].Value;
                    testCase.time = testCaseNode.Attributes["time"].Value;
                    testCase.executed = testCaseNode.Attributes["executed"].Value;
                    testCase.asserts = testCaseNode.Attributes["asserts"].Value;
                    testCase.result = testCaseNode.Attributes["result"].Value;
                }
                testCase.categories = GetTestcaseCategories(testCaseNode);
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

        private static XmlNode FindChildNodeByName(XmlNode itemNode, string nodeName)
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
            return categoryList.Cast<CategoryType>().ToArray();
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
            foreach (XmlNode cultureinfoTypeListItem in CultureinfoTypeList)
            {
                var cultureinfoTypeItem = new CultureinfoType();
                var cultureinfoTypeItemAttributes = cultureinfoTypeListItem.Attributes;
                cultureinfoTypeItem.Currentculture = cultureinfoTypeItemAttributes["current-culture"].Value;
                cultureinfoTypeItem.Currentuiculture = cultureinfoTypeItemAttributes["current-uiculture"].Value;
                cultureinfoType = cultureinfoTypeItem;
            }
            return cultureinfoType;
        }

        private EnvironmentType ParseAsHostTestEnvironment()
        {
            var EnvironmentType = new EnvironmentType();
            EnvironmentType = getLastEnvironmentTypeNode(EnvironmentType);
            return EnvironmentType;
        }

        private EnvironmentType getLastEnvironmentTypeNode(EnvironmentType EnvironmentType)
        {
            HostTestEnvironmentList = XmlRoot.SelectNodes("//environment");
            foreach (XmlNode hostTestEnvironment in HostTestEnvironmentList)
            {
                var hostTestEnvironmentType = new EnvironmentType();
                var hostTestEnvironmentAttributes = hostTestEnvironment.Attributes;
                hostTestEnvironmentType.Nunitversion = hostTestEnvironmentAttributes["nunit-version"].Value;
                hostTestEnvironmentType.Clrversion = hostTestEnvironmentAttributes["clr-version"].Value;
                hostTestEnvironmentType.Osversion = hostTestEnvironmentAttributes["os-version"].Value;
                hostTestEnvironmentType.Platform = hostTestEnvironmentAttributes["platform"].Value;
                hostTestEnvironmentType.Cwd = hostTestEnvironmentAttributes["cwd"].Value;
                hostTestEnvironmentType.Machinename = hostTestEnvironmentAttributes["machine-name"].Value;
                hostTestEnvironmentType.User = hostTestEnvironmentAttributes["user"].Value;
                hostTestEnvironmentType.Userdomain = hostTestEnvironmentAttributes["user-domain"].Value;
                EnvironmentType = hostTestEnvironmentType;
            }
            return EnvironmentType;
        }

        private resultType ParseAsTestResults()
        {
            var TestResults = new resultType();
            var rootAttributes = XmlRoot.Attributes;
            TestResults.name = rootAttributes["name"].Value;
            TestResults.total = decimal.Parse(rootAttributes["total"].Value);
            TestResults.errors = decimal.Parse(rootAttributes["errors"].Value);
            TestResults.failures = decimal.Parse(rootAttributes["failures"].Value);
            TestResults.notrun = decimal.Parse(rootAttributes["not-run"].Value);
            TestResults.inconclusive = decimal.Parse(rootAttributes["inconclusive"].Value);
            TestResults.ignored = decimal.Parse(rootAttributes["ignored"].Value);
            TestResults.skipped = decimal.Parse(rootAttributes["skipped"].Value);
            TestResults.invalid = decimal.Parse(rootAttributes["invalid"].Value);
            TestResults.date = rootAttributes["date"].Value;
            TestResults.time = rootAttributes["time"].Value;
            return TestResults;
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