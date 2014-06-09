using System.Collections.Generic;
using Alpari.QDF.Domain;
using Alpari.QDF.UIClient.App;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using FluentAssertions;
using NUnit.Framework;
using TechTalk.SpecFlow;

namespace Alpari.QDF.UIClient.Tests.Steps
{
    [Binding]
    public class OutputToCsvSteps : OutputToCsvStepBase
    {
        public new static readonly string FullName = typeof (OutputToCsvSteps).FullName;

        //public OutputToCsvSteps(Exporter exporter) : base(exporter)
        //{
        //}

        [When(@"I export the data to ""(.*)"" and import the csv")]
        public void WhenIExportTheDataToAndImportTheCsv(string fileNamePath)
        {
            Exporter.ExportDealsToCsv(fileNamePath);
            ImportedDeals = fileNamePath.CsvToList<Deal>(",", new[] {"Data"});
        }

        [When(@"I export the quote data to ""(.*)"" and import the csv")]
        public void WhenIExportTheQuoteDataToAndImportTheCsv(string fileNamePath)
        {
            Exporter.ExportQuotesToCsv(fileNamePath);
            ImportedQuotes = fileNamePath.CsvToList<PriceQuote>(",", new[] { "Data", "Mid" });
        }

        [Then(@"the quotes imported for each symbol will have the following counts")]
        public void ThenTheQuotesImportedForEachSymbolWillHaveTheFollowingCounts(Table table)
        {
            string verificationErrors = GetQuoteVerificationErrorsForSymbolCounts(table);
            Assert.IsEmpty(verificationErrors);
        }


        [Then(@"the deals imported for each symbol will have the following counts")]
        public void ThenTheDealsImportedForEachSymbolWillHaveTheFollowingCounts(Table table)
        {
            string verificationErrors = GetVerificationErrorsForSymbolCounts(table);
            Assert.IsEmpty(verificationErrors);
        }


        [Then(@"the deals imported for each server will have the following counts")]
        public void ThenTheDealsImportedForEachServerWillHaveTheFollowingCounts(Table table)
        {
            string verificationErrors = GetVerificationErrorsForServerCounts(table);
            Assert.IsEmpty(verificationErrors);
        }

        [Then(@"the count of imported deals will be (.*)")]
        public void ThenTheCountOfImportedDealsWillBe(int expectedDealCount)
        {
            ImportedDeals.Should().HaveCount(expectedDealCount);
        }
    }
}