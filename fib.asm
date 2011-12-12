	.DATA
	.ADDR x2000		; Start the data at address 0x4000
global_array
	.FILL #0		
	.FILL #1
	.CODE			; This is a code segment
	.ADDR 0x0000		; Start filling in instructions at address 0x00
INIT
	LEA R0, global_array	; R0 contains the address of the data
	CONST R1, #2		; i = 2, loop counter init to 2
	JMP TEST
BODY
	LDR R2, R0, #0		; Load first data value into R2
	LDR R3, R0, #1		; Load second data value into R3
	ADD R4, R2, R3		; F_i = F_(i-1) + F_(i-2), store in R4
	ADD R0, R0, #1		; increment data address
	STR R4, R0, #1		; Store R4 into the data address indicated by R0, +1
	ADD R1, R1, #1		; i = i + 1, incrementing loop counter
TEST
	CMPI R1, #20		; compare loop counter to 20
	BRn BODY
END
	NOP
