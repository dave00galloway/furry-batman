namespace qdf.AcceptanceTests.Helpers
{
    public class DiffDeltaSummary
    {
        public string HiSource { get; set; }

        public string LoSource { get; set; }

        public decimal Diff { get; set; }

        public decimal Delta { get; set; }

        public System.DateTime Start { get; set; }

        public System.DateTime End { get; set; }
    }
}