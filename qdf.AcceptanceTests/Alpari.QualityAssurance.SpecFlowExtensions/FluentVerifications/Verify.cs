using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using FluentAssertions;

namespace Alpari.QualityAssurance.SpecFlowExtensions.FluentVerifications
{
    /// <summary>
    /// Provides a static method (that) for catching the output of Fluent Assertion exceptions to use as verifications
    /// </summary>
    public class Verify
    {
        public static string That(object First, CompareUsing Is, Object Second, string Message)
        {
            string that = "";
            switch (Is)
            {
                case CompareUsing.SHOULD_BE:
                    try
                    {
                        First.Should().Be(Second,Message);
                    }
                    catch (Exception e)
                    {
                        that = e.Message; //.Replace("\\",""); TODO:- properly escape  Fluent Assertion formatting
                    }
                    break;
                case CompareUsing.HAVE_COUNT:
                    try
                    {
                        var firstAsEnumerable = First.As<IEnumerable<object>>();
                        firstAsEnumerable.Should().HaveCount((int)(Second), Message);
                    }
                    catch (Exception e)
                    {
                        that = e.Message; //.Replace("\\",""); TODO:- properly escape  Fluent Assertion formatting
                    }
                    break;
                default:
                    that = String.Format("unable to compare First value {0} with Second value {1} using comparer Is {2}", First.ToString(), Second.ToString(), Enum.GetName(typeof(CompareUsing), Is));
                    break;
            }
            if (that != "")
            {
                that += " ";
            }

            return that;
        }

        //public static string That(IDictionary<string, object> First, CompareUsing Is, Object Second, string Message)
        //{
        //    string that = "";
        //    switch (Is)
        //    {
        //        case CompareUsing.HAVE_COUNT:
        //            try
        //            {
        //                First.Should().HaveCount((int)(Second), Message);
        //            }
        //            catch (Exception e)
        //            {
        //                that = e.Message; //.Replace("\\",""); TODO:- properly escape  Fluent Assertion formatting
        //            }
        //            break;
        //        default:
        //            that = String.Format("unable to compare First value {0} with Second value {1} using comparer Is {2}", First.ToString(), Second.ToString(), Enum.GetName(typeof(CompareUsing), Is));
        //            break;
        //    }
        //    if (that != "")
        //    {
        //        that += " ";
        //    }

        //    return that;
        //} 

        public static string That(object First, CompareUsing Is, Object Second)
        {
            string that = "";
            switch (Is)
            {
                case CompareUsing.SHOULD_BE:
                    try
                    {
                        First.Should().Be(Second);
                    }
                    catch (Exception e)
                    {
                        that = e.Message; //.Replace("\\",""); TODO:- properly escape  Fluent Assertion formatting                     
                    }
                    break;
                default:
                    that = String.Format("unable to compare First value {0} with Second value {1} using comparer Is {2}", First.ToString(), Second.ToString(), Enum.GetName(typeof(CompareUsing),Is));
                    break;
            }
            if (that != "")
            {
                that += " ";
            }
            return that;
        }

        public static string RemoveCommas(string verificationString)
        {
            if (verificationString.Contains(","))
            {
                //this should work, but due to the FluentAssertion treatment of commas doesn't
                //verificationString = "\"" + verificationString + "\"";
                verificationString = verificationString.Replace(",", " ");
            }
            return verificationString;
        }
      
    }
}
