using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using Alpari.QDF.Domain;

namespace CompareCnxHubCsvWithRedisCnxDeals.Helpers
{
    public class CnxHubDealQdfDealReconciler
    {
        private List<Deal> RetrievedDeals { get; set; }
        private List<CnxHubDeal> CnxHubDealList { get; set; }
        public List<CnxHubDeal> MissingCnxHubDeals { get; set; }
        public List<string> CnxTradeIdList { get; private set; }
        public List<string> CnxTradeIdListDistinct { get; private set; }
        public List<string> QdfDealIdList { get; private set; }
        public List<string> QdfDealIdListDistinct { get; private set; }

        public CnxHubDealQdfDealReconciler(List<Deal> retrievedDeals, List<CnxHubDeal> cnxHubDealList)
        {
            RetrievedDeals = retrievedDeals;
            CnxHubDealList = cnxHubDealList;
            CnxTradeIdList = (from CnxHubDeal cnxDeal in CnxHubDealList
                              select cnxDeal.TradeID).ToList();

            CnxTradeIdListDistinct = CnxTradeIdList.Distinct().ToList();

            QdfDealIdList = (from Deal deal in RetrievedDeals
                             select deal.DealId).ToList();

            QdfDealIdListDistinct = QdfDealIdList.Distinct().ToList();
        }

        public void Compare()
        {
            MissingCnxHubDeals = FindMissingCnxDeals();
        }

        private List<CnxHubDeal> FindMissingCnxDeals()
        {
            var missingCnxDealIds = CnxTradeIdListDistinct.Except(QdfDealIdListDistinct);
            return CnxHubDealList.Where(cnxDeal => missingCnxDealIds.Contains(cnxDeal.TradeID)).ToList();
        }
    }
}
