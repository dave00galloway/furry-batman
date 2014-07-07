using Alpari.QDF.Domain;

namespace Alpari.QDF.UIClient.App.QueryableEntities
{
    /// <summary>
    /// class extending Deal which will allow invalid values to be stored so they can be compared and shown to be incorrect rather than throwing an exception while being populated with incorect data
    /// </summary>
    public class TestableDeal :Deal
    {
        public new TestableSide  Side { get; set; }
    }
}
