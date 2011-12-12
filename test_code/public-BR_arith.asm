.CODE
.ADDR 0

CONST R1, #3
BRp POSITIVE

NOP ; shouldn't go here

POSITIVE:
	ADD R3, R1, #-7	
	BRnz NEGATIVE ; R3 = -4

NOP ; shouldn't go here

NEGATIVE:
	MUL R1, R3, R1
	BRn SUBTRACT ; R1 = -12

DIV R1, R3, R3; shouldn't go here

SUBTRACT:
	SUB R3, R3, R3
	BRz ZERO	; R3 = 0

NOP ; shouldn't go here

ZERO:
	DIV R1, R3, R1 
	BRnp WRONG_END ; R1 = 0
	BRnzp END

WRONG_END:
	MUL R5, R5, R5 ; shouldn't go here
	
END:
	ADD R5, R5, R5
