using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Alpari.QA.ProcessRunner;
using TechTalk.SpecFlow;
using TechTalk.SpecFlow.Assist;

namespace Alpari.QA.CC.MT4Positions2RedisTests.Transforms
{
    [Binding]
    public class Mt4TradeExeTransforms
    {
        /// <summary>
        /// Takes the standard Process Start Info args as a table and returns the standard Process Info Start wrapper
        /// TODO:- create a specialised method that defaults known properties to simplify tab;e
        /// TODO:- create a method that returns multiple instances for setting up lots of wrappers at the same time
        /// </summary>
        /// <param name="table"></param>
        /// <returns></returns>
        [StepArgumentTransformation]
        public static ProcessStartInfoWrapper ProcessStartInfoTransform(Table table)
        {
            return table.CreateInstance<ProcessStartInfoWrapper>();
        }
    }
}
