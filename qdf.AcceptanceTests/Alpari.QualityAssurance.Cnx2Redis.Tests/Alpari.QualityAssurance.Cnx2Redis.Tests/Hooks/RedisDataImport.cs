using System;
using System.Collections.Generic;
using Alpari.QDF;
using Alpari.QDF.Domain;
using Alpari.QualityAssurance.SpecFlowExtensions.FileUtilities;
using BookSleeve;

namespace Alpari.QualityAssurance.Cnx2Redis.Tests.Hooks
{
    /// <summary>
    /// todo:- move to Alpari.QDF.UIClient.App ?
    /// </summary>
    public class RedisDataImport
    {
        public RedisConnection RedisConnection { get; set; }
        //@deal:cnx_deal:TestData\cnx.csv
        public string DataType { get; private set; }
        public string Key { get; private set; }
        public string FileNamePath { get; private set; }
       
        public RedisDataImport(string tag,RedisConnection redisConnection, char seperator = ':')
        {
            RedisConnection = redisConnection;
            var tagData = tag.Split(seperator);
            DataType = tagData[(int) RedisDataImportParams.DataType];
            Key = tagData[(int)RedisDataImportParams.Key].Replace('_','-');
            FileNamePath = tagData[(int)RedisDataImportParams.FileNamePath];
        }

        public void ImportData()
        {
            //Type type;
            switch (DataType)
            {
                case "deal":
                case "Deal":
                    //type = typeof (Deal);
                    SaveDeals(FileNamePath.CsvToList<Deal>(",",new []{"Data"}));
                    break;
                //case "quote": // complicated as there arenow 2 quote types, so do this later
                default:
                    throw new ArgumentException("{0} Not a valid data type", DataType);
            }
        }

        private void SaveDeals(ICollection<Deal> deals)
        {
            var dataStore = new RedisDataStore(RedisConnection, new SortedSetBasedStorageStrategy(RedisConnection, new JsonSerializer()));
            dataStore.Save(Key, deals, TimeSlice.Day);
            deals.Clear();
        }

        //private void SaveDeals()
        //{
        //    throw new NotImplementedException();
        //}
    }

    public enum RedisDataImportParams
    {
        DataType = 0,
        Key = 1,
        FileNamePath = 2

    }
}