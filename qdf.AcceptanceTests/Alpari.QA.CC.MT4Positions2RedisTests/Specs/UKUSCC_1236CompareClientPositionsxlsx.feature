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
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_ajpc01_4_20141218_135613.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_ajpc01_4_20141218_135642.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare C1 Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                             | ArsPositionsFile                                                                  |
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_AUKC01_6_20141218_140044.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_AUKC01_6_20141218_140046.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare C2 Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                              | ArsPositionsFile                                                                   |
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_AUKC02_46_20141218_140210.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_AUKC02_46_20141218_140310.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |
#
Scenario: Compare MT4AUKM01 Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                                 | ArsPositionsFile                                                                |
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_aukm01_47_20141218_140723.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_aukm01_47_20141218_140737.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare MT4AUKM02 Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                              | ArsPositionsFile                                                                   |
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_aukm02_48_20141218_141347.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_aukm02_48_20141218_141416.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare MT4AUKPO1 Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                              | ArsPositionsFile                                                                   |
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_AUKP01_49_20141218_141612.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_AUKP01_49_20141218_141615.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare MT4AUKSB1 Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                              | ArsPositionsFile                                                                   |
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_AUKSB1_53_20141218_141700.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_AUKSB1_53_20141218_141707.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare CBOJ Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                            | ArsPositionsFile                                                                 |
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_cboj_57_20141218_141744.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_cboj_57_20141218_141744.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare B2B Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                               | ArsPositionsFile                                                                    |
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_AUKB2B1_74_20141218_141826.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_AUKB2B1_74_20141218_141827.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |
#
Scenario: Compare MT4AUKMARKET1 Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                                  | ArsPositionsFile                                                                       |
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_AUKMarket1_89_20141218_141914.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_AUKMarket1_89_20141218_141933.xlsx |
#	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_AUKMarket1_89_20141204_142620.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_AUKMarket1_89_20141204_142637.xlsx |

	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |
#
Scenario: Compare MT4AUKMARKETMENA Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                                     | ArsPositionsFile                                                                       |
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_AUKMarketMENA_90_20141218_142004.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_AUKMarketMENA_90_20141218_142008.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare ADS Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                           | ArsPositionsFile                                                                |
	| C:\Users\dgalloway\Downloads\Positions_Redis_uk_ADS_201_20141218_142234.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_uk_ADS_201_20141218_142234.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare ASV Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                           | ArsPositionsFile                                                                |
	| C:\Users\dgalloway\Downloads\Positions_Redis_uk_ASV_202_20141218_142516.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_uk_ASV_202_20141218_142514.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare MSCov Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                                | ArsPositionsFile                                                                     |
	| C:\Users\dgalloway\Downloads\Positions_Redis_uk_Coverage_203_20141218_142601.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_uk_Coverage_203_20141218_142601.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare ADS STP Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                               | ArsPositionsFile                                                                    |
	| C:\Users\dgalloway\Downloads\Positions_Redis_uk_ADS_STP_204_20141218_142637.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_uk_ADS_STP_204_20141218_142637.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare ADS CFD Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                               | ArsPositionsFile                                                                    |
	| C:\Users\dgalloway\Downloads\Positions_Redis_uk_ADS_CFD_206_20141218_142716.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_uk_ADS_CFD_206_20141218_142715.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare FXCM Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                            | ArsPositionsFile                                                                 |
	| C:\Users\dgalloway\Downloads\Positions_Redis_uk_FXCM_208_20141218_142747.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_uk_FXCM_208_20141218_142744.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |