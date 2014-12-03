using Alpari.QA.Six06Console.Tests.DomainObjects;
using Alpari.QualityAssurance.SpecFlowExtensions.LoggingUtilities;
using System;
using System.Collections.Generic;
using TechTalk.SpecFlow;

namespace Alpari.QA.Six06Console.Tests.Steps
{
    [Binding]
    public class Six06ConsoleAppStepBase : StepCentral
    {
        public new static readonly string FullName = typeof (Six06ConsoleAppStepBase).FullName;
        private Dictionary<int, OrderDealMapping> _orderEventIdToDealMapping;
        

        public Six06ConsoleAppStepBase()
        {
            
        }

        public IDictionary<int, OrderDealMapping> OrderEventIdToDealMapping
        {
            get {
                return _orderEventIdToDealMapping ??
                       (_orderEventIdToDealMapping = DomainObjects.OrderEventIdToDealMapping.Create().Dictionary);
            }
        }

        protected void ParseStandardErrorOutputToOrderDealMapping()
        {
            var rawOutput = LaunchProcessSteps.ProcessRunner.StandardErrorOutputList;
            var orderEventDelimiter = Convert.ToChar(ORDER_EVENT_ID_DELIMITER);
            foreach (var line in rawOutput)
            {
                try
                {
                    if (!line.Contains(ORDER_EVENT_ID_DELIMITER)) continue;
                    var elements = line.Split(orderEventDelimiter);
                    var orderEventId = Convert.ToInt32(elements[0].Trim());
                    elements = elements[1].Split(ORDER_DEAL_DELIMITER);
                    var orderId = Convert.ToInt64(elements[0].Trim().Replace(ORDER_IDENTIFIER, ""));
                    var dealId = Convert.ToInt64(elements[1].Trim().Replace(ORDER_DEAL_TERMINATOR, ""));
                    OrderEventIdToDealMapping.Add(orderEventId,
                        new OrderDealMapping {Deal = dealId, Order = orderId});
                }
                catch (Exception e)
                {
                    e.ConsoleExceptionLogger(
                        String.Format("unable to parse line {0} into order event, order and deal ids", line));
                }
            }
        }
    }
}