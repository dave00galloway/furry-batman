Feature: CryptoTests
	In order to protect passwords
	As a concerned it user
	I want to be able to secure my credentials

@mytag
Scenario: Encypt and Decrypt Password
	Given my unencypted password is "password"
	When encypt my password
	And I decrypt the encrypted password
	Then the decrypted password is "password"

Scenario: Encypt and Decrypt complex Password
	Given my unencypted password is "server=10.25.9.213;user id=ars;password=1q2w3e;port=3306;database=cc"
	When encypt my password
	And I decrypt the encrypted password
	Then the decrypted password is "server=10.25.9.213;user id=ars;password=1q2w3e;port=3306;database=cc"

Scenario: Direct Encypt and Decrypt Password
	Given my unencrypted password is "password"
	When I directly encrypt my password
	And I directly decrypt the encrypted password
	Then the decrypted password is "password"

Scenario: Direct Encypt and Decrypt complex Password
	Given my unencypted password is "server=10.25.9.213;user id=ars;password=1q2w3e;port=3306;database=cc"
	When encypt my password
	And I decrypt the encrypted password
	Then the decrypted password is "server=10.25.9.213;user id=ars;password=1q2w3e;port=3306;database=cc"

Scenario: Direct Decrypt complex Password
	Given my encrypted password is "1-0-0-0-208-140-157-223-1-21-209-17-140-122-0-192-79-194-151-235-1-0-0-0-13-245-5-48-90-188-159-68-139-87-217-81-43-30-196-135-0-0-0-0-2-0-0-0-0-0-3-102-0-0-192-0-0-0-16-0-0-0-55-80-201-201-1-50-209-112-34-132-130-147-230-183-100-118-0-0-0-0-4-128-0-0-160-0-0-0-16-0-0-0-93-51-247-192-205-5-134-215-44-213-61-184-232-21-130-192-72-0-0-0-241-90-230-235-188-172-166-89-249-171-59-98-199-126-142-87-185-176-247-34-152-255-165-99-62-252-153-246-86-217-198-162-189-64-222-163-176-135-33-241-209-68-236-146-8-216-80-7-9-120-39-18-35-72-223-147-153-104-66-232-39-201-212-166-77-63-252-171-61-149-25-137-20-0-0-0-130-229-133-157-179-54-159-143-162-94-7-224-39-234-16-57-171-23-215-212"
	When I decrypt the encrypted password
	Then the decrypted password is "server=10.25.9.213;user id=ars;password=1q2w3e;port=3306;database=cc"

	#1_0_0_0_208_140_157_223_1_21_209_17_140_122_0_192_79_194_151_235_1_0_0_0_172_198_26_117_175_63_187_79_178_230_134_99_10_24_16_126_0_0_0_0_2_0_0_0_0_0_3_102_0_0_192_0_0_0_16_0_0_0_48_248_225_198_130_185_183_172_64_153_162_118_74_112_190_76_0_0_0_0_4_128_0_0_160_0_0_0_16_0_0_0_196_195_98_213_142_128_104_68_75_153_104_42_194_24_99_247_136_0_0_0_96_207_124_92_120_211_60_171_59_109_245_20_58_227_77_240_166_118_51_224_111_115_19_54_224_235_179_157_149_30_73_94_212_58_42_139_119_197_50_231_169_243_235_68_197_20_62_206_201_194_155_148_60_138_239_245_111_71_1_254_28_31_25_111_88_238_188_53_115_173_7_95_145_131_30_62_223_27_16_2_224_146_11_110_171_219_16_202_246_157_248_33_24_237_8_90_170_3_248_205_225_218_78_16_74_132_15_89_157_176_204_203_214_218_71_146_90_251_227_245_255_241_11_36_38_199_8_43_144_81_254_238_235_123_123_136_20_0_0_0_55_84_236_249_10_53_173_156_186_158_111_177_209_9_54_125_106_56_16_132
Scenario: Direct Decrypt complex Password2
	Given my encrypted password is "1-0-0-0-208-140-157-223-1-21-209-17-140-122-0-192-79-194-151-235-1-0-0-0-172-198-26-117-175-63-187-79-178-230-134-99-10-24-16-126-0-0-0-0-2-0-0-0-0-0-3-102-0-0-192-0-0-0-16-0-0-0-48-248-225-198-130-185-183-172-64-153-162-118-74-112-190-76-0-0-0-0-4-128-0-0-160-0-0-0-16-0-0-0-196-195-98-213-142-128-104-68-75-153-104-42-194-24-99-247-136-0-0-0-96-207-124-92-120-211-60-171-59-109-245-20-58-227-77-240-166-118-51-224-111-115-19-54-224-235-179-157-149-30-73-94-212-58-42-139-119-197-50-231-169-243-235-68-197-20-62-206-201-194-155-148-60-138-239-245-111-71-1-254-28-31-25-111-88-238-188-53-115-173-7-95-145-131-30-62-223-27-16-2-224-146-11-110-171-219-16-202-246-157-248-33-24-237-8-90-170-3-248-205-225-218-78-16-74-132-15-89-157-176-204-203-214-218-71-146-90-251-227-245-255-241-11-36-38-199-8-43-144-81-254-238-235-123-123-136-20-0-0-0-55-84-236-249-10-53-173-156-186-158-111-177-209-9-54-125-106-56-16-132"
	When I decrypt the encrypted password
	Then the decrypted password is "server=10.25.9.213;user id=ars;password=1q2w3e;port=3306;database=cc"
