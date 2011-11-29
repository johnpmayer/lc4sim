
;;; This version of Maelstrix by Amir Roth
		.OS
		.CODE
		.ADDR x8000
; the TRAP vector table
	JMP BAD_TRAP	; x00
	JMP BAD_TRAP	; x01
	JMP BAD_TRAP	; x02
	JMP BAD_TRAP	; x03
	JMP BAD_TRAP	; x04
	JMP BAD_TRAP	; x05
	JMP BAD_TRAP	; x06
	JMP BAD_TRAP	; x07
	JMP BAD_TRAP	; x08
	JMP BAD_TRAP	; x09
	JMP BAD_TRAP	; x0A
	JMP BAD_TRAP	; x0B
	JMP BAD_TRAP	; x0C
	JMP BAD_TRAP	; x0D
	JMP BAD_TRAP	; x0E
	JMP BAD_TRAP	; x0F
	JMP BAD_TRAP	; x10
	JMP BAD_TRAP	; x11
	JMP BAD_TRAP	; x12
	JMP BAD_TRAP	; x13
	JMP BAD_TRAP	; x14
	JMP BAD_TRAP	; x15
	JMP BAD_TRAP	; x16
	JMP BAD_TRAP	; x17
	JMP BAD_TRAP	; x18
	JMP BAD_TRAP	; x19
	JMP BAD_TRAP	; x1A
	JMP BAD_TRAP	; x1B
	JMP BAD_TRAP	; x1C
	JMP BAD_TRAP	; x1D
	JMP BAD_TRAP	; x1E
	JMP BAD_TRAP	; x1F
	JMP BAD_TRAP	; x20
	JMP BAD_TRAP	; x21
	JMP BAD_TRAP	; x22
	JMP BAD_TRAP	; x23
	JMP BAD_TRAP	; x24
	JMP TRAP_HALT	; x25
	JMP BAD_TRAP	; x26
	JMP BAD_TRAP	; x27
	JMP BAD_TRAP	; x28
	JMP BAD_TRAP	; x29
	JMP BAD_TRAP	; x2A
	JMP BAD_TRAP	; x2B
	JMP BAD_TRAP	; x2C
	JMP BAD_TRAP	; x2D
	JMP BAD_TRAP	; x2E
	JMP BAD_TRAP	; x2F
	JMP BAD_TRAP	; x30
	JMP BAD_TRAP	; x31
	JMP BAD_TRAP	; x32
	JMP BAD_TRAP	; x33
	JMP BAD_TRAP	; x34
	JMP BAD_TRAP	; x35
	JMP BAD_TRAP	; x36
	JMP BAD_TRAP	; x37
	JMP BAD_TRAP	; x38
	JMP BAD_TRAP	; x39
	JMP BAD_TRAP	; x3A
	JMP BAD_TRAP	; x3B
	JMP BAD_TRAP	; x3C
	JMP BAD_TRAP	; x3D
	JMP BAD_TRAP	; x3E
	JMP BAD_TRAP	; x3F
	JMP TRAP_DRAW_1 ; x40
	JMP BAD_TRAP    ; x41
	JMP TRAP_DRAW_4X4W; x42
	JMP BAD_TRAP	; x43
	JMP BAD_TRAP	; x44
	JMP BAD_TRAP	; x45
	JMP BAD_TRAP	; x46
	JMP BAD_TRAP	; x47
	JMP BAD_TRAP	; x48
	JMP BAD_TRAP	; x49
	JMP BAD_TRAP	; x4A
	JMP BAD_TRAP	; x4B
	JMP BAD_TRAP	; x4C
	JMP BAD_TRAP	; x4D
	JMP TRAP_RESET_VMEM; x4E
	JMP TRAP_BLT_VMEM; x4F
	JMP TRAP_GET_EVENT; x50
	JMP BAD_TRAP	; x51
	JMP BAD_TRAP	; x52
	JMP BAD_TRAP	; x53
	JMP BAD_TRAP	; x54
	JMP BAD_TRAP	; x55
	JMP BAD_TRAP	; x56
	JMP BAD_TRAP	; x57
	JMP BAD_TRAP	; x58
	JMP BAD_TRAP	; x59
	JMP BAD_TRAP	; x5A
	JMP BAD_TRAP	; x5B
	JMP BAD_TRAP	; x5C
	JMP BAD_TRAP	; x5D
	JMP BAD_TRAP	; x5E
	JMP BAD_TRAP	; x5F
	JMP TRAP_PUTS	; x60
	JMP BAD_TRAP	; x61
	JMP BAD_TRAP	; x62
	JMP BAD_TRAP	; x63
	JMP BAD_TRAP	; x64
	JMP BAD_TRAP	; x65
	JMP BAD_TRAP	; x66
	JMP BAD_TRAP	; x67
	JMP BAD_TRAP	; x68
	JMP BAD_TRAP	; x69
	JMP BAD_TRAP	; x6A
	JMP BAD_TRAP	; x6B
	JMP BAD_TRAP	; x6C
	JMP BAD_TRAP	; x6D
	JMP BAD_TRAP	; x6E
	JMP BAD_TRAP	; x6F
	JMP BAD_TRAP	; x70
	JMP BAD_TRAP	; x71
	JMP BAD_TRAP	; x72
	JMP BAD_TRAP	; x73
	JMP BAD_TRAP	; x74
	JMP BAD_TRAP	; x75
	JMP BAD_TRAP	; x76
	JMP BAD_TRAP	; x77
	JMP BAD_TRAP	; x78
	JMP BAD_TRAP	; x79
	JMP BAD_TRAP	; x7A
	JMP BAD_TRAP	; x7B
	JMP BAD_TRAP	; x7C
	JMP BAD_TRAP	; x7D
	JMP BAD_TRAP	; x7E
	JMP BAD_TRAP	; x7F
	JMP BAD_TRAP	; x80
	JMP BAD_TRAP	; x81
	JMP BAD_TRAP	; x82
	JMP BAD_TRAP	; x83
	JMP BAD_TRAP	; x84
	JMP BAD_TRAP	; x85
	JMP BAD_TRAP	; x86
	JMP BAD_TRAP	; x87
	JMP BAD_TRAP	; x88
	JMP BAD_TRAP	; x89
	JMP BAD_TRAP	; x8A
	JMP BAD_TRAP	; x8B
	JMP BAD_TRAP	; x8C
	JMP BAD_TRAP	; x8D
	JMP BAD_TRAP	; x8E
	JMP BAD_TRAP	; x8F
	JMP BAD_TRAP	; x90
	JMP BAD_TRAP	; x91
	JMP BAD_TRAP	; x92
	JMP BAD_TRAP	; x93
	JMP BAD_TRAP	; x94
	JMP BAD_TRAP	; x95
	JMP BAD_TRAP	; x96
	JMP BAD_TRAP	; x97
	JMP BAD_TRAP	; x98
	JMP BAD_TRAP	; x99
	JMP BAD_TRAP	; x9A
	JMP BAD_TRAP	; x9B
	JMP BAD_TRAP	; x9C
	JMP BAD_TRAP	; x9D
	JMP BAD_TRAP	; x9E
	JMP BAD_TRAP	; x9F
	JMP BAD_TRAP	; xA0
	JMP BAD_TRAP	; xA1
	JMP BAD_TRAP	; xA2
	JMP BAD_TRAP	; xA3
	JMP BAD_TRAP	; xA4
	JMP BAD_TRAP	; xA5
	JMP BAD_TRAP	; xA6
	JMP BAD_TRAP	; xA7
	JMP BAD_TRAP	; xA8
	JMP BAD_TRAP	; xA9
	JMP BAD_TRAP	; xAA
	JMP BAD_TRAP	; xAB
	JMP BAD_TRAP	; xAC
	JMP BAD_TRAP	; xAD
	JMP BAD_TRAP	; xAE
	JMP BAD_TRAP	; xAF
	JMP BAD_TRAP	; xB0
	JMP BAD_TRAP	; xB1
	JMP BAD_TRAP	; xB2
	JMP BAD_TRAP	; xB3
	JMP BAD_TRAP	; xB4
	JMP BAD_TRAP	; xB5
	JMP BAD_TRAP	; xB6
	JMP BAD_TRAP	; xB7
	JMP BAD_TRAP	; xB8
	JMP BAD_TRAP	; xB9
	JMP BAD_TRAP	; xBA
	JMP BAD_TRAP	; xBB
	JMP BAD_TRAP	; xBC
	JMP BAD_TRAP	; xBD
	JMP BAD_TRAP	; xBE
	JMP BAD_TRAP	; xBF
	JMP BAD_TRAP	; xC0
	JMP BAD_TRAP	; xC1
	JMP BAD_TRAP	; xC2
	JMP BAD_TRAP	; xC3
	JMP BAD_TRAP	; xC4
	JMP BAD_TRAP	; xC5
	JMP BAD_TRAP	; xC6
	JMP BAD_TRAP	; xC7
	JMP BAD_TRAP	; xC8
	JMP BAD_TRAP	; xC9
	JMP BAD_TRAP	; xCA
	JMP BAD_TRAP	; xCB
	JMP BAD_TRAP	; xCC
	JMP BAD_TRAP	; xCD
	JMP BAD_TRAP	; xCE
	JMP BAD_TRAP	; xCF
	JMP BAD_TRAP	; xD0
	JMP BAD_TRAP	; xD1
	JMP BAD_TRAP	; xD2
	JMP BAD_TRAP	; xD3
	JMP BAD_TRAP	; xD4
	JMP BAD_TRAP	; xD5
	JMP BAD_TRAP	; xD6
	JMP BAD_TRAP	; xD7
	JMP BAD_TRAP	; xD8
	JMP BAD_TRAP	; xD9
	JMP BAD_TRAP	; xDA
	JMP BAD_TRAP	; xDB
	JMP BAD_TRAP	; xDC
	JMP BAD_TRAP	; xDD
	JMP BAD_TRAP	; xDE
	JMP BAD_TRAP	; xDF
	JMP BAD_TRAP	; xE0
	JMP BAD_TRAP	; xE1
	JMP BAD_TRAP	; xE2
	JMP BAD_TRAP	; xE3
	JMP BAD_TRAP	; xE4
	JMP BAD_TRAP	; xE5
	JMP BAD_TRAP	; xE6
	JMP BAD_TRAP	; xE7
	JMP BAD_TRAP	; xE8
	JMP BAD_TRAP	; xE9
	JMP BAD_TRAP	; xEA
	JMP BAD_TRAP	; xEB
	JMP BAD_TRAP	; xEC
	JMP BAD_TRAP	; xED
	JMP BAD_TRAP	; xEE
	JMP BAD_TRAP	; xEF
	JMP BAD_TRAP	; xF0
	JMP BAD_TRAP	; xF1
	JMP BAD_TRAP	; xF2
	JMP BAD_TRAP	; xF3
	JMP BAD_TRAP	; xF4
	JMP BAD_TRAP	; xF5
	JMP BAD_TRAP	; xF6
	JMP BAD_TRAP	; xF7
	JMP BAD_TRAP	; xF8
	JMP BAD_TRAP	; xF9
	JMP BAD_TRAP	; xFA
	JMP BAD_TRAP	; xFB
	JMP BAD_TRAP	; xFC
	JMP BAD_TRAP	; xFD
	JMP BAD_TRAP	; xFE
	JMP BAD_TRAP	; xFF

