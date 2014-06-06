using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Alpari.QualityAssurance.RefData;

namespace Alpari.QDF.UIClient.App.ControlHelpers
{
    public class EnvironmentControl
    {
        private ReferenceData ReferenceData { get; set; }

        public List<KeyValuePair<string,string>> EnvironmentListItems { get; private set; }

        public EnvironmentControl(ReferenceData referenceData)
        {
            ReferenceData = referenceData;
            EnvironmentListItems = new List<KeyValuePair<string, string>>();
            EnvironmentListItems.AddRange(ReferenceData.RedisServerNameToIpMapping);
        }
    }
}
