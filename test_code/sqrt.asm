;; Square root program
;; B = sqrt(A)
;; R0 = A, R1 = B

	.CODE			; This is a code segment
	.ADDR 0x0000		; Start filling in instructions at address 0x00

	CONST R1, #-1		; Initialize B to -1
	CMPI R0, #0		; Compare A to 0
	BRn END			; if (A < 0) Branch to the end
	ADD R1, R1, #1		; Set B to 0

LOOP
	MUL R2, R1, R1		; C = B*B
	ADD R1, R1, #-1		; B = B-1
	CMP R2, R0		; Compare C to A
	BRp END			; If C > A Branch to the end

	ADD R1, R1, #2		; B = B + 1

	BRnzp LOOP		; Go back to the beginning of the loop

END