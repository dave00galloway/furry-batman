using qdf.AcceptanceTests.DataContexts;
using qdf.AcceptanceTests.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace qdf.AcceptanceTests.Steps
{
    [Binding]
    public class QdfAnalysisOfArsCcEcnDiffDeltasStepBase :StepCentral
    {

        public static readonly string FullName = typeof(QdfAnalysisOfArsCcEcnDiffDeltasStepBase).FullName;
        protected SignalsCompareDataDataContext SignalsCompareDataDataContext { get; private set; }
        protected DiffDeltaParameters DiffDeltaParameters { get; set; }
        protected List<DiffDeltaParameters> DiffDeltaParameterList { get; set; }
        protected DiffDeltaFinder DiffDeltaFinder { get; set; }    

        public QdfAnalysisOfArsCcEcnDiffDeltasStepBase(SignalsCompareData signalsCompareData, DiffDeltaFinder diffDeltaFinder)
        {
            DiffDeltaFinder = diffDeltaFinder;
            SignalsCompareDataDataContext = signalsCompareData.SignalsCompareDataDataContext;
        }

        [StepArgumentTransformation]
        public static DiffDeltaParameters DiffDeltaParametersTransform(Table table)
        {
            return table.CreateInstance<DiffDeltaParameters>();
        }

        [StepArgumentTransformation]
        public List<DiffDeltaParameters> DiffDeltaParametersListTransform(Table table)
        {
            //get distict combinations of data
            //select distinct
            //cd.Book,
            //cd.Symbol,
            //cd.Server
            //from CompareData cd
            //where cd.TimeStamp >= '03-Feb-2014'
            //and cd.TimeStamp < '09-Mar-2014'
            //order by cd.Server, cd.Book, cd.Symbol
            var start = table.Rows.First()["StartDate"];
            var startDate = Convert.ToDateTime(start);
            var end = table.Rows.First()["EndDate"];
            var endDate = Convert.ToDateTime(end);
            var distinctCombosQuery =
                SignalsCompareDataDataContext.CompareDatas.Where(
                    cd => cd.TimeStamp >= startDate &&
                               cd.TimeStamp < endDate
                    )
                    .Select(cd => new {cd.Book, cd.Symbol, cd.Server})
                    .Distinct().OrderBy(cd=> cd.Server).ThenBy(cd=>cd.Book).ThenBy(cd=>cd.Symbol);
            var returnTable = new Table(new[] { "Book", "Symbol" ,"Server" ,"StartDate","EndDate","NumberOfDiffs" });
            foreach (var combo in distinctCombosQuery)
            {
                returnTable.AddRow(new[] { combo.Book, combo.Symbol, combo.Server, start, end, table.Rows.First()["NumberOfDiffs"] });
            }

            //return data
            return returnTable.CreateSet<DiffDeltaParameters>().ToList();
        }
    }
}
