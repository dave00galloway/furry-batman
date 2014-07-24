using System.Collections.Generic;

namespace Alpari.QA.Six06Console.Tests.DomainObjects
{
    public class OrderEventIdToDealMapping
    {
        public OrderEventIdToDealMapping(Dictionary<int, OrderDealMapping> dictionary)
        {
            Dictionary = dictionary;
        }

        public Dictionary<int, OrderDealMapping> Dictionary { get; private set; }

        public static OrderEventIdToDealMapping Create()
        {
            return new OrderEventIdToDealMapping(new Dictionary<int, OrderDealMapping>());
        }
    }
}