namespace Alpari.QA.WMIExtensions.Process
{
    public struct ProcessPriority
    {
        public enum Priority : uint
        {
            Idle = 0x40,
            BelowNormal = 0x4000,
            Normal = 0x20,
            AboveNormal = 0x8000,
            HighPriority = 0x80,
            Realtime = 0x100
        }
    }
}