using System;

namespace Alpari.QDF.UIClient.App.QueryableEntities
{
    /// <summary>
    /// Class to allow testing of corrupt input data
    /// </summary>
    public class BookLessDeal :TestableDeal
    {
        /// <summary>
        /// overriding Book to allow corrupted book data to be stored
        /// </summary>
        public new String Book { get; set; }
    }
}
