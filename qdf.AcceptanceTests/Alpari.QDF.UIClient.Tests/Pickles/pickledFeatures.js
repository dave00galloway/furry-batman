jsonPWrapper ([
  {
    "RelativeFolder": "UKUSQDF-88 [AT] QDF UI - Investigate Server side scripting\\UKUSQDF-88 [AT] QDF UI - Investigate Server side scripting.feature",
    "Feature": {
      "Name": "UKUSQDF-88 [AT] QDF UI - Investigate Server side scripting",
      "Description": "In order to reduce query time\r\nAs a QDF Analyst \r\nI want to filter query results server side",
      "FeatureElements": [
        {
          "Name": "Connect to Redis Scripting Interface Hello World",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Given",
              "NativeKeyword": "Given ",
              "Name": "I have the following script \"return 'Hello World!'\" to send to redis cli"
            },
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I send the script to redis cli"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the result should be \"Hello World!\""
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": true
          }
        },
        {
          "Name": "Connect to redis scripting interface and query deals",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Given",
              "NativeKeyword": "Given ",
              "Name": "I have a valid deal query script"
            },
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I load the script to redis cli"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the result should be \"Hello World!\""
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
      "Tags": [
        "@UKUSQDF_88",
        "@TeardownRedisConnection"
      ]
    },
    "Result": {
      "WasExecuted": true,
      "WasSuccessful": false
    }
  },
  {
    "RelativeFolder": "UKUSQDF-70 [AT] QDF UI - produce stats on query times, number of records, data size\\UKUSQDF-70 [AT] QDF UI - UI Support for Stats .feature",
    "Feature": {
      "Name": "UKUSQDF-70 [AT] QDF UI - UI Support for Stats",
      "Description": "In order to display relevant stats\r\nAs a QDF Analyst\r\nI want to be see appropriate stats for the type of data query",
      "FeatureElements": [
        {
          "Name": "Display stats for Deal Query",
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
              "Keyword": "And",
              "NativeKeyword": "And ",
              "Name": "I start measuring the query"
            },
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I retrieve the qdf deal data"
            },
            {
              "Keyword": "And",
              "NativeKeyword": "And ",
              "Name": "I stop measuring the query"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the stats for a deal query are displayed"
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": true
          }
        },
        {
          "Name": "Display stats for Ecn Deal Query",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Given",
              "NativeKeyword": "Given ",
              "Name": "I have the following search criteria for qdf deals",
              "TableArgument": {
                "HeaderRow": [
                  "DealSource",
                  "Book",
                  "Symbol",
                  "Server",
                  "ConvertedStartTime",
                  "ConvertedEndTime"
                ],
                "DataRows": [
                  [
                    "ecn-deals",
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
              "Keyword": "And",
              "NativeKeyword": "And ",
              "Name": "I start measuring the query"
            },
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I retrieve the qdf deal data"
            },
            {
              "Keyword": "And",
              "NativeKeyword": "And ",
              "Name": "I stop measuring the query"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the stats for a deal query are displayed"
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": true
          }
        },
        {
          "Name": "Display stats for Quote Query",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Given",
              "NativeKeyword": "Given ",
              "Name": "I have the following search criteria for qdf quotes",
              "TableArgument": {
                "HeaderRow": [
                  "Symbol",
                  "ConvertedStartTime",
                  "ConvertedEndTime"
                ],
                "DataRows": [
                  [
                    "EURUSD",
                    "09/06/2014  09:00:00",
                    "09/06/2014  09:05:00"
                  ]
                ]
              }
            },
            {
              "Keyword": "And",
              "NativeKeyword": "And ",
              "Name": "I start measuring the query"
            },
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I retrieve the qdf quote data"
            },
            {
              "Keyword": "And",
              "NativeKeyword": "And ",
              "Name": "I stop measuring the query"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the stats for a quote query are displayed"
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": false
          }
        },
        {
          "Name": "Reset stats for Deal Query",
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
              "Keyword": "And",
              "NativeKeyword": "And ",
              "Name": "I have queried and displayed the deal query stats"
            },
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I reset the performance stats"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the deal performance stats are:",
              "TableArgument": {
                "HeaderRow": [
                  "ExecutionTime",
                  "QuerySize",
                  "QuerySizeFormatted",
                  "QuerySpeedInBytesPerSecondFormatted",
                  "DealCount",
                  "TotalDealCount",
                  "DealQuerySpeedInDealsPerSecond",
                  "DealQuerySpeedInDealsPerSecondFormatted",
                  "TotalDealQuerySpeedInDealsPerSecond",
                  "TotalDealQuerySpeedInDealsPerSecondFormatted"
                ],
                "DataRows": [
                  [
                    "0",
                    "0",
                    "",
                    "0 Bytes/Second",
                    "0",
                    "0",
                    "0",
                    "0 Deals/Second",
                    "0",
                    "0 Deals/Second"
                  ]
                ]
              }
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": true
          }
        },
        {
          "Name": "Reset stats for Deal Query and requery",
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
              "Keyword": "And",
              "NativeKeyword": "And ",
              "Name": "I have queried and displayed the deal query stats"
            },
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I reset the performance stats"
            },
            {
              "Keyword": "Given",
              "NativeKeyword": "Given ",
              "Name": "I have the following search criteria for qdf deals",
              "TableArgument": {
                "HeaderRow": [
                  "DealSource",
                  "Book",
                  "Symbol",
                  "Server",
                  "ConvertedStartTime",
                  "ConvertedEndTime"
                ],
                "DataRows": [
                  [
                    "ecn-deals",
                    "A",
                    "EURUSD",
                    "Mt4Classic2",
                    "05/05/2014  12:45:42",
                    "05/05/2014  12:49:51"
                  ]
                ]
              }
            },
            {
              "Keyword": "And",
              "NativeKeyword": "And ",
              "Name": "I start measuring the query"
            },
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I retrieve the qdf deal data"
            },
            {
              "Keyword": "And",
              "NativeKeyword": "And ",
              "Name": "I stop measuring the query"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the stats for a deal query are displayed"
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
        "WasSuccessful": false
      },
      "Tags": [
        "@UKUSQDF_70"
      ]
    },
    "Result": {
      "WasExecuted": true,
      "WasSuccessful": false
    }
  },
  {
    "RelativeFolder": "UKUSQDF-70 [AT] QDF UI - produce stats on query times, number of records, data size\\UKUSQDF-70 [AT] QDF UI - Quote Query Stats.feature",
    "Feature": {
      "Name": "UKUSQDF-70 [AT] QDF UI - Quote Query Stats",
      "Description": "In order to benchmark quote query performance\r\nAs a QDF Analyst\r\nI want to be told the execution time, data size, number of records in a query",
      "FeatureElements": [
        {
          "Name": "Query redis and get execution time for quote queries",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the query execution time is recorded"
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": false
          }
        },
        {
          "Name": "Query redis and get data size for quote queries",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the quote data size is recorded"
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": false
          }
        },
        {
          "Name": "Query redis and get record count for quote queries",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the quote count is recorded"
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": false
          }
        },
        {
          "Name": "Query redis and get query speed in bytes per second",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the quote query speed in bytes per second is equal to the size of the query divided by the elapsed time"
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": false
          }
        },
        {
          "Name": "Query redis and get query speed in quotes per second",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the quote query speed in quotes per second is equal to the quote count divided by the elapsed time"
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": false
          }
        },
        {
          "Name": "Query redis and get total record count for deal queries",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the total quote count is recorded"
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": false
          }
        },
        {
          "Name": "Query redis and get query speed in total deals per second",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the deal quote speed in total quotes per second is equal to the quote count divided by the elapsed time"
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
        "Name": "Set up Quote Query and start timing",
        "Description": "",
        "Steps": [
          {
            "Keyword": "Given",
            "NativeKeyword": "Given ",
            "Name": "I have the following search criteria for qdf quotes",
            "TableArgument": {
              "HeaderRow": [
                "Symbol",
                "ConvertedStartTime",
                "ConvertedEndTime"
              ],
              "DataRows": [
                [
                  "EURUSD",
                  "09/06/2014  09:00:00",
                  "09/06/2014  09:05:00"
                ]
              ]
            }
          },
          {
            "Keyword": "And",
            "NativeKeyword": "And ",
            "Name": "I start measuring the query"
          },
          {
            "Keyword": "When",
            "NativeKeyword": "When ",
            "Name": "I retrieve the qdf quote data"
          },
          {
            "Keyword": "And",
            "NativeKeyword": "And ",
            "Name": "I stop measuring the query"
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
      "Tags": [
        "@UKUSQDF_70"
      ]
    },
    "Result": {
      "WasExecuted": true,
      "WasSuccessful": false
    }
  },
  {
    "RelativeFolder": "UKUSQDF-70 [AT] QDF UI - produce stats on query times, number of records, data size\\UKUSQDF-70 [AT] QDF UI - Ecn Deal Query Stats.feature",
    "Feature": {
      "Name": "UKUSQDF-70 [AT] QDF UI - Ecn Deal Query Stats",
      "Description": "In order to benchmark ecn deal query performance\r\nAs a QDF Analyst\r\nI want to be told the execution time, data size, number of records in a query",
      "FeatureElements": [
        {
          "Name": "Query redis and get execution time for deal queries",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the query execution time is recorded"
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": true
          }
        },
        {
          "Name": "Query redis and get data size for deal queries",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the deal data size is recorded"
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": true
          }
        },
        {
          "Name": "Query redis and get record count for deal queries",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the deal count is recorded"
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": true
          }
        },
        {
          "Name": "Query redis and get query speed in bytes per second",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the deal query speed in bytes per second is equal to the size of the query divided by the elapsed time"
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": true
          }
        },
        {
          "Name": "Query redis and get query speed in deals per second",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the deal query speed in deals per second is equal to the deal count divided by the elapsed time"
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": true
          }
        },
        {
          "Name": "Query redis and get total record count for deal queries",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the total deal count is recorded"
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": true
          }
        },
        {
          "Name": "Query redis and get query speed in total deals per second",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the deal query speed in total deals per second is equal to the deal count divided by the elapsed time"
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
        "Name": "Set up Deal Query and start timing",
        "Description": "",
        "Steps": [
          {
            "Keyword": "Given",
            "NativeKeyword": "Given ",
            "Name": "I have the following search criteria for qdf deals",
            "TableArgument": {
              "HeaderRow": [
                "DealSource",
                "Book",
                "Symbol",
                "Server",
                "ConvertedStartTime",
                "ConvertedEndTime"
              ],
              "DataRows": [
                [
                  "ecn-deals",
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
            "Keyword": "And",
            "NativeKeyword": "And ",
            "Name": "I start measuring the query"
          },
          {
            "Keyword": "When",
            "NativeKeyword": "When ",
            "Name": "I retrieve the qdf deal data"
          },
          {
            "Keyword": "And",
            "NativeKeyword": "And ",
            "Name": "I stop measuring the query"
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
      "Tags": [
        "@UKUSQDF_70"
      ]
    },
    "Result": {
      "WasExecuted": true,
      "WasSuccessful": true
    }
  },
  {
    "RelativeFolder": "UKUSQDF-70 [AT] QDF UI - produce stats on query times, number of records, data size\\UKUSQDF-70 [AT] QDF UI - Deal Query Stats.feature",
    "Feature": {
      "Name": "UKUSQDF-70 [AT] QDF UI - Deal Query Stats",
      "Description": "In order to benchmark deal query performance\r\nAs a QDF Analyst\r\nI want to be told the execution time, data size, number of records in a query",
      "FeatureElements": [
        {
          "Name": "Query redis and get execution time for deal queries",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the query execution time is recorded"
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": true
          }
        },
        {
          "Name": "Query redis and get data size for deal queries",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the deal data size is recorded"
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": true
          }
        },
        {
          "Name": "Query redis and get record count for deal queries",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the deal count is recorded"
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": true
          }
        },
        {
          "Name": "Query redis and get query speed in bytes per second",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the deal query speed in bytes per second is equal to the size of the query divided by the elapsed time"
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": true
          }
        },
        {
          "Name": "Query redis and get query speed in deals per second",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the deal query speed in deals per second is equal to the deal count divided by the elapsed time"
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": true
          }
        },
        {
          "Name": "Query redis and get total record count for deal queries",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the total deal count is recorded"
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": true
          }
        },
        {
          "Name": "Query redis and get query speed in total deals per second",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the deal query speed in total deals per second is equal to the deal count divided by the elapsed time"
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
        "Name": "Set up Deal Query and start timing",
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
            "Keyword": "And",
            "NativeKeyword": "And ",
            "Name": "I start measuring the query"
          },
          {
            "Keyword": "When",
            "NativeKeyword": "When ",
            "Name": "I retrieve the qdf deal data"
          },
          {
            "Keyword": "And",
            "NativeKeyword": "And ",
            "Name": "I stop measuring the query"
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
      "Tags": [
        "@UKUSQDF_70"
      ]
    },
    "Result": {
      "WasExecuted": true,
      "WasSuccessful": true
    }
  },
  {
    "RelativeFolder": "UKUSQDF-97 [AT] Cnx2Redis DataCollector - enable cnx-deals in Alpari.QDF.UIClient.App.feature",
    "Feature": {
      "Name": "UKUSQDF-97 [AT] [AT] Cnx2Redis DataCollector - enable cnx-deals in Alpari.QDF.UIClient.App",
      "Description": "In order to test cnx-deals are imported to Redis\r\nAs a QDF tester\r\ni want to be able to query for cnx-deals in Alpari.QDF.UIClient.App",
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
                  "DealSource",
                  "ConvertedStartTime",
                  "ConvertedEndTime"
                ],
                "DataRows": [
                  [
                    "cnx-deals",
                    "19/06/2014  17:35:00",
                    "19/06/2014  17:45:00"
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
              "Name": "no retrieved deal will have a timestamp outside \"19/06/2014  17:35:00\" to \"19/06/2014  17:45:00\""
            },
            {
              "Keyword": "And",
              "NativeKeyword": "And ",
              "Name": "the count of retrieved deals will be 11"
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
        "@UKUSQDF_97"
      ]
    },
    "Result": {
      "WasExecuted": true,
      "WasSuccessful": true
    }
  },
  {
    "RelativeFolder": "UKUSQDF-71[AT] QDF UI - add ability to switch between ARS and ECN deals.feature",
    "Feature": {
      "Name": "UKUSQDF-71[AT] QDF UI - add ability to switch between ARS and ECN deals",
      "Description": "In order to access ecn deal data in Redis QDF\r\nAs a QDF Analyst\r\nI want a UI to retrieve and filter ecn deal data",
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
                  "DealSource",
                  "ConvertedStartTime",
                  "ConvertedEndTime"
                ],
                "DataRows": [
                  [
                    "ecn-deals",
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
              "Name": "the count of retrieved deals will be 70"
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
        "@ClientSideFiltering",
        "@TeardownRedisConnection",
        "@UKUSQDF_71"
      ]
    },
    "Result": {
      "WasExecuted": true,
      "WasSuccessful": true
    }
  },
  {
    "RelativeFolder": "UKUSQDF-69 [AT] QDF UI - add ability to query on Quotes as well as deals.feature",
    "Feature": {
      "Name": "UKUSQDF-69 [AT] QDF UI - add ability to query on Quotes as well as deals",
      "Description": "In order to get information about quotes\r\nAs a QDF Analyst\r\nI want access to quote data in QDF",
      "FeatureElements": [
        {
          "Name": "Filter quotes by date",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Given",
              "NativeKeyword": "Given ",
              "Name": "I have the following search criteria for qdf quotes",
              "TableArgument": {
                "HeaderRow": [
                  "ConvertedStartTime",
                  "ConvertedEndTime"
                ],
                "DataRows": [
                  [
                    "09/06/2014  09:00:00",
                    "09/06/2014  09:05:00"
                  ]
                ]
              }
            },
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I retrieve the qdf quote data"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "no retrieved quote will have a timestamp outside \"09/06/2014  09:00:00\" to \"09/06/2014  09:05:00\""
            },
            {
              "Keyword": "And",
              "NativeKeyword": "And ",
              "Name": "the count of retrieved quotes will be 10760"
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": false
          }
        },
        {
          "Name": "Filter quotes by symbol",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Given",
              "NativeKeyword": "Given ",
              "Name": "I have the following search criteria for qdf quotes",
              "TableArgument": {
                "HeaderRow": [
                  "Symbol",
                  "ConvertedStartTime",
                  "ConvertedEndTime"
                ],
                "DataRows": [
                  [
                    "EURUSD",
                    "09/06/2014  09:00:00",
                    "09/06/2014  09:05:00"
                  ]
                ]
              }
            },
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I retrieve the qdf quote data"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "all retrieved quotes will be for symbol \"EURUSD\""
            },
            {
              "Keyword": "And",
              "NativeKeyword": "And ",
              "Name": "the count of retrieved quotes will be 211"
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": false
          }
        },
        {
          "Name": "Filter quotes by multiple symbols",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Given",
              "NativeKeyword": "Given ",
              "Name": "I have the following search criteria for qdf quotes",
              "TableArgument": {
                "HeaderRow": [
                  "Symbol",
                  "ConvertedStartTime",
                  "ConvertedEndTime"
                ],
                "DataRows": [
                  [
                    "EURUSD,NZDUSD,AUDNZD",
                    "09/06/2014  09:00:00",
                    "09/06/2014  09:05:00"
                  ]
                ]
              }
            },
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I retrieve the qdf quote data"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the quotes retrieved for each symbol will have the following counts",
              "TableArgument": {
                "HeaderRow": [
                  "Symbol",
                  "Count"
                ],
                "DataRows": [
                  [
                    "EURUSD",
                    "211"
                  ],
                  [
                    "NZDUSD",
                    "154"
                  ],
                  [
                    "AUDNZD",
                    "165"
                  ]
                ]
              }
            },
            {
              "Keyword": "And",
              "NativeKeyword": "And ",
              "Name": "the count of retrieved quotes will be 530"
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": false
          }
        },
        {
          "Name": "Output to CSV all quotes",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Given",
              "NativeKeyword": "Given ",
              "Name": "I have the following search criteria for qdf quotes",
              "TableArgument": {
                "HeaderRow": [
                  "ConvertedStartTime",
                  "ConvertedEndTime"
                ],
                "DataRows": [
                  [
                    "09/06/2014  09:00:00",
                    "09/06/2014  09:05:00"
                  ]
                ]
              }
            },
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I retrieve the qdf quote data"
            },
            {
              "Keyword": "And",
              "NativeKeyword": "And ",
              "Name": "I export the quote data to \"C:\\temp\\temp.csv\" and import the csv"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the count of retrieved quotes will be 10760"
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": false
          }
        },
        {
          "Name": "Output to CSV filtered quotes",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Given",
              "NativeKeyword": "Given ",
              "Name": "I have the following search criteria for qdf quotes",
              "TableArgument": {
                "HeaderRow": [
                  "Symbol",
                  "ConvertedStartTime",
                  "ConvertedEndTime"
                ],
                "DataRows": [
                  [
                    "EURUSD,NZDUSD,AUDNZD",
                    "09/06/2014  09:00:00",
                    "09/06/2014  09:05:00"
                  ]
                ]
              }
            },
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I retrieve the qdf quote data"
            },
            {
              "Keyword": "And",
              "NativeKeyword": "And ",
              "Name": "I export the quote data to \"C:\\temp\\temp.csv\" and import the csv"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the quotes imported for each symbol will have the following counts",
              "TableArgument": {
                "HeaderRow": [
                  "Symbol",
                  "Count"
                ],
                "DataRows": [
                  [
                    "EURUSD",
                    "211"
                  ],
                  [
                    "NZDUSD",
                    "154"
                  ],
                  [
                    "AUDNZD",
                    "165"
                  ]
                ]
              }
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the count of retrieved quotes will be 530"
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
      "Tags": [
        "@UKUSQDF_69"
      ]
    },
    "Result": {
      "WasExecuted": true,
      "WasSuccessful": false
    }
  },
  {
    "RelativeFolder": "UKUSQDF-68 [AT] QDF UI - enable switching of environment through the UI.feature",
    "Feature": {
      "Name": "UKUSQDF-68 [AT] QDF UI - enable switching of environment through the UI",
      "Description": "In order to compare data in different QDF Environments\r\nAs a QDF Analyst\r\nI want to be able to change environment",
      "FeatureElements": [
        {
          "Name": "Setup Environment UI Control",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Given",
              "NativeKeyword": "Given ",
              "Name": "I want to be able to switch environments"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the list of environments options should be:",
              "TableArgument": {
                "HeaderRow": [
                  "Environments"
                ],
                "DataRows": [
                  [
                    "uk-redis-prod.corp.alpari.com"
                  ],
                  [
                    "uk-redis-uat.corp.alpari.com"
                  ],
                  [
                    "uk-redis-dev.corp.alpari.com"
                  ]
                ]
              }
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": true
          }
        },
        {
          "Examples": [
            {
              "Name": "",
              "Description": "",
              "TableArgument": {
                "HeaderRow": [
                  "Environments"
                ],
                "DataRows": [
                  [
                    "uk-redis-prod.corp.alpari.com"
                  ],
                  [
                    "uk-redis-uat.corp.alpari.com"
                  ],
                  [
                    "uk-redis-dev.corp.alpari.com"
                  ]
                ]
              }
            }
          ],
          "Name": "Switch Environments",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Given",
              "NativeKeyword": "Given ",
              "Name": "I am connected to qdf on \"10.10.144.156\""
            },
            {
              "Keyword": "And",
              "NativeKeyword": "And ",
              "Name": "I want to be able to switch environments"
            },
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I change the redis connection to \"<Environments>\""
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "I am connected to qdf on \"<Environments>\""
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": true
          }
        },
        {
          "Name": "Default Environment",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Given",
              "NativeKeyword": "Given ",
              "Name": "I want to be able to switch environments"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the default value set in the environment control is \"uk-redis-uat.corp.alpari.com\""
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
        "@UKUSQDF_68",
        "@TeardownRedisConnection"
      ]
    },
    "Result": {
      "WasExecuted": true,
      "WasSuccessful": true
    }
  },
  {
    "RelativeFolder": "SetupUiControls.feature",
    "Feature": {
      "Name": "SetupUIControls",
      "Description": "In order to select search options\r\nAs a QDF Analyst\r\nI want search options to be accurate and complete",
      "FeatureElements": [
        {
          "Name": "Set up trade server list",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Given",
              "NativeKeyword": "Given ",
              "Name": "I filter deals by server"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the list of server options should be:",
              "TableArgument": {
                "HeaderRow": [
                  "Server"
                ],
                "DataRows": [
                  [
                    "Unknown"
                  ],
                  [
                    "Mt4CapitalBankJordan"
                  ],
                  [
                    "Mt4Pro"
                  ],
                  [
                    "Currenex"
                  ],
                  [
                    "Mt4Micro1"
                  ],
                  [
                    "Mt4Micro2"
                  ],
                  [
                    "Mt4Classic1"
                  ],
                  [
                    "Mt4Classic2"
                  ],
                  [
                    "Mt4JapaneseC1"
                  ],
                  [
                    "Mt5Pro"
                  ],
                  [
                    "Mt4MarketMena"
                  ],
                  [
                    "Mt4SpreadBetting"
                  ],
                  [
                    "Mt4Market1"
                  ],
                  [
                    "Mt4B2B"
                  ],
                  [
                    "Coverage101"
                  ],
                  [
                    "Coverage601"
                  ],
                  [
                    "Coverage602"
                  ],
                  [
                    "Coverage604"
                  ]
                ]
              }
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
          "Name": "Set up book list",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Given",
              "NativeKeyword": "Given ",
              "Name": "I filter deals by book"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the list of book options should be:",
              "TableArgument": {
                "HeaderRow": [
                  "Book"
                ],
                "DataRows": [
                  [
                    "None"
                  ],
                  [
                    "A"
                  ],
                  [
                    "B"
                  ]
                ]
              }
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": true
          }
        },
        {
          "Name": "Set up datatypes list",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Given",
              "NativeKeyword": "Given ",
              "Name": "I choose the type of data to be queried"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the list of data type options should be:",
              "TableArgument": {
                "HeaderRow": [
                  "DataType"
                ],
                "DataRows": [
                  [
                    "CurrentState"
                  ],
                  [
                    "deals"
                  ],
                  [
                    "PriceQuote"
                  ],
                  [
                    "ecn-deals"
                  ]
                ]
              }
            }
          ],
          "Tags": [
            "@UKUSQDF_69"
          ],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": true
          }
        },
        {
          "Name": "Set up default datatype",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Given",
              "NativeKeyword": "Given ",
              "Name": "I choose the type of data to be queried"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the default datatype should be \"deals\""
            }
          ],
          "Tags": [
            "@UKUSQDF_69"
          ],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": true
          }
        },
        {
          "Name": "set up symbol list",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Given",
              "NativeKeyword": "Given ",
              "Name": "I filter deals by symbol"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the list of symbol options should be:",
              "TableArgument": {
                "HeaderRow": [
                  "Symbol"
                ],
                "DataRows": [
                  [
                    "AUDCAD"
                  ],
                  [
                    "AUDCHF"
                  ],
                  [
                    "AUDJPY"
                  ],
                  [
                    "AUDNZD"
                  ],
                  [
                    "AUDSGD"
                  ],
                  [
                    "AUDUSD"
                  ],
                  [
                    "AUDZAR"
                  ],
                  [
                    "CADCHF"
                  ],
                  [
                    "CADJPY"
                  ],
                  [
                    "CADSGD"
                  ],
                  [
                    "CHFJPY"
                  ],
                  [
                    "CHFSGD"
                  ],
                  [
                    "DE30"
                  ],
                  [
                    "EUR50"
                  ],
                  [
                    "EURAUD"
                  ],
                  [
                    "EURCAD"
                  ],
                  [
                    "EURCHF"
                  ],
                  [
                    "EURCZK"
                  ],
                  [
                    "EURDKK"
                  ],
                  [
                    "EURGBP"
                  ],
                  [
                    "EURHKD"
                  ],
                  [
                    "EURHUF"
                  ],
                  [
                    "EURJPY"
                  ],
                  [
                    "EURMXN"
                  ],
                  [
                    "EURNOK"
                  ],
                  [
                    "EURNZD"
                  ],
                  [
                    "EURPLN"
                  ],
                  [
                    "EURRUB"
                  ],
                  [
                    "EURSEK"
                  ],
                  [
                    "EURSGD"
                  ],
                  [
                    "EURTRY"
                  ],
                  [
                    "EURUSD"
                  ],
                  [
                    "EURZAR"
                  ],
                  [
                    "FRA40"
                  ],
                  [
                    "GBPAUD"
                  ],
                  [
                    "GBPCAD"
                  ],
                  [
                    "GBPCHF"
                  ],
                  [
                    "GBPJPY"
                  ],
                  [
                    "GBPNOK"
                  ],
                  [
                    "GBPNZD"
                  ],
                  [
                    "GBPSEK"
                  ],
                  [
                    "GBPSGD"
                  ],
                  [
                    "GBPUSD"
                  ],
                  [
                    "GBPZAR"
                  ],
                  [
                    "HKDJPY"
                  ],
                  [
                    "MXNJPY"
                  ],
                  [
                    "NOKJPY"
                  ],
                  [
                    "NOKSEK"
                  ],
                  [
                    "NQ100"
                  ],
                  [
                    "NZDCAD"
                  ],
                  [
                    "NZDCHF"
                  ],
                  [
                    "NZDJPY"
                  ],
                  [
                    "NZDSGD"
                  ],
                  [
                    "NZDUSD"
                  ],
                  [
                    "NZDZAR"
                  ],
                  [
                    "SEKJPY"
                  ],
                  [
                    "SEKNOK"
                  ],
                  [
                    "SGDJPY"
                  ],
                  [
                    "UK100"
                  ],
                  [
                    "US30"
                  ],
                  [
                    "US500"
                  ],
                  [
                    "USDCAD"
                  ],
                  [
                    "USDCHF"
                  ],
                  [
                    "USDCNH"
                  ],
                  [
                    "USDCZK"
                  ],
                  [
                    "USDDKK"
                  ],
                  [
                    "USDHKD"
                  ],
                  [
                    "USDHUF"
                  ],
                  [
                    "USDJPY"
                  ],
                  [
                    "USDMXN"
                  ],
                  [
                    "USDNOK"
                  ],
                  [
                    "USDPLN"
                  ],
                  [
                    "USDRUB"
                  ],
                  [
                    "USDSEK"
                  ],
                  [
                    "USDSGD"
                  ],
                  [
                    "USDTRY"
                  ],
                  [
                    "USDZAR"
                  ],
                  [
                    "XAGUSD"
                  ],
                  [
                    "XAUUSD"
                  ],
                  [
                    "ZARJPY"
                  ]
                ]
              }
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
        "@TeardownRedisConnection"
      ]
    },
    "Result": {
      "WasExecuted": true,
      "WasSuccessful": true
    }
  },
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
              "Name": "the count of retrieved deals will be 113"
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
              "Name": "the count of retrieved deals will be 13"
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
                    "13"
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
              "Name": "the count of retrieved deals will be 17"
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
              "Name": "the count of retrieved deals will be 33"
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
                    "33"
                  ],
                  [
                    "NZDUSD",
                    "4"
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
              "Name": "the count of retrieved deals will be 38"
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
              "Name": "the count of retrieved deals will be 33"
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
              "Name": "the count of retrieved deals will be 80"
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
                    "16"
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
                    "16"
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
                    "2"
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
                    "4"
                  ]
                ]
              }
            },
            {
              "Keyword": "And",
              "NativeKeyword": "And ",
              "Name": "the count of retrieved deals will be 21"
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
                    "2"
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
                    "2"
                  ]
                ]
              }
            },
            {
              "Keyword": "And",
              "NativeKeyword": "And ",
              "Name": "the count of retrieved deals will be 2"
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
        "@UKUSQDF_60",
        "@ClientSideFiltering",
        "@TeardownRedisConnection"
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
                    "16"
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
                    "2"
                  ]
                ]
              }
            },
            {
              "Keyword": "And",
              "NativeKeyword": "And ",
              "Name": "the count of imported deals will be 19"
            }
          ],
          "Tags": [
            "@UKUSQDF_61"
          ],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": true
          }
        },
        {
          "Name": "Output ecn deals to CSV",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Given",
              "NativeKeyword": "Given ",
              "Name": "I have the following search criteria for qdf deals",
              "TableArgument": {
                "HeaderRow": [
                  "DealSource",
                  "Symbol",
                  "Servers",
                  "ConvertedStartTime",
                  "ConvertedEndTime"
                ],
                "DataRows": [
                  [
                    "ecn-deals",
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
                    "11"
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
                  ]
                ]
              }
            },
            {
              "Keyword": "And",
              "NativeKeyword": "And ",
              "Name": "the count of imported deals will be 12"
            }
          ],
          "Tags": [
            "@UKUSQDF_71"
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
      "Tags": [
        "@ClientSideFiltering",
        "@TeardownRedisConnection"
      ]
    },
    "Result": {
      "WasExecuted": true,
      "WasSuccessful": true
    }
  }
]);