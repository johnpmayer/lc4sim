.code
	.addr x0
	const r0, x0
	brn FAIL
	brp FAIL
	brnp FAIL
	brz PASS
FAIL:	nop
	nop
PASS:	nop