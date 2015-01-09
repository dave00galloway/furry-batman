@UKUSCC_1236 
Feature: UKUSCC_1236CompareClientPositionsXlsx
	In order to find discrepancies in redis and ars open positions
	As a CC tester
	I want to compare cc_sp_get_client_positions between cc@master and cc_uat@slave3
	#test
	#requires http://www.microsoft.com/en-gb/download/details.aspx?id=23734 a copy is saved in lib\2007OfficeSystemDriverDataConnectivityComponents

#
Scenario: Compare JPN Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                             | ArsPositionsFile                                                                  |
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_ajpc01_4_20150109_104232.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_ajpc01_4_20150109_104308.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare C1 Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                             | ArsPositionsFile                                                                  |
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_AUKC01_6_20150109_104339.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_AUKC01_6_20150109_104345.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare C2 Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                              | ArsPositionsFile                                                                   |
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_AUKC02_46_20150109_104606.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_AUKC02_46_20150109_104721.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |
#
Scenario: Compare MT4AUKM01 Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                              | ArsPositionsFile                                                                   |
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_aukm01_47_20150109_104813.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_aukm01_47_20150109_104835.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare MT4AUKM02 Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                              | ArsPositionsFile                                                                   |
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_aukm02_48_20150109_104944.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_aukm02_48_20150109_105024.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare MT4AUKPO1 Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                              | ArsPositionsFile                                                                   |
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_AUKP01_49_20150109_105102.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_AUKP01_49_20150109_105108.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare MT4AUKSB1 Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                              | ArsPositionsFile                                                                   |
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_AUKSB1_53_20150109_105219.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_AUKSB1_53_20150109_105228.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare CBOJ Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                            | ArsPositionsFile                                                                 |
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_cboj_57_20150109_105253.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_cboj_57_20150109_105252.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare B2B Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                               | ArsPositionsFile                                                                    |
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_AUKB2B1_74_20150109_105330.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_AUKB2B1_74_20150109_105330.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |
#
Scenario: Compare MT4AUKMARKET1 Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                                  | ArsPositionsFile                                                                       |
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_AUKMarket1_89_20150109_105432.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_AUKMarket1_89_20150109_105459.xlsx |

	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |
#
Scenario: Compare MT4AUKMARKETMENA Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                                     | ArsPositionsFile                                                                       |
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_AUKMarketMENA_90_20150109_105542.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_AUKMarketMENA_90_20150109_105549.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare ADS Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                           | ArsPositionsFile                                                                |
	| C:\Users\dgalloway\Downloads\Positions_Redis_uk_ADS_201_20150109_105658.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_uk_ADS_201_20150109_105657.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare ASV Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                           | ArsPositionsFile                                                                |
	| C:\Users\dgalloway\Downloads\Positions_Redis_uk_ASV_202_20150109_105741.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_uk_ASV_202_20150109_105740.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare MSCov Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                                | ArsPositionsFile                                                                     |
	| C:\Users\dgalloway\Downloads\Positions_Redis_uk_Coverage_203_20150109_105810.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_uk_Coverage_203_20150109_105809.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare ADS STP Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                               | ArsPositionsFile                                                                    |
	| C:\Users\dgalloway\Downloads\Positions_Redis_uk_ADS_STP_204_20150109_105839.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_uk_ADS_STP_204_20150109_105839.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare ADS CFD Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                               | ArsPositionsFile                                                                    |
	| C:\Users\dgalloway\Downloads\Positions_Database_uk_ADS_CFD_206_20150109_105925.xlsx | C:\Users\dgalloway\Downloads\Positions_Redis_uk_ADS_CFD_206_20150109_105926.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare FXCM Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                            | ArsPositionsFile                                                                 |
	| C:\Users\dgalloway\Downloads\Positions_Redis_uk_FXCM_208_20150109_105959.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_uk_FXCM_208_20150109_105958.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |