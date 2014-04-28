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
            loadDocumentAndSetRootNode();
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

        public FileStream fileStream { get; private set; }
        public XmlReader xmlReader { get; private set; }
        public XmlDocument xmlDocument { get; private set; }
        public XmlNode xmlRoot { get; private set; }
        public string xmlString { get; private set; }
        public resultType TestResults { get; private set; }

        /// <summary>
        ///     the LAST environmentType node found in the report
        /// </summary>
        public environmentType HostTestEnvironment { get; private set; }

        /// <summary>
        ///     provided so a check can be done on number of envts (should be 1)
        ///     If multiple envts are supported in a single report, then a List"environmentType" will be needed in place of a
        ///     single environmentType property
        /// </summary>
        public XmlNodeList HostTestEnvironmentList { get; private set; }

        /// <summary>
        ///     the LAST cultureinfoType node found in the report
        /// </summary>
        public cultureinfoType CultureinfoType { get; private set; }

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
            foreach (testsuiteType testSuite in TestSuiteTypeCollection)
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
                        addFailure(testCase, testSuiteTestCasesDictionary);
                        testCasesByTestSuiteAsList.Add(testSuiteTestCasesDictionary);
                    }
                }
            }
            return testCasesByTestSuiteAsList;
        }

        private static void addFailure(testcaseType testCase, Dictionary<string, object> testSuiteTestCasesDictionary)
        {
            try
            {
                var failure = new failureType();
                failure = (failureType) testCase.Item;
                testSuiteTestCasesDictionary["message"] = failure.message;
                testSuiteTestCasesDictionary["stack trace"] = failure.stacktrace;
            }
            catch (Exception)
            {
            }
        }

        private static string JoinTags(testcaseType testCase)
        {
            string ret = String.Format("@{0}",
                String.Join(",@", testCase.categories.Select(x => x.name.Replace('_', '-')).ToArray()));
            return ret;
        }

        private List<testsuiteType> ParseAsTestSuiteTypeList()
        {
            TestSuiteTypeCollection = new List<testsuiteType>();
            TestSuiteTypeList = xmlRoot.SelectNodes("//test-suite");
            foreach (XmlNode TestSuiteTypeListItem in TestSuiteTypeList)
            {
                var testSuiteType = new testsuiteType();
                testSuiteType.type = TestSuiteTypeListItem.Attributes["type"].Value;
                testSuiteType.name = TestSuiteTypeListItem.Attributes["name"].Value;
                testSuiteType.executed = TestSuiteTypeListItem.Attributes["executed"].Value;
                testSuiteType.result = TestSuiteTypeListItem.Attributes["result"].Value;
                testSuiteType.success = TestSuiteTypeListItem.Attributes["success"].Value;
                testSuiteType.time = TestSuiteTypeListItem.Attributes["time"].Value;
                testSuiteType.asserts = TestSuiteTypeListItem.Attributes["asserts"].Value;
                TestSuiteTypeCollection.Add(testSuiteType);
                getResultsForTestSuite(TestSuiteTypeListItem, testSuiteType);
            }
            return TestSuiteTypeCollection;
        }

        private static void getResultsForTestSuite(XmlNode TestSuiteTypeListItem, testsuiteType testSuiteType)
        {
            try
            {
                if (testSuiteType.type == "TestFixture")
                {
                    var Result = new resultsType();
                    XmlNode resultNode = TestSuiteTypeListItem.SelectSingleNode("descendant::results");
                    Result.Items = getTestCasesForResultsItem(resultNode);
                    testSuiteType.results = Result;
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

        private static object[] getTestCasesForResultsItem(XmlNode resultNode)
        {
            IList<testcaseType> testCaseList = new List<testcaseType>();
            XmlNodeList testCaseNodes = resultNode.SelectNodes("descendant::test-case");
            foreach (XmlNode testCaseNode in testCaseNodes)
            {
                var testCase = new testcaseType();
                //testCase.categories = testCaseNode.Attributes["categories"].Value;
                //private propertyType[] propertiesField;
                //private object itemField;
                testCase.name = testCaseNode.Attributes["name"].Value;
                testCase.description = testCaseNode.Attributes["description"].Value;
                testCase.success = testCaseNode.Attributes["success"].Value;
                testCase.time = testCaseNode.Attributes["time"].Value;
                testCase.executed = testCaseNode.Attributes["executed"].Value;
                testCase.asserts = testCaseNode.Attributes["asserts"].Value;
                testCase.result = testCaseNode.Attributes["result"].Value;
                testCase.categories = getTestcaseCategories(testCaseNode);
                testCase.Item = getTestCaseItem(testCaseNode);
                testCaseList.Add(testCase);
            }

            return testCaseList.Cast<object>().ToArray();
        }

        private static object getTestCaseItem(XmlNode testCaseNode)
        {
            var itemList = new object();
            XmlNode itemNode = testCaseNode.SelectSingleNode("descendant::failure");
            if (itemNode != null)
            {
                var failure = new failureType();
                failure.message = itemNode.SelectSingleNode("descendant::message").InnerText;
                failure.stacktrace = itemNode.SelectSingleNode("descendant::stack-trace").InnerText;
                itemList = failure;
            }
            //could potentially be a reasonType added here instead, but ignoring that for now as there aren't any in the current data sets
            return itemList;
        }

        private static XmlNode findChildNodeByName(XmlNode itemNode, string nodeName)
        {
            for (int i = 0; i < itemNode.ChildNodes.Count; i++)
            {
                if (itemNode.ChildNodes[i].Name == nodeName)
                {
                    return itemNode.ChildNodes[i];
                }
            }
            return null;
        }

        private static categoryType[] getTestcaseCategories(XmlNode testCaseNode)
        {
            IList<categoryType> categoryList = new List<categoryType>();
            XmlNodeList categoryNodes = testCaseNode.SelectNodes("descendant::category");
            foreach (XmlNode categoryNode in categoryNodes)
            {
                var category = new categoryType();
                category.name = categoryNode.Attributes["name"].Value;
                categoryList.Add(category);
            }
            return categoryList.Cast<categoryType>().ToArray();
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

        private cultureinfoType ParseAsCultureinfoType()
        {
            var CultureinfoType = new cultureinfoType();
            CultureinfoType = getLastCultureinfoTypeNode(CultureinfoType);
            return CultureinfoType;
        }

        private cultureinfoType getLastCultureinfoTypeNode(cultureinfoType CultureinfoType)
        {
            CultureinfoTypeList = xmlRoot.SelectNodes("culture-info");
            foreach (XmlNode cultureinfoTypeListItem in CultureinfoTypeList)
            {
                var cultureinfoTypeItem = new cultureinfoType();
                XmlAttributeCollection cultureinfoTypeItemAttributes = cultureinfoTypeListItem.Attributes;
                cultureinfoTypeItem.currentculture = cultureinfoTypeItemAttributes["current-culture"].Value;
                cultureinfoTypeItem.currentuiculture = cultureinfoTypeItemAttributes["current-uiculture"].Value;
                CultureinfoType = cultureinfoTypeItem;
            }
            return CultureinfoType;
        }

        private environmentType ParseAsHostTestEnvironment()
        {
            var EnvironmentType = new environmentType();
            EnvironmentType = getLastEnvironmentTypeNode(EnvironmentType);
            return EnvironmentType;
        }

        private environmentType getLastEnvironmentTypeNode(environmentType EnvironmentType)
        {
            HostTestEnvironmentList = xmlRoot.SelectNodes("//environment");
            foreach (XmlNode hostTestEnvironment in HostTestEnvironmentList)
            {
                var hostTestEnvironmentType = new environmentType();
                XmlAttributeCollection hostTestEnvironmentAttributes = hostTestEnvironment.Attributes;
                hostTestEnvironmentType.nunitversion = hostTestEnvironmentAttributes["nunit-version"].Value;
                hostTestEnvironmentType.clrversion = hostTestEnvironmentAttributes["clr-version"].Value;
                hostTestEnvironmentType.osversion = hostTestEnvironmentAttributes["os-version"].Value;
                hostTestEnvironmentType.platform = hostTestEnvironmentAttributes["platform"].Value;
                hostTestEnvironmentType.cwd = hostTestEnvironmentAttributes["cwd"].Value;
                hostTestEnvironmentType.machinename = hostTestEnvironmentAttributes["machine-name"].Value;
                hostTestEnvironmentType.user = hostTestEnvironmentAttributes["user"].Value;
                hostTestEnvironmentType.userdomain = hostTestEnvironmentAttributes["user-domain"].Value;
                EnvironmentType = hostTestEnvironmentType;
            }
            return EnvironmentType;
        }

        private resultType ParseAsTestResults()
        {
            var TestResults = new resultType();
            XmlAttributeCollection rootAttributes = xmlRoot.Attributes;
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
            while (xmlReader.Read())
            {
                if (xmlReader.IsStartElement())
                {
                    if (xmlReader.IsEmptyElement)
                        xmlAsString.AppendFormat("<{0}/>", xmlReader.Name);
                    else
                    {
                        xmlAsString.AppendFormat("<{0}/>", xmlReader.Name);
                        // Read the start tag. 
                        xmlReader.Read();
                        // Handle nested elements.
                        if (xmlReader.IsStartElement())
                            xmlAsString.AppendFormat("<{0}/>", xmlReader.Name);
                        //Read the text content of the element.
                        xmlAsString.AppendFormat(xmlReader.ReadString());
                    }
                }
            }
            return xmlAsString.ToString();
        }

        private void SetupFileStreamAndXmlReader(string path, FileMode mode)
        {
            fileStream = new FileStream(path, mode);
            xmlReader = XmlReader.Create(fileStream);
        }

        private void setXmlDocument()
        {
            xmlDocument = new XmlDocument();
            xmlDocument.Load(xmlReader);
            xmlReader.Close();
            fileStream.Close();
        }

        private void setXmlRoot()
        {
            xmlRoot = xmlDocument.DocumentElement;
        }

        private void loadDocumentAndSetRootNode()
        {
            setXmlDocument();
            setXmlRoot();
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