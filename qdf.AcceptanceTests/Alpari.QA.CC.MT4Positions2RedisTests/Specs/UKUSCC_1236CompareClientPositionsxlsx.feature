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
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_ajpc01_4_20141204_134737.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_ajpc01_4_20141204_134715.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare C1 Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                             | ArsPositionsFile                                                                  |
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_AUKC01_6_20141204_134800.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_AUKC01_6_20141204_134801.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare C2 Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                              | ArsPositionsFile                                                                   |
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_AUKC02_46_20141208_125607.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_AUKC02_46_20141208_125526.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |
#
Scenario: Compare MT4AUKM01 Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                              | ArsPositionsFile                                                                   |
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_aukm01_47_20141204_135751.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_aukm01_47_20141204_135804.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare MT4AUKM02 Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                              | ArsPositionsFile                                                                   |
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_aukm02_48_20141204_141128.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_aukm02_48_20141204_141150.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare MT4AUKPO1 Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                              | ArsPositionsFile                                                                   |
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_AUKP01_49_20141204_141530.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_AUKP01_49_20141204_141530.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare MT4AUKSB1 Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                              | ArsPositionsFile                                                                   |
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_AUKSB1_53_20141204_142146.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_AUKSB1_53_20141204_142148.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare CBOJ Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                            | ArsPositionsFile                                                                 |
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_cboj_57_20141204_142420.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_cboj_57_20141204_142419.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare B2B Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                               | ArsPositionsFile                                                                    |
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_AUKB2B1_74_20141204_142522.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_AUKB2B1_74_20141204_142522.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |
#
Scenario: Compare MT4AUKMARKET1 Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                                  | ArsPositionsFile                                                                       |
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_AUKMarket1_89_20141208_104312.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_AUKMarket1_89_20141208_104302.xlsx |
#	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_AUKMarket1_89_20141204_142620.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_AUKMarket1_89_20141204_142637.xlsx |

	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |
#
Scenario: Compare MT4AUKMARKETMENA Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                                     | ArsPositionsFile                                                                       |
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_AUKMarketMENA_90_20141204_151831.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_AUKMarketMENA_90_20141204_151831.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare ADS Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                           | ArsPositionsFile                                                                |
	| C:\Users\dgalloway\Downloads\Positions_Redis_uk_ADS_201_20141203_163604.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_uk_ADS_201_20141203_163604.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare ASV Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                           | ArsPositionsFile                                                                |
	| C:\Users\dgalloway\Downloads\Positions_Redis_uk_ASV_202_20141203_163649.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_uk_ASV_202_20141203_163648.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare MSCov Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                                | ArsPositionsFile                                                                     |
	| C:\Users\dgalloway\Downloads\Positions_Redis_uk_Coverage_203_20141203_163731.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_uk_Coverage_203_20141203_163734.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare ADS STP Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                               | ArsPositionsFile                                                                    |
	| C:\Users\dgalloway\Downloads\Positions_Redis_uk_ADS_STP_204_20141204_152213.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_uk_ADS_STP_204_20141204_152210.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare ADS CFD Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                               | ArsPositionsFile                                                                    |
	| C:\Users\dgalloway\Downloads\Positions_Redis_uk_ADS_CFD_206_20141203_163937.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_uk_ADS_CFD_206_20141203_163941.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare FXCM Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                            | ArsPositionsFile                                                                 |
	| C:\Users\dgalloway\Downloads\Positions_Redis_uk_FXCM_208_20141204_152312.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_uk_FXCM_208_20141204_152309.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |