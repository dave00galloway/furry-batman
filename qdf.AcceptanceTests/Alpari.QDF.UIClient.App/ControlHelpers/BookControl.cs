using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Alpari.QDF.Domain;
using Alpari.QualityAssurance.SpecFlowExtensions.TypeUtilities;

namespace Alpari.QDF.UIClient.App.ControlHelpers
{
    public class BookControl
    {
        public List<string> BookList { get; set; }

        public BookControl()
        {
            BookList = new List<string>();
            var values = EnumExtensions.GetValues<Book>();
            foreach (var book in values)
            {
                BookList.Add(book.ToString());
            }
            BookList.Sort();
        }
    }
}