;;; OS_START - operating system entry point (always starts at x8200)

		.CODE
		.ADDR x8200
OS_START
	;; initialize timer
	LC R0, TIM_INIT
	LC R1, OS_TIR_ADDR
	STR R0, R1, #0

	;; R7 <- User code address (x0000)
	LC R7, USER_CODE_ADDR 
	RTI			; RTI removes the privilege bit

;;; OS memory address constants
USER_CODE_ADDR 	.UCONST x0000
OS_CODE_ADDR 	.UCONST x8000
		
OS_STACK_ADDR 	.UCONST xBFFF
OS_VIDEO_ADDR 	.UCONST xC000
				
OS_KBSR_ADDR	.UCONST xFE00		; keyboard status register
OS_KBDR_ADDR	.UCONST xFE02		; keyboard data register
OS_ADSR_ADDR	.UCONST xFE04		; display status register
OS_ADDR_ADDR	.UCONST xFE06		; display data register
OS_TSR_ADDR	.UCONST xFE08		; timer register
OS_TIR_ADDR	.UCONST xFE0A		; timer interval register
OS_VDCR_ADDR	.UCONST xFE0C	        ; video display control register
OS_MCR_ADDR	.UCONST xFFEE		; machine control register

TIM_INIT 	.UCONST #320

