namespace Alpari.QualityAssurance.SpecFlowExtensions.DataContexts
{
    public class AdHocMySqlDataContext : MySqlDataContextSubstitute
    {
        public AdHocMySqlDataContext(string connectionString)
            : base(connectionString)
        {
        }
    }
}