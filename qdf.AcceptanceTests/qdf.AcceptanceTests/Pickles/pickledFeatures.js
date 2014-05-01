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
              "Keyword": "Given",
              "NativeKeyword": "Given ",
              "Name": "I have QDF Deal Data",
              "TableArgument": {
                "HeaderRow": [
                  "server",
                  "symbol"
                ],
                "DataRows": [
                  [
                    "C1",
                    "EURUSD"
                  ]
                ]
              }
            },
            {
              "Keyword": "And",
              "NativeKeyword": "And ",
              "Name": "I have CC data"
            },
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I compare QDF and CC data"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the data should match"
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": false,
            "WasSuccessful": false
          }
        }
      ],
      "Result": {
        "WasExecuted": false,
        "WasSuccessful": false
      },
      "Tags": []
    },
    "Result": {
      "WasExecuted": false,
      "WasSuccessful": false
    }
  }
]);