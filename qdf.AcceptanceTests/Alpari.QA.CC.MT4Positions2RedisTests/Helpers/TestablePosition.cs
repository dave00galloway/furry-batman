using System;
using Alpari.CC.WebPortal.DAL.Repositories.Redis;
using Newtonsoft.Json;

namespace Alpari.QA.CC.MT4Positions2RedisTests.Helpers
{
    /// <summary>
    ///     Not currently needed as the JSON format has been fixed
    /// </summary>
    public class TestablePosition
    {
        public TestablePosition()
        {
        }

        public TestablePosition(Position position)
        {
            Book = position.Book;
            Cmd = position.Cmd;
            Comment = position.Comment;
            Group = position.Group;
            Login = position.Login;
            OpenPrice = position.OpenPrice;
            //OpenTime = position.OpenTime.ConvertUnixTimeStampAsSeconds() ?? new DateTime();
            Order = position.Order;
            Server = position.Server;
            Sl = position.Sl;
            Status = position.Status;
            Symbol = position.Symbol;
            //Timestamp = position.Timestamp.ConvertUnixTimeStampAsSeconds() ?? new DateTime();
            Tp = position.Tp;
            Volume = position.Volume;
        }

        public string Book { get; set; }
        public byte Cmd { get; set; }
        public string Comment { get; set; }
        public string Group { get; set; }
        public int Login { get; set; }

        [JsonProperty(PropertyName = "open_price")]
        public decimal OpenPrice { get; set; }

        [JsonProperty(PropertyName = "open_time")]
        public DateTime OpenTime { get; set; }

        public int Order { get; set; }
        public string Server { get; set; }
        public decimal Sl { get; set; }
        public string Status { get; set; }
        public string Symbol { get; set; }
        public DateTime Timestamp { get; set; }
        public decimal Tp { get; set; }
        public decimal Volume { get; set; }
    }
}