MASK_L15 	.UCONST x7FFF
MASK_H4		.UCONST xF000
			
		.DATA
		.ADDR xC000	
OS_VIDEO_MEM 	.BLKW x3E00

OS_VIDEO_NUM_COLS .UCONST #128
OS_VIDEO_NUM_ROWS .UCONST #124		
	
;;; TRAP_HALP - trap handler for halting machine

;;; BAD_TRAP - code to execute for undefined trap
		.CODE
BAD_TRAP
	JMP TRAP_HALT	; execute HALT

;;; TRAP_HALT - halts the program and jumps to OS_START
		.CODE
TRAP_HALT	
	; clear run bit in MCR
	LC R3, OS_MCR_ADDR
	LDR R0, R3, #0
	LC R1, MASK_L15
	AND R0,R0,R1
	STR R0, R3, #0
	JMP OS_START 	; restart machine

;;; TRAP_RESET_VMEM - In double-buffered video mode, resets the video
;;; display, i.e., turns it to black.
;;; Inputs - none
;;; Outputs - none

		.CODE
TRAP_RESET_VMEM
	LC R4, OS_VDCR_ADDR
	CONST R5, #1
	STR R5, R4, #0
	RTI

;;; TRAP_BLT_VMEM - In double-buffered video mode, copies the contents
;;; of video memory to the video display.
;;; Inputs - none
;;; Outputs - none
		.CODE
