jsonPWrapper ([
  {
    "RelativeFolder": "SpecflowZapiReporterParser.feature",
    "Feature": {
      "Name": "SpecflowZapiReporterParser",
      "Description": "In order to upload Specflow test results to Zephyr\r\nAs a Test Designer\r\nI want to be able to load specflow test results into memory",
      "FeatureElements": [
        {
          "Name": "Load an xml result file and find a single test result",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the xml root Name property is \"test-results\""
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": false,
            "WasSuccessful": false
          }
        },
        {
          "Name": "Load an xml result file and find a test result",
          "Description": "",
          "Steps": [
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I parse the xml test result file as test-results"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "test-results with a \"name\" attribute value of \"C:\\svn\\local\\BakeryDemoTest\\trunk\\AllBakeryDemoTestProjects\\FIX_SpecflowTests\\bin\\Release\\FIX_SpecflowTests.dll\" exists"
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": false,
            "WasSuccessful": false
          }
        },
        {
          "Name": "Load an xml result file and find a test result's values",
          "Description": "",
          "Steps": [
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I parse the xml test result file as test-results"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "a test-results object with the following attribute values exists:",
              "TableArgument": {
                "HeaderRow": [
                  "name",
                  "total",
                  "errors",
                  "failures",
                  "notrun",
                  "inconclusive",
                  "ignored",
                  "skipped",
                  "invalid",
                  "date",
                  "time"
                ],
                "DataRows": [
                  [
                    "C:\\svn\\local\\BakeryDemoTest\\trunk\\AllBakeryDemoTestProjects\\FIX_SpecflowTests\\bin\\Release\\FIX_SpecflowTests.dll",
                    "7",
                    "1",
                    "0",
                    "0",
                    "0",
                    "0",
                    "0",
                    "0",
                    "2014-01-27",
                    "14:07:06"
                  ]
                ]
              }
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": false,
            "WasSuccessful": false
          }
        },
        {
          "Name": "Load an xml result file and find a test result's values negative",
          "Description": "",
          "Steps": [
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I parse the xml test result file as test-results"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "a test-results object with the following attribute values exists:",
              "TableArgument": {
                "HeaderRow": [
                  "name",
                  "total",
                  "errors",
                  "failures",
                  "notrun",
                  "inconclusive",
                  "ignored",
                  "skipped",
                  "invalid",
                  "date",
                  "time"
                ],
                "DataRows": [
                  [
                    "C:\\svn\\local\\BakeryDemoTest\\trunk\\AllBakeryDemoTestProjects\\FIX_SpecflowTests\\bin\\Debug\\FIX_SpecflowTests.dll",
                    "6",
                    "2",
                    "2",
                    "1",
                    "1",
                    "4",
                    "6",
                    "8",
                    "2014-03-27",
                    "14:05:06"
                  ]
                ]
              }
            }
          ],
          "Tags": [
            "@negative"
          ],
          "Result": {
            "WasExecuted": false,
            "WasSuccessful": false
          }
        },
        {
          "Name": "Load an xml result file and find an environment",
          "Description": "",
          "Steps": [
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I parse the xml test result file as an environment"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "an environment with a \"nunitversion\" attribute value of \"2.6.3.13283\" exists"
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": false,
            "WasSuccessful": false
          }
        },
        {
          "Name": "Load an xml result file and find an environment's value",
          "Description": "",
          "Steps": [
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I parse the xml test result file as an environment"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "an environment object with the following attribute values exists:",
              "TableArgument": {
                "HeaderRow": [
                  "nunitversion",
                  "clrversion",
                  "osversion",
                  "platform",
                  "cwd",
                  "machinename",
                  "user",
                  "userdomain"
                ],
                "DataRows": [
                  [
                    "2.6.3.13283",
                    "2.0.50727.5472",
                    "Microsoft Windows NT 6.1.7601 Service Pack 1",
                    "Win32NT",
                    "C:\\svn\\local\\BakeryDemoTest\\trunk\\AllBakeryDemoTestProjects",
                    "AUK0231NB",
                    "dgalloway",
                    "ALPARI-UK"
                  ]
                ]
              }
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": false,
            "WasSuccessful": false
          }
        },
        {
          "Name": "Load an xml result file and find a suite",
          "Description": "",
          "Steps": [
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I parse the xml test result file as a test-suite collection"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "a test-suite with a \"name\" attribute value of \"FIX_SpecflowTests\" exists"
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": false,
            "WasSuccessful": false
          }
        },
        {
          "Name": "Load an xml result file and fail to find a suite",
          "Description": "",
          "Steps": [
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I parse the xml test result file as a test-suite collection"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "a test-suite with a \"name\" attribute value of \"made up suite\" exists"
            }
          ],
          "Tags": [
            "@negative"
          ],
          "Result": {
            "WasExecuted": false,
            "WasSuccessful": false
          }
        },
        {
          "Name": "Load an xml result file and find a TestFixture suite",
          "Description": "",
          "Steps": [
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I parse the xml test result file as a test-suite collection"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "a test-suite with a \"type\" attribute value of \"TestFixture\" exists"
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": false,
            "WasSuccessful": false
          }
        },
        {
          "Name": "Load an xml result file and find test cases",
          "Description": "",
          "Steps": [
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I parse the xml test result file as a test-suite collection"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the following test cases are found for these test suites:",
              "TableArgument": {
                "HeaderRow": [
                  "test suite name",
                  "test case name",
                  "executed",
                  "result",
                  "success",
                  "time",
                  "asserts"
                ],
                "DataRows": [
                  [
                    "ShareContextOneFeature",
                    "Alpari.QualityAssurance.SpecFlowExtensions.Specs.ShareContextOneFeature.AccessAStaticObjectFromShareContextOneScenarioOne",
                    "True",
                    "Success",
                    "True",
                    "0.352",
                    "2"
                  ],
                  [
                    "ShareContextOneFeature",
                    "Alpari.QualityAssurance.SpecFlowExtensions.Specs.ShareContextOneFeature.AccessAStaticObjectFromShareContextOneScenarioTwo",
                    "True",
                    "Success",
                    "True",
                    "0.001",
                    "2"
                  ],
                  [
                    "ShareContextTwoFeature",
                    "Alpari.QualityAssurance.SpecFlowExtensions.Specs.ShareContextTwoFeature.AccessAStaticObjectFromShareContextTwoScenarioOne",
                    "True",
                    "Success",
                    "True",
                    "0.002",
                    "2"
                  ],
                  [
                    "ShareContextTwoFeature",
                    "Alpari.QualityAssurance.SpecFlowExtensions.Specs.ShareContextTwoFeature.AccessAStaticObjectFromShareContextTwoScenarioTwo",
                    "True",
                    "Success",
                    "True",
                    "0.001",
                    "2"
                  ],
                  [
                    "QuoteRequestAndResponseFeature",
                    "FIX_SpecflowTests.Specs.QuoteRequestAndResponseFeature.QuoteRequestForAnInvalidCurrencySymbolReceivesAQuote",
                    "True",
                    "Error",
                    "False",
                    "0.058",
                    "0"
                  ],
                  [
                    "QuoteRequestAndResponseFeature",
                    "FIX_SpecflowTests.Specs.QuoteRequestAndResponseFeature.QuoteRequestForAnInvalidCurrencySymbolReceivesAQuoteRejection",
                    "Success",
                    "True",
                    "True",
                    "0.008",
                    "3"
                  ],
                  [
                    "QuoteRequestAndResponseFeature",
                    "FIX_SpecflowTests.Specs.QuoteRequestAndResponseFeature.QuoteRequestForAValidCurrencySymbolReceivesAQuote",
                    "Success",
                    "True",
                    "True",
                    "0.009",
                    "1"
                  ]
                ]
              }
            }
          ],
          "Tags": [
            "@negative"
          ],
          "Result": {
            "WasExecuted": false,
            "WasSuccessful": false
          }
        },
        {
          "Name": "Load an xml result file and find test cases by test case name",
          "Description": "",
          "Steps": [
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I parse the xml test result file as a test-suite collection"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the following test cases are found for these test suites keyed by \"test case name\":",
              "TableArgument": {
                "HeaderRow": [
                  "test case short name",
                  "test suite name",
                  "test case name",
                  "executed",
                  "result",
                  "success",
                  "time",
                  "asserts"
                ],
                "DataRows": [
                  [
                    "AccessAStaticObjectFromShareContextOneScenarioOne",
                    "ShareContextOneFeature",
                    "Alpari.QualityAssurance.SpecFlowExtensions.Specs.ShareContextOneFeature.AccessAStaticObjectFromShareContextOneScenarioOne",
                    "True",
                    "Success",
                    "True",
                    "0.352",
                    "2"
                  ],
                  [
                    "AccessAStaticObjectFromShareContextOneScenarioTwo",
                    "ShareContextOneFeature",
                    "Alpari.QualityAssurance.SpecFlowExtensions.Specs.ShareContextOneFeature.AccessAStaticObjectFromShareContextOneScenarioTwo",
                    "True",
                    "Success",
                    "True",
                    "0.001",
                    "2"
                  ],
                  [
                    "AccessAStaticObjectFromShareContextTwoScenarioOne",
                    "ShareContextTwoFeature",
                    "Alpari.QualityAssurance.SpecFlowExtensions.Specs.ShareContextTwoFeature.AccessAStaticObjectFromShareContextTwoScenarioOne",
                    "True",
                    "Success",
                    "True",
                    "0.002",
                    "2"
                  ],
                  [
                    "AccessAStaticObjectFromShareContextTwoScenarioTwo",
                    "ShareContextTwoFeature",
                    "Alpari.QualityAssurance.SpecFlowExtensions.Specs.ShareContextTwoFeature.AccessAStaticObjectFromShareContextTwoScenarioTwo",
                    "True",
                    "Success",
                    "True",
                    "0.001",
                    "2"
                  ],
                  [
                    "QuoteRequestForAnInvalidCurrencySymbolReceivesAQuote",
                    "QuoteRequestAndResponseFeature",
                    "FIX_SpecflowTests.Specs.QuoteRequestAndResponseFeature.QuoteRequestForAnInvalidCurrencySymbolReceivesAQuote",
                    "True",
                    "Error",
                    "False",
                    "0.058",
                    "0"
                  ],
                  [
                    "QuoteRequestForAnInvalidCurrencySymbolReceivesAQuoteRejection",
                    "QuoteRequestAndResponseFeature",
                    "FIX_SpecflowTests.Specs.QuoteRequestAndResponseFeature.QuoteRequestForAnInvalidCurrencySymbolReceivesAQuoteRejection",
                    "True",
                    "Success",
                    "True",
                    "0.008",
                    "3"
                  ],
                  [
                    "QuoteRequestForAValidCurrencySymbolReceivesAQuote",
                    "QuoteRequestAndResponseFeature",
                    "FIX_SpecflowTests.Specs.QuoteRequestAndResponseFeature.QuoteRequestForAValidCurrencySymbolReceivesAQuote",
                    "True",
                    "Success",
                    "True",
                    "0.009",
                    "1"
                  ]
                ]
              }
            }
          ],
          "Tags": [
            "@Jira1234"
          ],
          "Result": {
            "WasExecuted": false,
            "WasSuccessful": false
          }
        },
        {
          "Name": "Load an xml result file and find test cases by test case name with some comparsion differences",
          "Description": "",
          "Steps": [
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I parse the xml test result file as a test-suite collection"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the following test cases are found for these test suites keyed by \"test case name\":",
              "TableArgument": {
                "HeaderRow": [
                  "test case short name",
                  "test suite name",
                  "test case name",
                  "executed",
                  "result",
                  "success",
                  "time",
                  "asserts"
                ],
                "DataRows": [
                  [
                    "AccessAStaticObjectFromShareContextOneScenarioOne",
                    "ShareContextOneFeature",
                    "Alpari.QualityAssurance.SpecFlowExtensions.Specs.ShareContextOneFeature.AccessAStaticObjectFromShareContextOneScenarioOne",
                    "True",
                    "Success",
                    "false",
                    "0.352",
                    "2"
                  ],
                  [
                    "AccessAStaticObjectFromShareContextOneScenarioTwo",
                    "dtyjdtyjf",
                    "Alpari.QualityAssurance.SpecFlowExtensions.Specs.ShareContextOneFeature.AccessAStaticObjectFromShareContextOneScenarioTwo",
                    "True",
                    "Success",
                    "True",
                    "0.001",
                    "2"
                  ],
                  [
                    "AccessAStaticObjectFromShareContextTwoScenarioOne",
                    "ShareContextTwoFeature",
                    "Alpari.QualityAssurance.SpecFlowExtensions.Specs.ShareContextTwoFeature.AccessAStaticObjectFromShareContextTwoScenarioOne",
                    "True",
                    "srfjyj",
                    "True",
                    "0.002",
                    "2"
                  ],
                  [
                    "AccessAStaticObjectFromShareContextTwoScenarioTwo",
                    "ShareContextTwoFeature",
                    "Alpari.QualityAssurance.SpecFlowExtensions.Specs.ShareContextTwoFeature.AccessAStaticObjectFromShareContextTwoScenarioTwo",
                    "True",
                    "Success",
                    "True",
                    "0.001",
                    "2"
                  ],
                  [
                    "QuoteRequestForAnInvalidCurrencySymbolReceivesAQuote",
                    "QuoteRequestAndResponseFeature",
                    "FIX_SpecflowTests.Specs.QuoteRequestAndResponseFeature.hwtrhwrjsrtjwrj",
                    "True",
                    "Error",
                    "False",
                    "0.058",
                    "0"
                  ],
                  [
                    "QuoteRequestForAnInvalidCurrencySymbolReceivesAQuoteRejection",
                    "QuoteRequestAndResponseFeature",
                    "FIX_SpecflowTests.Specs.QuoteRequestAndResponseFeature.QuoteRequestForAnInvalidCurrencySymbolReceivesAQuoteRejection",
                    "True",
                    "Success",
                    "True",
                    "0.008",
                    "3"
                  ],
                  [
                    "QuoteRequestForAValidCurrencySymbolReceivesAQuote",
                    "QuoteRequestAndResponseFeature",
                    "FIX_SpecflowTests.Specs.QuoteRequestAndResponseFeature.QuoteRequestForAValidCurrencySymbolReceivesAQuote",
                    "True",
                    "Success",
                    "True",
                    "0.009",
                    "1"
                  ]
                ]
              }
            }
          ],
          "Tags": [
            "@negative"
          ],
          "Result": {
            "WasExecuted": false,
            "WasSuccessful": false
          }
        },
        {
          "Name": "Find a test case by tag name",
          "Description": "",
          "Steps": [
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I parse the xml test result file as a test-suite collection"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the following test cases are found for these test suites keyed by containing a \"tags\" value:",
              "TableArgument": {
                "HeaderRow": [
                  "tags",
                  "test case short name",
                  "test suite name"
                ],
                "DataRows": [
                  [
                    "negative",
                    "QuoteRequestForAnInvalidCurrencySymbolReceivesAQuote",
                    "QuoteRequestAndResponseFeature"
                  ]
                ]
              }
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": false,
            "WasSuccessful": false
          }
        },
        {
          "Name": "Find a test case with a test failure",
          "Description": "",
          "Steps": [
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I parse the xml test result file as a test-suite collection"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the following test cases are found for these test suites keyed by \"test case short name\":",
              "TableArgument": {
                "HeaderRow": [
                  "test case short name",
                  "message"
                ],
                "DataRows": [
                  [
                    "QuoteRequestForAnInvalidCurrencySymbolReceivesAQuote",
                    "System.Collections.Generic.KeyNotFoundException : The given key was not present in the dictionary."
                  ]
                ]
              }
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": false,
            "WasSuccessful": false
          }
        },
        {
          "Name": "Load an xml result file and find culture-info",
          "Description": "",
          "Steps": [
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I parse the xml test result file as culture-info"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "a single culture-info object exists"
            },
            {
              "Keyword": "And",
              "NativeKeyword": "And ",
              "Name": "a culture-info with a \"currentculture\" attribute value of \"en-GB\" exists"
            },
            {
              "Keyword": "And",
              "NativeKeyword": "And ",
              "Name": "a culture-info with a \"currentuiculture\" attribute value of \"en-US\" exists"
            }
          ],
          "Tags": [],
          "Result": {
            "WasExecuted": false,
            "WasSuccessful": false
          }
        }
      ],
      "Background": {
        "Name": "Load Xml to a generic parser",
        "Description": "",
        "Steps": [
          {
            "Keyword": "Given",
            "NativeKeyword": "Given ",
            "Name": "I have an xml test result file",
            "DocStringArgument": "C:\\svn\\local\\BakeryDemoTest\\trunk\\AllBakeryDemoTestProjects\\Alpari.QualityAssurance.SpecFlowExtensions\\TestData\\TestResult.xml"
          }
        ],
        "Tags": [],
        "Result": {
          "WasExecuted": false,
          "WasSuccessful": false
        }
      },
      "Result": {
        "WasExecuted": false,
        "WasSuccessful": false
      },
      "Tags": [
        "@Reporting"
      ]
    },
    "Result": {
      "WasExecuted": false,
      "WasSuccessful": false
    }
  },
  {
    "RelativeFolder": "ShareContextTwo.feature",
    "Feature": {
      "Name": "ShareContextTwo",
      "Description": "In order to do complicated and lengthy setup only once per test run\r\nAs a Test Designer\r\nI want to be able to share context across features",
      "FeatureElements": [
        {
          "Name": "Access a static object from ShareContextTwo ScenarioOne",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Given",
              "NativeKeyword": "Given ",
              "Name": "I access the static object"
            },
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I display the static object \"timeNowIs\" property"
            },
            {
              "Keyword": "And",
              "NativeKeyword": "And ",
              "Name": "I display the static object \"randomFileName\" property"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the static object \"timeNowIs\" property matches the feature \"timeNowIs\" property"
            },
            {
              "Keyword": "And",
              "NativeKeyword": "And ",
              "Name": "the static object \"randomFileName\" property matches the feature \"randomFileName\" property"
            }
          ],
          "Tags": [
            "@selfTestContext"
          ],
          "Result": {
            "WasExecuted": false,
            "WasSuccessful": false
          }
        },
        {
          "Name": "Access a static object from ShareContextTwo ScenarioTwo",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Given",
              "NativeKeyword": "Given ",
              "Name": "I access the static object"
            },
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I display the static object \"timeNowIs\" property"
            },
            {
              "Keyword": "And",
              "NativeKeyword": "And ",
              "Name": "I display the static object \"randomFileName\" property"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the static object \"timeNowIs\" property matches the feature \"timeNowIs\" property"
            },
            {
              "Keyword": "And",
              "NativeKeyword": "And ",
              "Name": "the static object \"randomFileName\" property matches the feature \"randomFileName\" property"
            }
          ],
          "Tags": [
            "@selfTestContext"
          ],
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
  },
  {
    "RelativeFolder": "ShareContextOne.feature",
    "Feature": {
      "Name": "ShareContextOne",
      "Description": "In order to do complicated and lengthy setup only once per test run\r\nAs a Test Designer\r\nI want to be able to share context across features",
      "FeatureElements": [
        {
          "Name": "Access a static object from ShareContextOne ScenarioOne",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Given",
              "NativeKeyword": "Given ",
              "Name": "I access the static object"
            },
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I display the static object \"timeNowIs\" property"
            },
            {
              "Keyword": "And",
              "NativeKeyword": "And ",
              "Name": "I display the static object \"randomFileName\" property"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the static object \"timeNowIs\" property matches the feature \"timeNowIs\" property"
            },
            {
              "Keyword": "And",
              "NativeKeyword": "And ",
              "Name": "the static object \"randomFileName\" property matches the feature \"randomFileName\" property"
            }
          ],
          "Tags": [
            "@selfTestContext"
          ],
          "Result": {
            "WasExecuted": false,
            "WasSuccessful": false
          }
        },
        {
          "Name": "Access a static object from ShareContextOne ScenarioTwo",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Given",
              "NativeKeyword": "Given ",
              "Name": "I access the static object"
            },
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I display the static object \"timeNowIs\" property"
            },
            {
              "Keyword": "And",
              "NativeKeyword": "And ",
              "Name": "I display the static object \"randomFileName\" property"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the static object \"timeNowIs\" property matches the feature \"timeNowIs\" property"
            },
            {
              "Keyword": "And",
              "NativeKeyword": "And ",
              "Name": "the static object \"randomFileName\" property matches the feature \"randomFileName\" property"
            }
          ],
          "Tags": [
            "@selfTestContext"
          ],
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
  },
  {
    "RelativeFolder": "EnableCrossStepDefinitionCallsOne.feature",
    "Feature": {
      "Name": "EnableCrossStepDefinitionCallsOne",
      "Description": "In order to avoid circular dependencies\r\nAs a Test Designer\r\nI want to be able to store and retrieve references to step definitions via the scenario context",
      "FeatureElements": [
        {
          "Name": "A lazy write once property set in an earlier call to a step def remains the same value after subsequent calls to the same step def",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Given",
              "NativeKeyword": "Given ",
              "Name": "I have called a method which sets a lazy property in step definition file one"
            },
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I call a method in step definition two that calls the same method in step definition file one"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "The current and new lazy property values are the same"
            }
          ],
          "Tags": [
            "@mytag"
          ],
          "Result": {
            "WasExecuted": false,
            "WasSuccessful": false
          }
        },
        {
          "Name": "A call to a step def via another step def when the called step def has not been directly instantiated",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Given",
              "NativeKeyword": "Given ",
              "Name": "I create an instance of step definition one from step definition two"
            },
            {
              "Keyword": "And",
              "NativeKeyword": "And ",
              "Name": "I call a method in step definition two that calls the same method in step definition file one"
            },
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I call a method in step definition two that calls the same method in step definition file one"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "The current and new lazy property values are the same"
            }
          ],
          "Tags": [
            "@mytag"
          ],
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
  },
  {
    "RelativeFolder": "CreateMixtureOfTestResults002.feature",
    "Feature": {
      "Name": "CreateMixtureOfTestResults002",
      "Description": "In order to prove test text results can be matched to test xml results in a different order\r\nAs a test engineer\r\nI want to generate a spread of test results of diiferent types",
      "FeatureElements": [
        {
          "Name": "Passing test one",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Given",
              "NativeKeyword": "Given ",
              "Name": "I access the static object"
            },
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I display the static object \"randomFileName\" property"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the static object \"randomFileName\" property matches the feature \"randomFileName\" property"
            }
          ],
          "Tags": [
            "@TES_81",
            "@UAT"
          ],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": true
          }
        },
        {
          "Name": "Pending test one two",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Given",
              "NativeKeyword": "Given ",
              "Name": "I access the static object"
            },
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I call an undefined step"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the static object \"randomFileName\" property matches the feature \"randomFileName\" property"
            }
          ],
          "Tags": [
            "@TES_83",
            "@negative",
            "@UAT"
          ],
          "Result": {
            "WasExecuted": false,
            "WasSuccessful": false
          }
        },
        {
          "Name": "Passing test one two",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Given",
              "NativeKeyword": "Given ",
              "Name": "I access the static object"
            },
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I display the static object \"randomFileName\" property"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the static object \"randomFileName\" property matches the feature \"randomFileName\" property"
            }
          ],
          "Tags": [
            "@TES_82",
            "@UAT"
          ],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": true
          }
        },
        {
          "Name": "Pending test two two",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Given",
              "NativeKeyword": "Given ",
              "Name": "I access the static object"
            },
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I call a pending step"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the static object \"randomFileName\" property matches the feature \"randomFileName\" property"
            }
          ],
          "Tags": [
            "@TES_84",
            "@negative",
            "@UAT"
          ],
          "Result": {
            "WasExecuted": false,
            "WasSuccessful": false
          }
        },
        {
          "Name": "failing test one",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Given",
              "NativeKeyword": "Given ",
              "Name": "I access the static object"
            },
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I call a failing step"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the static object \"randomFileName\" property matches the feature \"randomFileName\" property"
            }
          ],
          "Tags": [
            "@TES_85",
            "@negative",
            "@UAT"
          ],
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
        "@textToXmlReconciliation"
      ]
    },
    "Result": {
      "WasExecuted": true,
      "WasSuccessful": false
    }
  },
  {
    "RelativeFolder": "CreateMixtureOfTestResults001.feature",
    "Feature": {
      "Name": "CreateMixtureOfTestResults001",
      "Description": "In order to prove test text results can be matched to test xml results\r\nAs a test engineer\r\nI want to generate a spread of test results of diiferent types",
      "FeatureElements": [
        {
          "Name": "Passing test one",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Given",
              "NativeKeyword": "Given ",
              "Name": "I access the static object"
            },
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I display the static object \"randomFileName\" property"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the static object \"randomFileName\" property matches the feature \"randomFileName\" property"
            }
          ],
          "Tags": [
            "@TES_77",
            "@UAT"
          ],
          "Result": {
            "WasExecuted": true,
            "WasSuccessful": true
          }
        },
        {
          "Name": "Pending test one",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Given",
              "NativeKeyword": "Given ",
              "Name": "I access the static object"
            },
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I call an undefined step"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the static object \"randomFileName\" property matches the feature \"randomFileName\" property"
            }
          ],
          "Tags": [
            "@TES_78",
            "@negative",
            "@UAT"
          ],
          "Result": {
            "WasExecuted": false,
            "WasSuccessful": false
          }
        },
        {
          "Name": "Pending test two",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Given",
              "NativeKeyword": "Given ",
              "Name": "I access the static object"
            },
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I call a pending step"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the static object \"randomFileName\" property matches the feature \"randomFileName\" property"
            }
          ],
          "Tags": [
            "@TES_79",
            "@negative",
            "@UAT"
          ],
          "Result": {
            "WasExecuted": false,
            "WasSuccessful": false
          }
        },
        {
          "Name": "failing test one",
          "Description": "",
          "Steps": [
            {
              "Keyword": "Given",
              "NativeKeyword": "Given ",
              "Name": "I access the static object"
            },
            {
              "Keyword": "When",
              "NativeKeyword": "When ",
              "Name": "I call a failing step"
            },
            {
              "Keyword": "Then",
              "NativeKeyword": "Then ",
              "Name": "the static object \"randomFileName\" property matches the feature \"randomFileName\" property"
            }
          ],
          "Tags": [
            "@TES_80",
            "@negative",
            "@UAT"
          ],
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
        "@textToXmlReconciliation"
      ]
    },
    "Result": {
      "WasExecuted": true,
      "WasSuccessful": false
    }
  }
]);