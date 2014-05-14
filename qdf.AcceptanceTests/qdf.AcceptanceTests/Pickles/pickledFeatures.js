jsonPWrapper ([
  {
    "RelativeFolder": "SelfTests\\ReuseDealReconciliationSteps.feature",
    "Feature": {
      "Name": "ReuseDealReconciliationSteps",
      "Description": "In order to show deal recon steps are inherited from master step base\r\nAs a tester\r\nI want to see methods available between step definition files",
      "FeatureElements": [
        {
          "Name": "reuse the deal recon steps",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Given",
              "NativeKeyword": "Given ",
              "Name": "I have connected to \"MySqlDataContextSubstitute\""
            }
          ],
          "Tags": [
            "@mytag"
          ],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": true
          }
        }
      ],
      "Result": {
        "WasExecuted": true,
        "WasSuccessful": true
      },
      "Tags": []
    },
    "Result": {
      "WasExecuted": true,
      "WasSuccessful": true
    }
  },
  {
    "RelativeFolder": "SelfTests\\MySqlQUickStart.feature",
    "Feature": {
      "Name": "MySqlQUickStart",
      "Description": "In order to access MySql Data\r\nAs a tester\r\nI want a working linq provider",
      "FeatureElements": [
        {
          "Name": "Create connection",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Given",
              "NativeKeyword": "Given ",
              "Name": "I have created a connection to \"MySqlDataContextSubstitute\""
            },
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I retrieve cc_tbl_position_section data from cc"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the cc_tbl_position_section data from cc has 4 records"
            }
          ],
          "Tags": [
            "@SelfTest"
          ],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": true
          }
        }
      ],
      "Result": {
        "WasExecuted": true,
        "WasSuccessful": true
      },
      "Tags": []
    },
    "Result": {
      "WasExecuted": true,
      "WasSuccessful": true
    }
  },
  {
    "RelativeFolder": "SelfTests\\LoadDailySnapshot.feature",
    "Feature": {
      "Name": "LoadDataOnce",
      "Description": "In order to avoid multiple data loads\r\nAs a tester\r\nI want to be to load data once for a feature and have it available for all scenarios",
      "FeatureElements": [
        {
          "Name": "Load Test Data and Check it's there",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "there are 350 deals in AllQdfDeals and 3722 records in CcToolData"
            }
          ],
          "Tags": [
            "@mytag"
          ],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": true
          }
        },
        {
          "Name": "Load Test Data and Check it's there again",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "there are 350 deals in AllQdfDeals and 3722 records in CcToolData"
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": true
          }
        }
      ],
      "Background": {
        "Name": "Load data",
        "Description": "",
        "Steps": [
          {
            "Keyword": "Given",
            "NativeKeyword": "Given ",
            "Name": "I have already loaded QDF deal data from \"TestData\\AllQdfDeals.csv\""
          },
          {
            "Keyword": "And",
            "NativeKeyword": "And ",
            "Name": "I have already loaded CCTool data from \"TestData\\CcToolData.csv\""
          },
          {
            "Keyword": "And",
            "NativeKeyword": "And ",
            "Name": "I have already aggregated the QdfDeal Data and CcToolData"
          }
        ],
        "Tags": [],
        "Result": {
          "WasExecuted": false,
          "WasSuccessful": false
        }
      },
      "Result": {
        "WasExecuted": true,
        "WasSuccessful": true
      },
      "Tags": []
    },
    "Result": {
      "WasExecuted": true,
      "WasSuccessful": true
    }
  },
  {
    "RelativeFolder": "SelfTests\\GetDailySnapshotFromCC.feature",
    "Feature": {
      "Name": "GetDailySnapshotFromCC",
      "Description": "In order to get daily snapshot delatas\r\nAs a Tester\r\nI want to get the nearest snapshot to midday for each position",
      "FeatureElements": [
        {
          "Name": "Get 2 daily snapshots",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Given",
              "NativeKeyword": "Given ",
              "Name": "I have daily ccTool snapshot data from \"-3D\" to \"+2D\""
            }
          ],
          "Tags": [
            "@mytag"
          ],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": true
          }
        }
      ],
      "Result": {
        "WasExecuted": true,
        "WasSuccessful": true
      },
      "Tags": []
    },
    "Result": {
      "WasExecuted": true,
      "WasSuccessful": true
    }
  },
  {
    "RelativeFolder": "SelfTests\\ArsQdfReconciliationWithLoadedFiles.feature",
    "Feature": {
      "Name": "ArsQdfReconciliationWithLoadedFiles",
      "Description": "In order to test the reconciliation functionality\r\nAs a tester\r\nI want to be able to re-use the same input data",
      "FeatureElements": [
        {
          "Name": "Load Test Data and Compare",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Given",
              "NativeKeyword": "Given ",
              "Name": "I have loaded QDF deal data from \"TestData\\AllQdfDeals.csv\""
            },
            {
              "Keyword": "And",
              "NativeKeyword": "And ",
              "Name": "I have loaded CCTool data from \"TestData\\CcToolData.csv\""
            },
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I compare the loaded QDF and CC data"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the data should not match"
            }
          ],
          "Tags": [
            "@mytag"
          ],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": true
          }
        }
      ],
      "Result": {
        "WasExecuted": true,
        "WasSuccessful": true
      },
      "Tags": []
    },
    "Result": {
      "WasExecuted": true,
      "WasSuccessful": true
    }
  },
  {
    "RelativeFolder": "ArsQdfCCReconciliation.feature",
    "Feature": {
      "Name": "Deal Reconciliation",
      "Description": "In Order to have faith in the QDF data \r\nAs a quant user\r\nI want a reconciliation of ARS QDF against CC",
      "FeatureElements": [
        {
          "Name": "Book A Deals for server C1 in symbol EURUSD in QDF should equal CC from 5 minutes ago",
          "Description": "",
          "Steps": [
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I compare QDF and CC data"
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": false
          }
        }
      ],
      "Background": {
        "Name": "Load data",
        "Description": "",
        "Steps": [
          {
            "Keyword": "Given",
            "NativeKeyword": "Given ",
            "Name": "I have already loaded QDF deal data",
            "TableArgument": {
              "HeaderRow": [
                "startTime",
                "endTime"
              ],
              "DataRows": [
                [
                  "-5D",
                  "+4D"
                ]
              ]
            }
          },
          {
            "Keyword": "And",
            "NativeKeyword": "And ",
            "Name": "I have already loaded CCTool data"
          },
          {
            "Keyword": "And",
            "NativeKeyword": "And ",
            "Name": "I have already aggregated the QdfDeal Data and CcToolData by day"
          }
        ],
        "Tags": [],
        "Result": {
          "WasExecuted": false,
          "WasSuccessful": false
        }
      },
      "Result": {
        "WasExecuted": true,
        "WasSuccessful": false
      },
      "Tags": []
    },
    "Result": {
      "WasExecuted": true,
      "WasSuccessful": false
    }
  }
]);