TRAP_BLT_VMEM
	LC R4, OS_VDCR_ADDR
	CONST R5, #2
	STR R5, R4, #0
	RTI
	
		.CODE
;;; TRAP_DRAW_1
;;; Input
;;;   r0 - video column (left)
;;;   r1 - video row (upper) 
;;;   r2 - color
;;; Output
;;;   video memory will be updated to place block of approriate color
TRAP_DRAW_1
	LC R4, OS_STACK_ADDR	; OS stack pointer (x7FFF) -> R4
	STR R6, R4, #-1		; save USER stack pointer
	ADD R6, R4, #0		; begin using general stack pointer (R6) here
	STR R5, R6, #-2

	LC R5, OS_VIDEO_NUM_COLS
	MUL R5, R1, R5		; Multiply row by 128 (VIDEO_COL_NUM)
	ADD R5, R5, R0		; Add col
	LEA R4, OS_VIDEO_MEM
	ADD R5, R5, R4		; Add video mem begin
	STR R2, R5, #0
	
	LDR R5, R6, #-2
	LDR R6, R6, #-1
	RTI 


;;; TRAP_DRAW_4X4W - draws with 4x4 bitmap with screen "wraparound",
;;; i.e., if part of the bitmap is "off the screen" it wraps around to
;;; the other side of the screen.
;;; Input
;;;   r0 - video column (left) 
;;;   r1 - video row (upper)
;;;   r2 - color
;;;   r3 - bitmap
;;; Output
;;;   video memory will be updated to place block of approriate color
		.CODE
