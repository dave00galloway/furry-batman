using System;
using System.Collections.Generic;
using Alpari.QDF.Domain;

namespace Alpari.QDF.UIClient.App.QueryableEntities
{
    public interface ISearchCriteria
    {
        char Separator { get; set; }
        DateTime ConvertedStartTime { get; set; }
        DateTime ConvertedEndTime { get; set; }

        string Instrument { get; set; }
        List<string> InstrumentList { get; set; }

        /// <summary>
        ///     Synonym for Instrument
        /// </summary>
        string Symbol { get; set; }

        /// <summary>
        ///     run through the properties that have been passed and use logic to set up additional properties, e.g. Lists
        /// </summary>
        void Resolve();

        void SetupSymbols();
    }
}