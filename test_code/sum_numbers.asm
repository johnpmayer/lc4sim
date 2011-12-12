	;; This is the data section
	.DATA
	.ADDR x4000		; Start the data at address 0x4000
	
global_array
	.FILL #11
	.FILL #7
	.FILL #6
	.FILL #2
	.FILL #-5

	;; Start of the code section
	.CODE
	.ADDR 0x0000		; Start the code at address 0x0000
INIT
	LEA R0, global_array	; R0 contains the address of the data
	CONST R1, 0		; R1 stores the running sum init to 0
	CONST R2, 5		; R2 is our loop counter init to 5
	JMP TEST
BODY
	LDR R3, R0, #0		; Load the data value into R3  
	ADD R1, R1, R3		; update the sum
	ADD R0, R0, #1		; increment the address
	ADD R2, R2, #-1		; decrement the loop counter

TEST
	CMPI R2, #0		; check if the loop counter is zero yet
	BRp BODY
END
	NOP
