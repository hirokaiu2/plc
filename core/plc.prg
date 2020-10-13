if 0_startButton and (not 1_wpPresent) and (not 2_fwLimit) and 3_bwLimit and 4_openComplete
	Set(5_opLamp)
if (not 0_startButton) and 1_wpPresent and (not 2_fwLimit) and 3_bwLimit and 4_openComplete
	Set(6_moveFw)
if (not 0_startButton) and 1_wpPresent and 2_fwLimit and (not 3_bwLimit) and (not 4_openComplete)
	Reset(6_moveFw)
	Set(8_pushFw)
if (not 0_startButton) and (not 1_wpPresent) and 2_fwLimit and (not 3_bwLimit) and (not 4_openComplete)
	Reset(8_pushFw)
	Set(9_pushBw)
if (not 0_startButton) and (not 1_wpPresent) and 2_fwLimit and (not 3_bwLimit) and 4_openComplete
	Set(7_moveBw)
	Reset(9_pushBw)
if (not 0_startButton) and (not 1_wpPresent) and (not 2_fwLimit) and 3_bwLimit and 4_openComplete
	Reset(5_opLamp)
	Reset(7_moveBw)