TRAP_DRAW_4x4W
	;; prologue
	LC R4, OS_STACK_ADDR	;R4 storing stack addr
	STR R6, R4, #-1		;Push old R6 onto stack
	ADD R6, R4, #0		;upgrade R6 to current stack pointer
	STR R5, R6, #-2		;store old R5, frame pointer, into R6-2 STR R0, R6, #-4		;store numcols into R6-4

	LC R4, OS_VIDEO_NUM_ROWS ;set R4 to number of video rows ADD R4, R4, #-1		 ;subtract one to account for last row
	LC R5, OS_VIDEO_NUM_COLS ;set R5 to number of video columns
	MUL R4, R4, R5		 ;Multiply to get position 0 of last row
	STR R4, R6, #-5		 ;Store for later use
	
	MUL R5, R1, R5		; Multiply row by 128 (VIDEO_COL_NUM) and store in R5
	ADD R5, R5, R0		; Add col, R5 now represents our current position on the grid
	LEA R4, OS_VIDEO_MEM	;Load the address of video memory into R4.
	AND R1, R1, #0		;Set R1 to 0
	LC R0, OS_VIDEO_NUM_COLS ;R0 stores the number of columns
	ADD R0, R0, #-3		;subtract 3; this represents the number to add to R5 to set it down one level and left 3 for the next bmp row
	BRnzp Bmpcheck
	
Countcheck
	CMPI R1, #3
	BRz Shiftposition
	ADD R1, R1, #1
	ADD R5, R5, #1

Bmpcheck
	ADD R3, R3, #0		;is R3 MSB == 0? Shiftbmp
	BRp Shiftbmp		;MSB == 1? Insertpixel (falls through)
	BRz 4x4_Return		;== 0? Exit

	
Insertpixel
	LEA R4, OS_VIDEO_MEM	;just in case there was a wrap
	ADD R4, R5, R4		; set R4 to video addr + col/row location
	STR R2, R4, #0		; store pixel color to location

Shiftbmp
	SLL R3, R3, #1
	BRnzp Countcheck
	
Shiftposition
	STR R5, R6, #-3		;push current position to stack
	LDR R4, R6, #-5		;load position 0 of last row
	ADD R5, R5, R0
	STR R5, R6, #-3
	SUB R5, R5, R4		;R5 = current position - position 0 of last row ADD R5, R5, #-3		;subtract 3 from r5
	BRzp Continue
	LDR R5, R6, #-3
Continue	
	AND R1, R1, #0
	BRnzp Bmpcheck
	
4x4_Return
	;; epilogue
	LDR R5, R6, #-2
	LDR R6, R6, #-1
	RTI

	

	
;;; TRAP_GET_EVENT - for getting a keyboard or timer event
;;; Input
;;;   none
;;; Output
;;;   r5 - an integer indicating what event has happened
;;;        0 (timer) 
;;;        non-0 (keyboard character)
		.CODE
TRAP_GET_EVENT
	;; prologue
	LC R4, OS_STACK_ADDR
	STR R6, R4, #-1
	ADD R6, R4, #0		;	STR R5, R6, #-2		

TimerCheck
	LC R5, OS_TSR_ADDR
	LDR R5, R5, #0
	BRn Settozero

	LC R5, OS_KBSR_ADDR
	LDR R5, R5, #0
	BRzp TimerCheck
	LC R5, OS_KBDR_ADDR
	LDR R5, R5, #0
	BRp Return
	
Settozero
	AND R5, R5, #0
	BRz Return

Return	;; epilogue	LDR R5, R6, #-2
	LDR R6, R6, #-1
	RTI
	
;;; TRAP_PUTS - writes a string to ASCII display
;;; Input
;;;   r0 - address of string
;;; Output
;;;   none
		.CODE
TRAP_PUTS
	LC R1, OS_ADDR_ADDR
Loop	LDR R2, R0, #0		;load next char to R2 for writing
	BRz Returnit		;check if string has ended
	ADD R0, R0, #1
	
WriteChar
	LC R3, OS_ADSR_ADDR	;Check display status register
	LDR R3, R3, #0
	BRzp WriteChar		;if negative (msb 1) continue
	STR R2, R1, #0		;store R2 (next char) in display data reg
	BRnzp Loop		;continue checking for next char
	
Returnit
	RTI
	





	

	