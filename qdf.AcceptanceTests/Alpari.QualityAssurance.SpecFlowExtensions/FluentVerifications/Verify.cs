using System;
using System.Collections.Generic;
using FluentAssertions;

namespace Alpari.QualityAssurance.SpecFlowExtensions.FluentVerifications
{
    /// <summary>
    ///     Provides a static method (that) for catching the output of Fluent Assertion exceptions to use as verifications
    /// </summary>
    public class Verify
    {
        public static string That(object first, CompareUsing Is, Object second, string message)
        {
            var that = "";
            switch (Is)
            {
                case CompareUsing.ShouldBe:
                    try
                    {
                        first.Should().Be(second, message);
                    }
                    catch (Exception e)
                    {
                        that = e.Message; //.Replace("\\",""); TODO:- properly escape  Fluent Assertion formatting
                    }
                    break;
                case CompareUsing.HaveCount:
                    try
                    {
                        var firstAsEnumerable = first.As<IEnumerable<object>>();
                        firstAsEnumerable.Should().HaveCount((int) (second), message);
                    }
                    catch (Exception e)
                    {
                        that = e.Message; //.Replace("\\",""); TODO:- properly escape  Fluent Assertion formatting
                    }
                    break;
                default:
                    that = String.Format(
                        "unable to compare First value {0} with Second value {1} using comparer Is {2}", first, second,
                        Enum.GetName(typeof (CompareUsing), Is));
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

        public static string That(object first, CompareUsing Is, Object second)
        {
            var that = "";
            switch (Is)
            {
                case CompareUsing.ShouldBe:
                    try
                    {
                        first.Should().Be(second);
                    }
                    catch (Exception e)
                    {
                        that = e.Message;
                            //.Replace("\\",""); TODO:- properly escape  Fluent Assertion formatting                     
                    }
                    break;
                default:
                    that = String.Format(
                        "unable to compare First value {0} with Second value {1} using comparer Is {2}", first, second,
                        Enum.GetName(typeof (CompareUsing), Is));
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