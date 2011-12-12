;; Multiplication program
;; C = A*B
;; R0 = A, R1 = B, R2 = C

	.CODE		; This is a code segment
	.ADDR  0x0000	; Start filling in instructions at address 0x00

	CONST R2, #0    ; Initialize C to 0

LOOP

	CMPI R1, #0	; Compare B to 0
	BRnz END	; if (B <= 0) Branch to the end

	ADD R2, R2, R0	; C = C + A
	ADD R1, R1, #-1	; B =  B - 1

	BRnzp LOOP	; Go back to the beginning of the loop

END