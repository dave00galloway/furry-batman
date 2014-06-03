jsonPWrapper ([
  {
    "RelativeFolder": "QdfDataRetrieval.feature",
    "Feature": {
      "Name": "QdfDataRetrieval",
      "Description": "In order to access deal data in Redis QDF\r\nAs a QDF Analyst\r\nI want a UI to retrieve and filter deal data",
      "FeatureElements": [
        {
          "Name": "Filter deals by date",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Given",
              "NativeKeyword": "Given ",
              "Name": "I have the following search criteria for qdf deals",
              "TableArgument": {
                "HeaderRow": [
                  "ConvertedStartTime",
                  "ConvertedEndTime"
                ],
                "DataRows": [
                  [
                    "05/05/2014  12:45:42",
                    "05/05/2014  12:49:51"
                  ]
                ]
              }
            },
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I retrieve the qdf deal data"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "no retrieved deal will have a timestamp outside \"05/05/2014  12:45:42\" to \"05/05/2014  12:49:51\""
            },
            {
              "Keyword": "And",
              "NativeKeyword": "And ",
              "Name": "the count of retrieved deals will be 101"
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": true
          }
        },
        {
          "Name": "Filter deals by server",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Given",
              "NativeKeyword": "Given ",
              "Name": "I have the following search criteria for qdf deals",
              "TableArgument": {
                "HeaderRow": [
                  "Server",
                  "ConvertedStartTime",
                  "ConvertedEndTime"
                ],
                "DataRows": [
                  [
                    "Mt4Micro2",
                    "05/05/2014  12:45:42",
                    "05/05/2014  12:49:51"
                  ]
                ]
              }
            },
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I retrieve the qdf deal data"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "all retrieved deals will have be for server \"Mt4Micro2\""
            },
            {
              "Keyword": "And",
              "NativeKeyword": "And ",
              "Name": "the count of retrieved deals will be 16"
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": true
          }
        },
        {
          "Name": "Filter deals by multiple servers",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Given",
              "NativeKeyword": "Given ",
              "Name": "I have the following search criteria for qdf deals",
              "TableArgument": {
                "HeaderRow": [
                  "Servers",
                  "ConvertedStartTime",
                  "ConvertedEndTime"
                ],
                "DataRows": [
                  [
                    "Mt4Micro2,Mt4Classic1,Mt4Market1",
                    "05/05/2014  12:45:42",
                    "05/05/2014  12:49:51"
                  ]
                ]
              }
            },
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I retrieve the qdf deal data"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the deals retrieved for each server will have the following counts",
              "TableArgument": {
                "HeaderRow": [
                  "Server",
                  "Count"
                ],
                "DataRows": [
                  [
                    "Mt4Micro2",
                    "16"
                  ],
                  [
                    "Mt4Classic1",
                    "2"
                  ],
                  [
                    "Mt4Market1",
                    "2"
                  ]
                ]
              }
            },
            {
              "Keyword": "And",
              "NativeKeyword": "And ",
              "Name": "the count of retrieved deals will be 20"
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": true
          }
        },
        {
          "Name": "Filter deals by symbol",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Given",
              "NativeKeyword": "Given ",
              "Name": "I have the following search criteria for qdf deals",
              "TableArgument": {
                "HeaderRow": [
                  "Symbol",
                  "ConvertedStartTime",
                  "ConvertedEndTime"
                ],
                "DataRows": [
                  [
                    "EURUSD",
                    "05/05/2014  12:45:42",
                    "05/05/2014  12:49:51"
                  ]
                ]
              }
            },
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I retrieve the qdf deal data"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "all retrieved deals will have be for symbol \"EURUSD\""
            },
            {
              "Keyword": "And",
              "NativeKeyword": "And ",
              "Name": "the count of retrieved deals will be 32"
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": true
          }
        },
        {
          "Name": "Filter deals by multiple symbols",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Given",
              "NativeKeyword": "Given ",
              "Name": "I have the following search criteria for qdf deals",
              "TableArgument": {
                "HeaderRow": [
                  "Symbol",
                  "ConvertedStartTime",
                  "ConvertedEndTime"
                ],
                "DataRows": [
                  [
                    "EURUSD,NZDUSD,AUDNZD",
                    "05/05/2014  12:45:42",
                    "05/05/2014  12:49:51"
                  ]
                ]
              }
            },
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I retrieve the qdf deal data"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the deals retrieved for each symbol will have the following counts",
              "TableArgument": {
                "HeaderRow": [
                  "Symbol",
                  "Count"
                ],
                "DataRows": [
                  [
                    "EURUSD",
                    "32"
                  ],
                  [
                    "NZDUSD",
                    "3"
                  ],
                  [
                    "AUDNZD",
                    "1"
                  ]
                ]
              }
            },
            {
              "Keyword": "And",
              "NativeKeyword": "And ",
              "Name": "the count of retrieved deals will be 36"
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": true
          }
        },
        {
          "Name": "Filter deals by book A",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Given",
              "NativeKeyword": "Given ",
              "Name": "I have the following search criteria for qdf deals",
              "TableArgument": {
                "HeaderRow": [
                  "Book",
                  "ConvertedStartTime",
                  "ConvertedEndTime"
                ],
                "DataRows": [
                  [
                    "A",
                    "05/05/2014  12:45:42",
                    "05/05/2014  12:49:51"
                  ]
                ]
              }
            },
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I retrieve the qdf deal data"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "all retrieved deals will have be for book \"A\""
            },
            {
              "Keyword": "And",
              "NativeKeyword": "And ",
              "Name": "the count of retrieved deals will be 32"
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": true
          }
        },
        {
          "Name": "Filter deals by book B",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Given",
              "NativeKeyword": "Given ",
              "Name": "I have the following search criteria for qdf deals",
              "TableArgument": {
                "HeaderRow": [
                  "Book",
                  "ConvertedStartTime",
                  "ConvertedEndTime"
                ],
                "DataRows": [
                  [
                    "B",
                    "05/05/2014  12:45:42",
                    "05/05/2014  12:49:51"
                  ]
                ]
              }
            },
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I retrieve the qdf deal data"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "all retrieved deals will have be for book \"B\""
            },
            {
              "Keyword": "And",
              "NativeKeyword": "And ",
              "Name": "the count of retrieved deals will be 69"
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": true
          }
        },
        {
          "Name": "Filter deals by book symbol and server",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Given",
              "NativeKeyword": "Given ",
              "Name": "I have the following search criteria for qdf deals",
              "TableArgument": {
                "HeaderRow": [
                  "Book",
                  "Symbol",
                  "Server",
                  "ConvertedStartTime",
                  "ConvertedEndTime"
                ],
                "DataRows": [
                  [
                    "B",
                    "EURUSD",
                    "Mt4Classic2",
                    "05/05/2014  12:45:42",
                    "05/05/2014  12:49:51"
                  ]
                ]
              }
            },
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I retrieve the qdf deal data"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "all retrieved deals will have be for book \"B\""
            },
            {
              "Keyword": "And",
              "NativeKeyword": "And ",
              "Name": "all retrieved deals will have be for symbol \"EURUSD\""
            },
            {
              "Keyword": "And",
              "NativeKeyword": "And ",
              "Name": "all retrieved deals will have be for server \"Mt4Classic2\""
            },
            {
              "Keyword": "And",
              "NativeKeyword": "And ",
              "Name": "the count of retrieved deals will be 4"
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": true
          }
        },
        {
          "Name": "Filter deals by multiple symbols and servers",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Given",
              "NativeKeyword": "Given ",
              "Name": "I have the following search criteria for qdf deals",
              "TableArgument": {
                "HeaderRow": [
                  "Symbol",
                  "Servers",
                  "ConvertedStartTime",
                  "ConvertedEndTime"
                ],
                "DataRows": [
                  [
                    "EURUSD,GBPUSD,AUDJPY",
                    "Currenex,Mt5Pro,Mt4JapaneseC1",
                    "05/05/2014  12:45:42",
                    "05/05/2014  12:49:51"
                  ]
                ]
              }
            },
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I retrieve the qdf deal data"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the deals retrieved for each symbol will have the following counts",
              "TableArgument": {
                "HeaderRow": [
                  "Symbol",
                  "Count"
                ],
                "DataRows": [
                  [
                    "EURUSD",
                    "15"
                  ],
                  [
                    "GBPUSD",
                    "2"
                  ],
                  [
                    "AUDJPY",
                    "1"
                  ]
                ]
              }
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the deals retrieved for each server will have the following counts",
              "TableArgument": {
                "HeaderRow": [
                  "Server",
                  "Count"
                ],
                "DataRows": [
                  [
                    "Mt4JapaneseC1",
                    "12"
                  ],
                  [
                    "Currenex",
                    "5"
                  ],
                  [
                    "Mt5Pro",
                    "1"
                  ]
                ]
              }
            },
            {
              "Keyword": "And",
              "NativeKeyword": "And ",
              "Name": "the count of retrieved deals will be 18"
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": true
          }
        },
        {
          "Name": "Filter deals by multiple symbols and servers and B Book",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Given",
              "NativeKeyword": "Given ",
              "Name": "I have the following search criteria for qdf deals",
              "TableArgument": {
                "HeaderRow": [
                  "Book",
                  "Symbol",
                  "Servers",
                  "ConvertedStartTime",
                  "ConvertedEndTime"
                ],
                "DataRows": [
                  [
                    "B",
                    "EURUSD,GBPUSD,AUDJPY,USDCHF",
                    "Currenex,Mt5Pro,Mt4JapaneseC1",
                    "05/05/2014  12:45:42",
                    "05/05/2014  12:49:51"
                  ]
                ]
              }
            },
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I retrieve the qdf deal data"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the deals retrieved for each symbol will have the following counts",
              "TableArgument": {
                "HeaderRow": [
                  "Symbol",
                  "Count"
                ],
                "DataRows": [
                  [
                    "EURUSD",
                    "15"
                  ],
                  [
                    "GBPUSD",
                    "2"
                  ],
                  [
                    "AUDJPY",
                    "1"
                  ],
                  [
                    "USDCHF",
                    "1"
                  ]
                ]
              }
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the deals retrieved for each server will have the following counts",
              "TableArgument": {
                "HeaderRow": [
                  "Server",
                  "Count"
                ],
                "DataRows": [
                  [
                    "Mt4JapaneseC1",
                    "12"
                  ],
                  [
                    "Currenex",
                    "5"
                  ],
                  [
                    "Mt5Pro",
                    "2"
                  ]
                ]
              }
            },
            {
              "Keyword": "And",
              "NativeKeyword": "And ",
              "Name": "the count of retrieved deals will be 19"
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": true
          }
        },
        {
          "Name": "Filter deals by multiple symbols and servers and A Book",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Given",
              "NativeKeyword": "Given ",
              "Name": "I have the following search criteria for qdf deals",
              "TableArgument": {
                "HeaderRow": [
                  "Book",
                  "Symbol",
                  "Servers",
                  "ConvertedStartTime",
                  "ConvertedEndTime"
                ],
                "DataRows": [
                  [
                    "A",
                    "EURUSD,GBPUSD,AUDJPY,USDCHF",
                    "Currenex,Mt5Pro,Mt4JapaneseC1",
                    "05/05/2014  12:45:42",
                    "05/05/2014  12:49:51"
                  ]
                ]
              }
            },
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I retrieve the qdf deal data"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the deals retrieved for each symbol will have the following counts",
              "TableArgument": {
                "HeaderRow": [
                  "Symbol",
                  "Count"
                ],
                "DataRows": [
                  [
                    "USDCHF",
                    "1"
                  ]
                ]
              }
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the deals retrieved for each server will have the following counts",
              "TableArgument": {
                "HeaderRow": [
                  "Server",
                  "Count"
                ],
                "DataRows": [
                  [
                    "Mt5Pro",
                    "1"
                  ]
                ]
              }
            },
            {
              "Keyword": "And",
              "NativeKeyword": "And ",
              "Name": "the count of retrieved deals will be 1"
            }
          ],
          "Tags": [],
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
      "Tags": [
        "@ClientSideFiltering"
      ]
    },
    "Result": {
      "WasExecuted": true,
      "WasSuccessful": true
    }
  },
  {
    "RelativeFolder": "OutputToCsv.feature",
    "Feature": {
      "Name": "OutputToCsv",
      "Description": "In order to export deal data from Redis QDF\r\nAs a QDF Analyst\r\nI want to be able to save query results to CSV",
      "FeatureElements": [
        {
          "Name": "Output to CSV",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Given",
              "NativeKeyword": "Given ",
              "Name": "I have the following search criteria for qdf deals",
              "TableArgument": {
                "HeaderRow": [
                  "Symbol",
                  "Servers",
                  "ConvertedStartTime",
                  "ConvertedEndTime"
                ],
                "DataRows": [
                  [
                    "EURUSD,GBPUSD,AUDJPY",
                    "Currenex,Mt5Pro,Mt4JapaneseC1",
                    "05/05/2014  12:45:42",
                    "05/05/2014  12:49:51"
                  ]
                ]
              }
            },
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I retrieve the qdf deal data"
            },
            {
              "Keyword": "And",
              "NativeKeyword": "And ",
              "Name": "I export the data to \"C:\\temp\\temp.csv\" and import the csv"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the deals imported for each symbol will have the following counts",
              "TableArgument": {
                "HeaderRow": [
                  "Symbol",
                  "Count"
                ],
                "DataRows": [
                  [
                    "EURUSD",
                    "15"
                  ],
                  [
                    "GBPUSD",
                    "2"
                  ],
                  [
                    "AUDJPY",
                    "1"
                  ]
                ]
              }
            },
            {
              "Keyword": "And",
              "NativeKeyword": "And ",
              "Name": "the deals imported for each server will have the following counts",
              "TableArgument": {
                "HeaderRow": [
                  "Server",
                  "Count"
                ],
                "DataRows": [
                  [
                    "Mt4JapaneseC1",
                    "12"
                  ],
                  [
                    "Currenex",
                    "5"
                  ],
                  [
                    "Mt5Pro",
                    "1"
                  ]
                ]
              }
            },
            {
              "Keyword": "And",
              "NativeKeyword": "And ",
              "Name": "the count of imported deals will be 18"
            }
          ],
          "Tags": [],
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
      "Tags": [
        "@ClientSideFiltering"
      ]
    },
    "Result": {
      "WasExecuted": true,
      "WasSuccessful": true
    }
  }
]);