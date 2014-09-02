using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Alpari.CC.WebPortal.DAL.Repositories.Redis;
using Alpari.QualityAssurance.SpecFlowExtensions.StepBases;
using Microsoft.Practices.ObjectBuilder2;

namespace Alpari.QA.CC.MT4Positions2RedisTests.Helpers
{
    public static class TestablePositionExtensions
    {
        public static IList<TestablePosition> ConvertPositionsToTestablePositions(
            this IEnumerable<Position> positions)
        {
            return positions.Select(position => new TestablePosition(position)).ToList();
        }
    }
}
