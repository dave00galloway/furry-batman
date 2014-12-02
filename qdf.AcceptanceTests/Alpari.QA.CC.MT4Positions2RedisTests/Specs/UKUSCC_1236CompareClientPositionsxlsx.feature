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
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_ajpc01_4_20141202_142957.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_ajpc01_4_20141202_142944.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare C1 Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                               | ArsPositionsFile                                                                  |
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_AUKC01_6_20141202_143636.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_AUKC01_6_20141202_143639.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare C2 Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                              | ArsPositionsFile                                                                   |
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_AUKC02_46_20141202_143810.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_AUKC02_46_20141202_143847.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |
#
Scenario: Compare MT4AUKM01 Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                              | ArsPositionsFile                                                                   |
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_aukm01_47_20141202_143957.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_aukm01_47_20141202_144010.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare MT4AUKM02 Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                              | ArsPositionsFile                                                                   |
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_aukm02_48_20141202_145235.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_aukm02_48_20141202_145301.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare MT4AUKPO1 Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                              | ArsPositionsFile                                                                   |
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_AUKP01_49_20141202_145356.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_AUKP01_49_20141202_145359.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare MT4AUKSB1 Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                              | ArsPositionsFile                                                                   |
	| C:\Users\dgalloway\Downloads\Positions_Database_ars_AUKSB1_53_20141202_145449.xlsx | C:\Users\dgalloway\Downloads\Positions_Redis_ars_AUKSB1_53_20141202_145446.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare CBOJ Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                            | ArsPositionsFile                                                                 |
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_cboj_57_20141202_145920.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_cboj_57_20141202_145918.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare B2B Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                               | ArsPositionsFile                                                                    |
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_AUKB2B1_74_20141202_145957.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_AUKB2B1_74_20141202_145955.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |
#
Scenario: Compare MT4AUKMARKET1 Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                                  | ArsPositionsFile                                                                       |
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_AUKMarket1_89_20141202_150049.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_AUKMarket1_89_20141202_150106.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |
#
Scenario: Compare MT4AUKMARKETMENA Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                                     | ArsPositionsFile                                                                          |
	| C:\Users\dgalloway\Downloads\Positions_Redis_ars_AUKMarketMENA_90_20141202_150323.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_ars_AUKMarketMENA_90_20141202_150323.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare ADS Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                           | ArsPositionsFile                                                                |
	| C:\Users\dgalloway\Downloads\Positions_Redis_uk_ADS_201_20141202_151003.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_uk_ADS_201_20141202_151000.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare ASV Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                           | ArsPositionsFile                                                                |
	| C:\Users\dgalloway\Downloads\Positions_Redis_uk_ASV_202_20141202_151052.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_uk_ASV_202_20141202_151050.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare MSCov Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                                | ArsPositionsFile                                                                     |
	| C:\Users\dgalloway\Downloads\Positions_Redis_uk_Coverage_203_20141202_151130.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_uk_Coverage_203_20141202_151127.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare ADS STP Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                               | ArsPositionsFile                                                                    |
	| C:\Users\dgalloway\Downloads\Positions_Redis_uk_ADS_STP_204_20141202_151209.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_uk_ADS_STP_204_20141202_151207.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare ADS CFD Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                               | ArsPositionsFile                                                                    |
	| C:\Users\dgalloway\Downloads\Positions_Redis_uk_ADS_CFD_206_20141202_151240.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_uk_ADS_CFD_206_20141202_151236.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |

Scenario: Compare FXCM Client Positions
	When I compare cc redis and cc ars client position data from xlsx:-
	| RedisPositionsFile                                                            | ArsPositionsFile                                                                 |
	| C:\Users\dgalloway\Downloads\Positions_Redis_uk_FXCM_208_20141202_151332.xlsx | C:\Users\dgalloway\Downloads\Positions_Database_uk_FXCM_208_20141202_151331.xlsx |
	Then the redis positions should match the ars positions exactly:-
		| ExportType     |  Overwrite |
		| DataTableToCsv |  true      |