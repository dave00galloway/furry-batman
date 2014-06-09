using Alpari.QualityAssurance.RefData;
using System.Collections.Generic;

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

        public string GetInitialValue(string redisHost)
        {
            foreach (KeyValuePair<string, string> environmentListItem in EnvironmentListItems)
            {
                if (environmentListItem.Key == redisHost)
                {
                    return environmentListItem.Key;
                }
                if (environmentListItem.Value == redisHost)
                {
                    return environmentListItem.Key;
                }
            }
            return default(string);
        }
    }
}
