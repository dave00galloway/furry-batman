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
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_ajpc01_4_20141201_164121.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_ajpc01_4_20141201_164144.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare C1 Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                               | ArsPositionsFile                                                                  |
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_AUKC01_6_20141201_164456.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_AUKC01_6_20141201_164458.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare C2 Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                              | ArsPositionsFile                                                                   |
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_AUKC02_46_20141201_164637.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_AUKC02_46_20141201_164720.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |
#
Scenario: Compare MT4AUKM01 Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                              | ArsPositionsFile                                                                   |
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_aukm01_47_20141201_165102.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_aukm01_47_20141201_165045.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare MT4AUKM02 Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                              | ArsPositionsFile                                                                   |
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_aukm02_48_20141201_165524.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_aukm02_48_20141201_165551.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare MT4AUKPO1 Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                              | ArsPositionsFile                                                                   |
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_AUKP01_49_20141201_165633.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_AUKP01_49_20141201_165634.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare MT4AUKSB1 Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                              | ArsPositionsFile                                                                   |
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_AUKSB1_53_20141201_165720.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_AUKSB1_53_20141201_165723.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare CBOJ Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                            | ArsPositionsFile                                                                 |
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_cboj_57_20141201_170132.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_cboj_57_20141201_170130.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare B2B Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                               | ArsPositionsFile                                                                    |
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_AUKB2B1_74_20141201_164815.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_AUKB2B1_74_20141201_164815.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |
#
Scenario: Compare MT4AUKMARKET1 Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                                  | ArsPositionsFile                                                                       |
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_AUKMarket1_89_20141201_170310.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_AUKMarket1_89_20141201_170327.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |
#
Scenario: Compare MT4AUKMARKETMENA Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                                     | ArsPositionsFile                                                                          |
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_AUKMarketMENA_90_20141201_171708.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_AUKMarketMENA_90_20141201_171707.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare ADS Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                           | ArsPositionsFile                                                                |
	| C:\Users\dgalloway\Downloads\Positions_Redis_uk_ADS_201_20141201_172245.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_uk_ADS_201_20141201_172244.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare ASV Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                           | ArsPositionsFile                                                                |
	| C:\Users\dgalloway\Downloads\Positions_Redis_uk_ASV_202_20141201_172327.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_uk_ASV_202_20141201_172325.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare MSCov Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                                | ArsPositionsFile                                                                     |
	| C:\Users\dgalloway\Downloads\Positions_Redis_uk_Coverage_203_20141201_172400.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_uk_Coverage_203_20141201_172358.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare ADS STP Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                               | ArsPositionsFile                                                                    |
	| C:\Users\dgalloway\Downloads\Positions_Redis_uk_ADS_STP_204_20141201_172450.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_uk_ADS_STP_204_20141201_172447.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare ADS CFD Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                               | ArsPositionsFile                                                                    |
	| C:\Users\dgalloway\Downloads\Positions_Redis_uk_ADS_CFD_206_20141201_172540.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_uk_ADS_CFD_206_20141201_172537.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare FXCM Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                            | ArsPositionsFile                                                                 |
	| C:\Users\dgalloway\Downloads\Positions_Redis_uk_FXCM_208_20141201_172621.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_uk_FXCM_208_20141201_172616.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |