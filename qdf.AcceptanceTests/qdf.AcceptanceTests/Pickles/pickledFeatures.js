jsonPWrapper ([
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
            "WasExecuted": true,
            "WasSuccessful": false
          }
        }
      ],
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