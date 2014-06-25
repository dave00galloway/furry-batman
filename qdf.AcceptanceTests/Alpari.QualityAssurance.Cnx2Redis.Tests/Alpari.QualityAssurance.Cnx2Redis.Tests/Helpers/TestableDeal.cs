using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Alpari.QDF.Domain;

namespace Alpari.QualityAssurance.Cnx2Redis.Tests.Helpers
{
    /// <summary>
    /// class extending Deal which will allow invalid values to be stored so they can be compared and shown to be incorrect rather than throwing an exception while being populated with incorect data
    /// </summary>
    public class TestableDeal :Deal
    {
        public new TestableSide  Side { get; set; }
    }
}
