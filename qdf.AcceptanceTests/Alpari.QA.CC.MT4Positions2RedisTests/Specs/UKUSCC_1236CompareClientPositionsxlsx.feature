@UKUSCC_1236 
Feature: UKUSCC_1236CompareClientPositionsXlsx
	In order to find discrepancies in redis and ars open positions
	As a CC tester
	I want to compare cc_sp_get_client_positions between cc@master and cc_uat@slave3
	#test
	#requires http://www.microsoft.com/en-gb/download/details.aspx?id=23734 a copy is saved in lib\2007OfficeSystemDriverDataConnectivityComponents

Scenario: Compare C1 Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                               | ArsPositionsFile                                                                  |
	| C:\Users\dgalloway\Downloads\Positions_Redis_MT4AUKC01_3006_20141127_091502.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_AUKC01_6_20141127_091506.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare C2 Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                               | ArsPositionsFile                                                                   |
	| C:\Users\dgalloway\Downloads\Positions_Redis_MT4AUKC02_3046_20141127_091927.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_AUKC02_46_20141127_091855.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |
#
Scenario: Compare B2B Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                                | ArsPositionsFile                                                                    |
	| C:\Users\dgalloway\Downloads\Positions_Redis_MT4AUKB2B1_3074_20141127_104211.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_AUKB2B1_74_20141127_104211.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |
#
Scenario: Compare JPN Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                             | ArsPositionsFile                                                                  |
	| C:\Users\dgalloway\Downloads\Positions_Redis_MT4JPC01_3004_20141127_090732.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_ajpc01_4_20141127_090809.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |


Scenario: Compare CBOJ Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                               | ArsPositionsFile                                                                 |
	| C:\Users\dgalloway\Downloads\Positions_Redis_MT4AUKCBJ_3057_20141127_104013.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_cboj_57_20141127_104014.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |
#
Scenario: Compare MT4AUKM01 Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                               | ArsPositionsFile                                                                   |
	| C:\Users\dgalloway\Downloads\Positions_Redis_MT4AUKM01_3047_20141127_095414.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_aukm01_47_20141127_095404.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare MT4AUKM02 Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                               | ArsPositionsFile                                                                   |
	| C:\Users\dgalloway\Downloads\Positions_Redis_MT4AUKM02_3048_20141127_100115.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_aukm02_48_20141127_100122.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare MT4AUKPO1 Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                               | ArsPositionsFile                                                                   |
	| C:\Users\dgalloway\Downloads\Positions_Redis_MT4AUKP01_3049_20141127_100545.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_AUKP01_49_20141127_100552.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |
#
Scenario: Compare MT4AUKMARKET1 Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                                   | ArsPositionsFile                                                                       |
	| C:\Users\dgalloway\Downloads\Positions_Redis_MT4AUKMARKET1_3089_20141127_104404.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_AUKMarket1_89_20141127_104401.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |
#
Scenario: Compare MT4AUKMARKETMENA Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                                      | ArsPositionsFile                                                                          |
	| C:\Users\dgalloway\Downloads\Positions_Redis_MT4AUKMARKETMENA_3090_20141127_105336.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_AUKMarketMENA_90_20141127_105329.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |
#
Scenario: Compare MT4AUKSB1 Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                               | ArsPositionsFile                                                                   |
	| C:\Users\dgalloway\Downloads\Positions_Redis_MT4AUKSB1_3053_20141127_103756.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_AUKSB1_53_20141127_103806.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare ADS Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                              | ArsPositionsFile                                                                |
	| C:\Users\dgalloway\Downloads\Positions_Redis_uk_ADS_R_1201_20141127_110735.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_uk_ADS_201_20141127_110730.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare ASV Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                              | ArsPositionsFile                                                                |
	| C:\Users\dgalloway\Downloads\Positions_Redis_uk_ASV_R_1202_20141127_111000.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_uk_ASV_202_20141127_111000.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare MSCov Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                                   | ArsPositionsFile                                                                     |
	| C:\Users\dgalloway\Downloads\Positions_Redis_uk_Coverage_R_1203_20141127_111138.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_uk_Coverage_203_20141127_111136.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare ADS STP Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                                  | ArsPositionsFile                                                                    |
	| C:\Users\dgalloway\Downloads\Positions_Redis_uk_ADS_STP_R_1204_20141127_111337.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_uk_ADS_STP_204_20141127_111336.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare ADS CFD Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                                  | ArsPositionsFile                                                                    |
	| C:\Users\dgalloway\Downloads\Positions_Redis_uk_ADS_CFD_R_1206_20141127_111815.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_uk_ADS_CFD_206_20141127_111815.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare FXCM Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                               | ArsPositionsFile                                                                 |
	| C:\Users\dgalloway\Downloads\Positions_Redis_uk_FXCM_R_1210_20141127_112013.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_uk_FXCM_208_20141127_112011.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |