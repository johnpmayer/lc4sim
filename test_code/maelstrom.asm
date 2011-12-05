		.FILE "maelstrom.c"
		.DATA
t2vx 		.FILL #1
		.FILL #1
		.FILL #0
		.FILL #-1
		.FILL #-1
		.FILL #-1
		.FILL #0
		.FILL #1
		.DATA
t2vy 		.FILL #0
		.FILL #-1
		.FILL #-1
		.FILL #-1
		.FILL #0
		.FILL #1
		.FILL #1
		.FILL #1
		.DATA
asteroid_bmps 		.FILL #19
		.FILL #140
		.FILL #12544
		.FILL #51200
		.FILL #887
		.FILL #3310
		.FILL #30512
		.FILL #61120
		.FILL #14335
		.FILL #52991
		.FILL #65395
		.FILL #65516
		.DATA
ship_bmps 		.FILL #887
		.FILL #3310
		.FILL #30512
		.FILL #61120
		.DATA
gun_bmps 		.FILL #0
		.FILL #14
		.FILL #0
		.FILL #57344
		.FILL #0
		.FILL #1260
		.FILL #0
		.FILL #0
		.FILL #273
		.FILL #2184
		.FILL #0
		.FILL #0
		.FILL #627
		.FILL #0
		.FILL #0
		.FILL #0
		.FILL #7
		.FILL #0
		.FILL #28672
		.FILL #0
		.FILL #0
		.FILL #0
		.FILL #14112
		.FILL #0
		.FILL #0
		.FILL #0
		.FILL #4368
		.FILL #34944
		.FILL #0
		.FILL #0
		.FILL #0
		.FILL #52800
		.LOC 61
;;;;;;;;;;;;;;;;;;;;;;;;;;;;init_ship;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
init_ship
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
		.LOC 62
		.LOC 63
	LEA R7, ship
	CONST R3, #64
	STR R3, R7, #0
		.LOC 64
	LEA R7, ship
	CONST R3, #62
	STR R3, R7, #1
		.LOC 65
	LEA R7, ship
	CONST R3, #0
	STR R3, R7, #2
		.LOC 66
	LEA R7, ship
	CONST R3, #0
	STR R3, R7, #3
		.LOC 67
	LEA R7, ship
	CONST R3, #0
	STR R3, R7, #4
		.LOC 68
L1_maelstrom
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

		.LOC 70
;;;;;;;;;;;;;;;;;;;;;;;;;;;;make_random_asteroid;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
make_random_asteroid
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
		.LOC 71
		.LOC 72
	CONST R7, #32
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_rand
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	CONST R3, #1
	CMP R7, R3
	BRp L4_maelstrom
	CONST R7, #1
	STR R7, R5, #-1
	JMP L5_maelstrom
L4_maelstrom
	CONST R7, #0
	STR R7, R5, #-1
L5_maelstrom
	LDR R7, R5, #-1
L2_maelstrom
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

		.LOC 75
;;;;;;;;;;;;;;;;;;;;;;;;;;;;init_random_asteroid;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
init_random_asteroid
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
		.LOC 76
		.LOC 77
	CONST R7, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_rand
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	LDR R3, R5, #3
	ADD R7, R7, #2
	STR R7, R3, #5
		.LOC 78
	CONST R7, #128
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_rand
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	LDR R3, R5, #3
	STR R7, R3, #1
		.LOC 79
	CONST R7, #2
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_rand
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	CONST R3, #0
	CMP R7, R3
	BRz L8_maelstrom
	CONST R7, #123
	STR R7, R5, #-1
	JMP L9_maelstrom
L8_maelstrom
	CONST R7, #0
	STR R7, R5, #-1
L9_maelstrom
	LDR R7, R5, #3
	LDR R3, R5, #-1
	STR R3, R7, #2
		.LOC 80
	LDR R7, R5, #3
	CONST R3, #5
	LDR R2, R7, #5
	SUB R3, R3, R2
	STR R3, R7, #3
		.LOC 81
	LDR R7, R5, #3
	CONST R3, #5
	LDR R2, R7, #5
	SUB R3, R3, R2
	STR R3, R7, #4
		.LOC 82
	CONST R7, #2
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_rand
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	CONST R3, #0
	CMP R7, R3
	BRz L10_maelstrom
		.LOC 83
	LDR R7, R5, #3
	ADD R7, R7, #3
	LDR R3, R7, #0
	NOT R3,R3
	ADD R3,R3,#1
	STR R3, R7, #0
L10_maelstrom
		.LOC 84
	CONST R7, #2
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_rand
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	CONST R3, #0
	CMP R7, R3
	BRz L12_maelstrom
		.LOC 85
	LDR R7, R5, #3
	ADD R7, R7, #4
	LDR R3, R7, #0
	NOT R3,R3
	ADD R3,R3,#1
	STR R3, R7, #0
L12_maelstrom
		.LOC 86
L6_maelstrom
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

		.DATA
bullet_headpointer 		.FILL x0
		.DATA
bullet_count 		.FILL #0
		.LOC 91
;;;;;;;;;;;;;;;;;;;;;;;;;;;;make_bullet;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
make_bullet
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
		.LOC 91
		.LOC 92
	LEA R7, bullet_headpointer
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRnp L15_maelstrom
		.LOC 92
		.LOC 93
	CONST R7, #7
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_malloc
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	STR R7, R5, #-1
		.LOC 94
	LEA R7, bullet_headpointer
	LDR R3, R5, #-1
	STR R3, R7, #0
		.LOC 95
	LEA R7, bullet_headpointer
	LDR R7, R7, #0
	CONST R3, #0
	STR R3, R7, #5
		.LOC 96
	LEA R7, bullet_headpointer
	LDR R7, R7, #0
	CONST R3, #0
	STR R3, R7, #6
		.LOC 97
	LEA R7, bullet_headpointer
	LDR R7, R7, #0
	CONST R3, #1
	STR R3, R7, #0
		.LOC 98
	LEA R7, bullet_count
	LDR R3, R7, #0
	ADD R3, R3, #1
	STR R3, R7, #0
		.LOC 99
	LEA R7, bullet_headpointer
	LDR R7, R7, #0
	JMP L14_maelstrom
L15_maelstrom
		.LOC 101
	LEA R7, bullet_count
	LDR R7, R7, #0
	CONST R3, #32
	CMP R7, R3
	BRzp L17_maelstrom
		.LOC 101
		.LOC 102
	CONST R7, #7
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_malloc
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	STR R7, R5, #-1
		.LOC 103
	LEA R7, bullet_headpointer
	LDR R7, R7, #0
	LDR R3, R5, #-1
	STR R3, R7, #6
		.LOC 104
	LDR R7, R5, #-1
	LEA R3, bullet_headpointer
	LDR R3, R3, #0
	STR R3, R7, #5
		.LOC 105
	LEA R7, bullet_headpointer
	LDR R3, R5, #-1
	STR R3, R7, #0
		.LOC 106
	LEA R7, bullet_headpointer
	LDR R7, R7, #0
	CONST R3, #0
	STR R3, R7, #6
		.LOC 107
	LEA R7, bullet_count
	LDR R3, R7, #0
	ADD R3, R3, #1
	STR R3, R7, #0
		.LOC 108
	LEA R7, bullet_headpointer
	LDR R7, R7, #0
	CONST R3, #1
	STR R3, R7, #0
		.LOC 109
	LEA R7, bullet_headpointer
	LDR R7, R7, #0
	JMP L14_maelstrom
L17_maelstrom
		.LOC 111
		.LOC 112
	CONST R7, #0
L14_maelstrom
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

		.LOC 116
;;;;;;;;;;;;;;;;;;;;;;;;;;;;remove_bullet;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
remove_bullet
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-2	;; allocate stack space for local variables
	;; function body
		.LOC 116
		.LOC 117
	LDR R7, R5, #3
	LDR R7, R7, #6
	STR R7, R5, #-1
		.LOC 118
	LDR R7, R5, #3
	LDR R7, R7, #5
	STR R7, R5, #-2
		.LOC 119
	LDR R7, R5, #-1
	CONST R3, #0
	CMP R7, R3
	BRz L20_maelstrom
		.LOC 119
		.LOC 120
	LDR R7, R5, #-1
	LDR R3, R5, #-2
	STR R3, R7, #5
		.LOC 121
L20_maelstrom
		.LOC 122
	LDR R7, R5, #-2
	CONST R3, #0
	CMP R7, R3
	BRz L22_maelstrom
		.LOC 122
		.LOC 123
	LDR R7, R5, #-2
	LDR R3, R5, #-1
	STR R3, R7, #6
		.LOC 124
L22_maelstrom
		.LOC 125
	LDR R7, R5, #3
	LEA R3, bullet_headpointer
	LDR R3, R3, #0
	CMP R7, R3
	BRnp L24_maelstrom
		.LOC 125
		.LOC 126
	LEA R7, bullet_headpointer
	LDR R3, R5, #3
	LDR R3, R3, #5
	STR R3, R7, #0
		.LOC 127
L24_maelstrom
		.LOC 128
	LEA R7, bullet_count
	LDR R3, R7, #0
	ADD R3, R3, #-1
	STR R3, R7, #0
		.LOC 129
	LDR R7, R5, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_free
	ADD R6, R6, #1	;; free space for arguments
		.LOC 130
L19_maelstrom
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

		.DATA
asteroid_headpointer 		.FILL x0
		.DATA
asteroid_count 		.FILL #0
		.LOC 135
;;;;;;;;;;;;;;;;;;;;;;;;;;;;init_asteroid;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
init_asteroid
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
		.LOC 135
		.LOC 136
	LEA R7, asteroid_headpointer
	LDR R7, R7, #0
	LDR R3, R5, #3
	STR R3, R7, #7
		.LOC 137
	LDR R7, R5, #3
	LEA R3, asteroid_headpointer
	LDR R3, R3, #0
	STR R3, R7, #6
		.LOC 138
	LEA R7, asteroid_headpointer
	LDR R3, R5, #3
	STR R3, R7, #0
		.LOC 139
	LEA R7, asteroid_headpointer
	LDR R7, R7, #0
	CONST R3, #0
	STR R3, R7, #7
		.LOC 140
	LEA R7, asteroid_count
	LDR R3, R7, #0
	ADD R3, R3, #1
	STR R3, R7, #0
		.LOC 141
	LEA R7, asteroid_headpointer
	LDR R7, R7, #0
	CONST R3, #1
	STR R3, R7, #0
		.LOC 142
	LDR R7, R5, #3
	LDR R3, R5, #4
	STR R3, R7, #1
		.LOC 143
	LDR R7, R5, #3
	LDR R3, R5, #5
	STR R3, R7, #2
		.LOC 144
	LDR R7, R5, #3
	LDR R3, R5, #6
	STR R3, R7, #3
		.LOC 145
	LDR R7, R5, #3
	LDR R3, R5, #7
	STR R3, R7, #4
		.LOC 146
	LDR R7, R5, #3
	LDR R3, R5, #8
	STR R3, R7, #5
		.LOC 147
L26_maelstrom
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

		.LOC 149
;;;;;;;;;;;;;;;;;;;;;;;;;;;;make_asteroid;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
make_asteroid
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
		.LOC 149
		.LOC 150
	LEA R7, asteroid_headpointer
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRnp L28_maelstrom
		.LOC 150
		.LOC 151
	CONST R7, #8
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_malloc
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	STR R7, R5, #-1
		.LOC 152
	LEA R7, asteroid_headpointer
	LDR R3, R5, #-1
	STR R3, R7, #0
		.LOC 153
	LEA R7, asteroid_headpointer
	LDR R7, R7, #0
	CONST R3, #0
	STR R3, R7, #6
		.LOC 154
	LEA R7, asteroid_headpointer
	LDR R7, R7, #0
	CONST R3, #0
	STR R3, R7, #7
		.LOC 155
	LEA R7, asteroid_headpointer
	LDR R7, R7, #0
	CONST R3, #1
	STR R3, R7, #0
		.LOC 156
	LEA R7, asteroid_count
	LDR R3, R7, #0
	ADD R3, R3, #1
	STR R3, R7, #0
		.LOC 157
	LEA R7, asteroid_headpointer
	LDR R7, R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR init_random_asteroid
	ADD R6, R6, #1	;; free space for arguments
		.LOC 158
	JMP L29_maelstrom
L28_maelstrom
		.LOC 159
	LEA R7, asteroid_count
	LDR R7, R7, #0
	CONST R3, #32
	CMP R7, R3
	BRzp L30_maelstrom
		.LOC 159
		.LOC 160
	CONST R7, #8
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_malloc
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	STR R7, R5, #-1
		.LOC 161
	LEA R7, asteroid_headpointer
	LDR R7, R7, #0
	LDR R3, R5, #-1
	STR R3, R7, #7
		.LOC 162
	LDR R7, R5, #-1
	LEA R3, asteroid_headpointer
	LDR R3, R3, #0
	STR R3, R7, #6
		.LOC 163
	LEA R7, asteroid_headpointer
	LDR R3, R5, #-1
	STR R3, R7, #0
		.LOC 164
	LEA R7, asteroid_headpointer
	LDR R7, R7, #0
	CONST R3, #0
	STR R3, R7, #7
		.LOC 165
	LEA R7, asteroid_count
	LDR R3, R7, #0
	ADD R3, R3, #1
	STR R3, R7, #0
		.LOC 166
	LEA R7, asteroid_headpointer
	LDR R7, R7, #0
	CONST R3, #1
	STR R3, R7, #0
		.LOC 167
	LEA R7, asteroid_headpointer
	LDR R7, R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR init_random_asteroid
	ADD R6, R6, #1	;; free space for arguments
		.LOC 168
L30_maelstrom
L29_maelstrom
		.LOC 169
L27_maelstrom
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

		.LOC 171
;;;;;;;;;;;;;;;;;;;;;;;;;;;;remove_asteroid;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
remove_asteroid
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-2	;; allocate stack space for local variables
	;; function body
		.LOC 171
		.LOC 172
	LDR R7, R5, #3
	LDR R7, R7, #7
	STR R7, R5, #-1
		.LOC 173
	LDR R7, R5, #3
	LDR R7, R7, #6
	STR R7, R5, #-2
		.LOC 174
	LDR R7, R5, #-1
	CONST R3, #0
	CMP R7, R3
	BRz L33_maelstrom
		.LOC 174
		.LOC 175
	LDR R7, R5, #-1
	LDR R3, R5, #-2
	STR R3, R7, #6
		.LOC 176
L33_maelstrom
		.LOC 177
	LDR R7, R5, #-2
	CONST R3, #0
	CMP R7, R3
	BRz L35_maelstrom
		.LOC 177
		.LOC 178
	LDR R7, R5, #-2
	LDR R3, R5, #-1
	STR R3, R7, #7
		.LOC 179
L35_maelstrom
		.LOC 180
	LEA R7, asteroid_headpointer
	LDR R7, R7, #0
	LDR R3, R5, #3
	CMP R7, R3
	BRnp L37_maelstrom
		.LOC 180
		.LOC 181
	LEA R7, asteroid_headpointer
	LDR R3, R5, #3
	LDR R3, R3, #6
	STR R3, R7, #0
		.LOC 182
L37_maelstrom
		.LOC 183
	LEA R7, asteroid_count
	LDR R3, R7, #0
	ADD R3, R3, #-1
	STR R3, R7, #0
		.LOC 184
	LDR R7, R5, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_free
	ADD R6, R6, #1	;; free space for arguments
		.LOC 185
L32_maelstrom
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

		.LOC 187
;;;;;;;;;;;;;;;;;;;;;;;;;;;;collision;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
collision
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-4	;; allocate stack space for local variables
	;; function body
		.LOC 187
		.LOC 188
	LDR R7, R5, #3
	LDR R3, R5, #6
	SUB R7, R7, R3
	STR R7, R5, #-1
		.LOC 189
	LDR R7, R5, #4
	LDR R3, R5, #7
	SUB R7, R7, R3
	STR R7, R5, #-2
		.LOC 190
	LDR R7, R5, #5
	LDR R3, R5, #8
	ADD R7, R7, R3
	STR R7, R5, #-3
		.LOC 191
	LDR R7, R5, #-1
	MUL R7, R7, R7
	STR R7, R5, #-1
		.LOC 192
	LDR R7, R5, #-2
	MUL R7, R7, R7
	STR R7, R5, #-2
		.LOC 193
	LDR R7, R5, #-3
	MUL R7, R7, R7
	STR R7, R5, #-3
		.LOC 194
	LDR R7, R5, #-1
	LDR R3, R5, #-2
	ADD R7, R7, R3
	LDR R3, R5, #-3
	CMP R7, R3
	BRp L41_maelstrom
	CONST R7, #1
	STR R7, R5, #-4
	JMP L42_maelstrom
L41_maelstrom
	CONST R7, #0
	STR R7, R5, #-4
L42_maelstrom
	LDR R7, R5, #-4
L39_maelstrom
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

		.LOC 200
;;;;;;;;;;;;;;;;;;;;;;;;;;;;split;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
split
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
		.LOC 200
		.LOC 201
	LDR R7, R5, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR remove_asteroid
	ADD R6, R6, #1	;; free space for arguments
		.LOC 202
	LEA R7, asteroid_count
	LDR R7, R7, #0
	CONST R3, #32
	CMP R7, R3
	BRzp L44_maelstrom
		.LOC 202
		.LOC 203
	CONST R7, #8
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_malloc
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	STR R7, R5, #-1
		.LOC 204
	LDR R7, R5, #3
	LDR R3, R7, #5
	ADD R3, R3, #-1
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R3, R7, #3
	NOT R3,R3
	ADD R3,R3,#1
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R3, R7, #4
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R3, R7, #2
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R7, R7, #1
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR init_asteroid
	ADD R6, R6, #6	;; free space for arguments
		.LOC 205
L44_maelstrom
		.LOC 206
	LEA R7, asteroid_count
	LDR R7, R7, #0
	CONST R3, #32
	CMP R7, R3
	BRzp L46_maelstrom
		.LOC 206
		.LOC 207
	CONST R7, #8
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_malloc
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	STR R7, R5, #-1
		.LOC 208
	LDR R7, R5, #3
	LDR R3, R7, #5
	ADD R3, R3, #-1
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R3, R7, #3
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R3, R7, #4
	NOT R3,R3
	ADD R3,R3,#1
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R3, R7, #2
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R7, R7, #1
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR init_asteroid
	ADD R6, R6, #6	;; free space for arguments
		.LOC 209
L46_maelstrom
		.LOC 210
L43_maelstrom
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

		.LOC 212
;;;;;;;;;;;;;;;;;;;;;;;;;;;;draw_ship;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
draw_ship
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-5	;; allocate stack space for local variables
	;; function body
		.LOC 212
		.LOC 215
	LEA R7, ship
	LDR R7, R7, #0
	ADD R7, R7, #-4
	STR R7, R5, #-1
		.LOC 216
	LEA R7, ship
	LDR R7, R7, #0
	STR R7, R5, #-2
		.LOC 217
	LEA R7, ship
	LDR R7, R7, #1
	ADD R7, R7, #-4
	STR R7, R5, #-3
		.LOC 218
	LEA R7, ship
	LDR R7, R7, #1
	STR R7, R5, #-4
		.LOC 219
	LEA R7, ship
	LDR R7, R7, #4
	STR R7, R5, #-5
		.LOC 220
	LDR R7, R5, #-4
	CONST R3, #124
	CMP R7, R3
	BRnz L49_maelstrom
		.LOC 220
		.LOC 221
	LDR R7, R5, #-4
	CONST R3, #124
	SUB R7, R7, R3
	STR R7, R5, #-4
		.LOC 222
L49_maelstrom
		.LOC 223
	LDR R7, R5, #-3
	CONST R3, #0
	CMP R7, R3
	BRzp L51_maelstrom
		.LOC 223
		.LOC 224
	LDR R7, R5, #-3
	CONST R3, #124
	ADD R7, R7, R3
	STR R7, R5, #-3
		.LOC 225
L51_maelstrom
		.LOC 226
	LDR R7, R5, #-1
	CONST R3, #0
	CMP R7, R3
	BRzp L53_maelstrom
		.LOC 226
		.LOC 227
	LDR R7, R5, #-1
	CONST R3, #128
	ADD R7, R7, R3
	STR R7, R5, #-1
		.LOC 228
L53_maelstrom
		.LOC 229
	LDR R7, R5, #-2
	CONST R3, #128
	CMP R7, R3
	BRnz L55_maelstrom
		.LOC 229
		.LOC 230
	LDR R7, R5, #-2
	CONST R3, #128
	SUB R7, R7, R3
	STR R7, R5, #-2
		.LOC 231
L55_maelstrom
		.LOC 234
	LEA R7, ship_bmps
	LDR R7, R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #255
	HICONST R7, #255
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-3
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR draw_4x4_wrapped
	ADD R6, R6, #4	;; free space for arguments
		.LOC 235
	LEA R7, ship_bmps
	LDR R7, R7, #1
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #255
	HICONST R7, #255
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-3
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR draw_4x4_wrapped
	ADD R6, R6, #4	;; free space for arguments
		.LOC 236
	LEA R7, ship_bmps
	LDR R7, R7, #2
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #255
	HICONST R7, #255
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-4
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR draw_4x4_wrapped
	ADD R6, R6, #4	;; free space for arguments
		.LOC 237
	LEA R7, ship_bmps
	LDR R7, R7, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #255
	HICONST R7, #255
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-4
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR draw_4x4_wrapped
	ADD R6, R6, #4	;; free space for arguments
		.LOC 240
	LDR R7, R5, #-5
	SLL R7, R7, #2
	LEA R3, gun_bmps
	ADD R7, R7, R3
	LDR R7, R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	HICONST R7, #124
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-3
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR draw_4x4_wrapped
	ADD R6, R6, #4	;; free space for arguments
		.LOC 241
	LDR R7, R5, #-5
	SLL R7, R7, #2
	LEA R3, gun_bmps
	ADD R7, R7, R3
	LDR R7, R7, #1
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	HICONST R7, #124
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-3
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR draw_4x4_wrapped
	ADD R6, R6, #4	;; free space for arguments
		.LOC 242
	LDR R7, R5, #-5
	SLL R7, R7, #2
	LEA R3, gun_bmps
	ADD R7, R7, R3
	LDR R7, R7, #2
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	HICONST R7, #124
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-4
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR draw_4x4_wrapped
	ADD R6, R6, #4	;; free space for arguments
		.LOC 243
	LDR R7, R5, #-5
	SLL R7, R7, #2
	LEA R3, gun_bmps
	ADD R7, R7, R3
	LDR R7, R7, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #0
	HICONST R7, #124
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-4
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR draw_4x4_wrapped
	ADD R6, R6, #4	;; free space for arguments
		.LOC 244
L48_maelstrom
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

		.LOC 246
;;;;;;;;;;;;;;;;;;;;;;;;;;;;update_ship;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
update_ship
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
		.LOC 246
		.LOC 249
	LEA R7, ship
	STR R7, R5, #-1
	CONST R3, #0
	LDR R2, R7, #2
	CMP R2, R3
	BRnp L60_maelstrom
	LDR R7, R5, #-1
	LDR R7, R7, #3
	CMP R7, R3
	BRz L58_maelstrom
L60_maelstrom
		.LOC 249
		.LOC 251
	LEA R7, ship
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRp L61_maelstrom
		.LOC 251
		.LOC 252
	LEA R7, ship
	LDR R3, R7, #0
	CONST R2, #128
	ADD R3, R3, R2
	STR R3, R7, #0
		.LOC 253
	JMP L62_maelstrom
L61_maelstrom
		.LOC 254
	LEA R7, ship
	LDR R7, R7, #0
	CONST R3, #128
	CMP R7, R3
	BRn L63_maelstrom
		.LOC 254
		.LOC 255
	LEA R7, ship
	LDR R3, R7, #0
	CONST R2, #128
	SUB R3, R3, R2
	STR R3, R7, #0
		.LOC 256
L63_maelstrom
L62_maelstrom
		.LOC 257
	LEA R7, ship
	LDR R7, R7, #1
	CONST R3, #0
	CMP R7, R3
	BRp L65_maelstrom
		.LOC 257
		.LOC 258
	LEA R7, ship
	ADD R7, R7, #1
	LDR R3, R7, #0
	CONST R2, #124
	ADD R3, R3, R2
	STR R3, R7, #0
		.LOC 259
	JMP L66_maelstrom
L65_maelstrom
		.LOC 260
	LEA R7, ship
	LDR R7, R7, #1
	CONST R3, #124
	CMP R7, R3
	BRn L67_maelstrom
		.LOC 260
		.LOC 261
	LEA R7, ship
	ADD R7, R7, #1
	LDR R3, R7, #0
	CONST R2, #124
	SUB R3, R3, R2
	STR R3, R7, #0
		.LOC 262
L67_maelstrom
L66_maelstrom
		.LOC 264
	LEA R7, ship
	LDR R3, R7, #0
	LDR R2, R7, #2
	ADD R3, R3, R2
	STR R3, R7, #0
		.LOC 265
	LEA R7, ship
	ADD R3, R7, #1
	LDR R2, R3, #0
	LDR R7, R7, #3
	ADD R7, R2, R7
	STR R7, R3, #0
		.LOC 266
L58_maelstrom
		.LOC 267
	JSR draw_ship
	ADD R6, R6, #0	;; free space for arguments
		.LOC 269
L57_maelstrom
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

		.LOC 271
;;;;;;;;;;;;;;;;;;;;;;;;;;;;update_bullets;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
update_bullets
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-5	;; allocate stack space for local variables
	;; function body
		.LOC 271
		.LOC 272
	LEA R7, bullet_headpointer
	LDR R7, R7, #0
	STR R7, R5, #-1
	JMP L71_maelstrom
L70_maelstrom
		.LOC 273
		.LOC 274
	LDR R7, R5, #-1
	STR R7, R5, #-2
		.LOC 276
	LDR R7, R5, #-2
	STR R7, R5, #-3
	LDR R3, R7, #1
	CONST R2, #128
	CMP R3, R2
	BRzp L77_maelstrom
	LDR R7, R5, #-3
	LDR R7, R7, #2
	STR R7, R5, #-4
	CONST R2, #124
	CMP R7, R2
	BRzp L77_maelstrom
	CONST R7, #0
	STR R7, R5, #-5
	CMP R3, R7
	BRnz L77_maelstrom
	LDR R7, R5, #-4
	LDR R3, R5, #-5
	CMP R7, R3
	BRp L73_maelstrom
L77_maelstrom
		.LOC 276
		.LOC 277
	LDR R7, R5, #-2
	CONST R3, #0
	STR R3, R7, #0
		.LOC 278
L73_maelstrom
		.LOC 279
	LDR R7, R5, #-2
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRz L78_maelstrom
		.LOC 279
		.LOC 280
	LDR R7, R5, #-2
	ADD R3, R7, #1
	LDR R2, R3, #0
	LDR R7, R7, #3
	ADD R7, R2, R7
	STR R7, R3, #0
		.LOC 281
	LDR R7, R5, #-2
	ADD R3, R7, #2
	LDR R2, R3, #0
	LDR R7, R7, #4
	ADD R7, R2, R7
	STR R7, R3, #0
		.LOC 282
	CONST R7, #0
	HICONST R7, #124
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	LDR R3, R7, #2
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R7, R7, #1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR draw_1
	ADD R6, R6, #3	;; free space for arguments
		.LOC 283
	JMP L79_maelstrom
L78_maelstrom
		.LOC 284
		.LOC 285
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR remove_bullet
	ADD R6, R6, #1	;; free space for arguments
		.LOC 286
L79_maelstrom
		.LOC 287
	LDR R7, R5, #-1
	LDR R7, R7, #5
	STR R7, R5, #-1
		.LOC 288
L71_maelstrom
		.LOC 273
	LDR R7, R5, #-1
	CONST R3, #0
	CMP R7, R3
	BRnp L70_maelstrom
		.LOC 289
L69_maelstrom
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

		.LOC 291
;;;;;;;;;;;;;;;;;;;;;;;;;;;;draw_asteroid;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
draw_asteroid
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-5	;; allocate stack space for local variables
	;; function body
		.LOC 291
		.LOC 293
	LDR R7, R5, #3
	LDR R7, R7, #1
	ADD R7, R7, #-4
	STR R7, R5, #-2
		.LOC 294
	LDR R7, R5, #3
	LDR R7, R7, #1
	STR R7, R5, #-3
		.LOC 295
	LDR R7, R5, #3
	LDR R7, R7, #2
	ADD R7, R7, #-4
	STR R7, R5, #-4
		.LOC 296
	LDR R7, R5, #3
	LDR R7, R7, #2
	STR R7, R5, #-5
		.LOC 297
	CONST R7, #0
	STR R7, R5, #-1
		.LOC 298
	LDR R7, R5, #3
	LDR R7, R7, #5
	CONST R3, #3
	CMP R7, R3
	BRnp L81_maelstrom
		.LOC 298
		.LOC 299
	CONST R7, #1
	STR R7, R5, #-1
		.LOC 300
L81_maelstrom
		.LOC 301
	LDR R7, R5, #3
	LDR R7, R7, #5
	CONST R3, #4
	CMP R7, R3
	BRnp L83_maelstrom
		.LOC 301
		.LOC 302
	CONST R7, #2
	STR R7, R5, #-1
		.LOC 303
L83_maelstrom
		.LOC 304
	LDR R7, R5, #-5
	CONST R3, #124
	CMP R7, R3
	BRnz L85_maelstrom
		.LOC 304
		.LOC 305
	LDR R7, R5, #-5
	CONST R3, #124
	SUB R7, R7, R3
	STR R7, R5, #-5
		.LOC 306
L85_maelstrom
		.LOC 307
	LDR R7, R5, #-4
	CONST R3, #0
	CMP R7, R3
	BRzp L87_maelstrom
		.LOC 307
		.LOC 308
	LDR R7, R5, #-4
	CONST R3, #124
	ADD R7, R7, R3
	STR R7, R5, #-4
		.LOC 309
L87_maelstrom
		.LOC 310
	LDR R7, R5, #-2
	CONST R3, #0
	CMP R7, R3
	BRzp L89_maelstrom
		.LOC 310
		.LOC 311
	LDR R7, R5, #-2
	CONST R3, #128
	ADD R7, R7, R3
	STR R7, R5, #-2
		.LOC 312
L89_maelstrom
		.LOC 313
	LDR R7, R5, #-3
	CONST R3, #128
	CMP R7, R3
	BRnz L91_maelstrom
		.LOC 313
		.LOC 314
	LDR R7, R5, #-3
	CONST R3, #128
	SUB R7, R7, R3
	STR R7, R5, #-3
		.LOC 315
L91_maelstrom
		.LOC 316
	LDR R7, R5, #-1
	SLL R7, R7, #2
	LEA R3, asteroid_bmps
	ADD R7, R7, R3
	LDR R7, R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #112
	HICONST R7, #7
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-4
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR draw_4x4_wrapped
	ADD R6, R6, #4	;; free space for arguments
		.LOC 317
	LDR R7, R5, #-1
	SLL R7, R7, #2
	LEA R3, asteroid_bmps
	ADD R7, R7, R3
	LDR R7, R7, #1
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #112
	HICONST R7, #7
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-4
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR draw_4x4_wrapped
	ADD R6, R6, #4	;; free space for arguments
		.LOC 318
	LDR R7, R5, #-1
	SLL R7, R7, #2
	LEA R3, asteroid_bmps
	ADD R7, R7, R3
	LDR R7, R7, #2
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #112
	HICONST R7, #7
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-5
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR draw_4x4_wrapped
	ADD R6, R6, #4	;; free space for arguments
		.LOC 319
	LDR R7, R5, #-1
	SLL R7, R7, #2
	LEA R3, asteroid_bmps
	ADD R7, R7, R3
	LDR R7, R7, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	CONST R7, #112
	HICONST R7, #7
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-5
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR draw_4x4_wrapped
	ADD R6, R6, #4	;; free space for arguments
		.LOC 320
L80_maelstrom
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

		.DATA
game_over 		.FILL #0
		.LOC 324
;;;;;;;;;;;;;;;;;;;;;;;;;;;;update;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
update
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-3	;; allocate stack space for local variables
	;; function body
		.LOC 324
		.LOC 325
	LEA R7, asteroid_headpointer
	LDR R7, R7, #0
	STR R7, R5, #-1
		.LOC 327
	JSR reset_vmem
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	JMP L95_maelstrom
L94_maelstrom
		.LOC 330
		.LOC 331
	LEA R7, bullet_headpointer
	LDR R7, R7, #0
	STR R7, R5, #-2
	JMP L98_maelstrom
L97_maelstrom
		.LOC 333
		.LOC 334
	LDR R7, R5, #-2
	STR R7, R5, #-3
		.LOC 336
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-2
	LDR R3, R7, #2
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R7, R7, #1
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	LDR R3, R7, #5
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R3, R7, #2
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R7, R7, #1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR collision
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #6	;; free space for arguments
	CONST R3, #0
	CMP R7, R3
	BRz L100_maelstrom
		.LOC 336
		.LOC 337
	LDR R7, R5, #-2
	CONST R3, #0
	STR R3, R7, #0
		.LOC 338
	LEA R7, score
	LDR R3, R7, #0
	ADD R3, R3, #1
	STR R3, R7, #0
		.LOC 339
	LEA R7, L102_maelstrom
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR puts
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
		.LOC 340
	CONST R7, #7
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, score_display
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, score
	LDR R7, R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR lc4_utoa
	ADD R6, R6, #3	;; free space for arguments
		.LOC 341
	LEA R7, score_display
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR puts
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
		.LOC 342
	LEA R7, L103_maelstrom
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR puts
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
		.LOC 343
	LDR R7, R5, #-1
	CONST R3, #0
	STR R3, R7, #0
		.LOC 344
L100_maelstrom
		.LOC 345
	LDR R7, R5, #-2
	LDR R7, R7, #5
	STR R7, R5, #-2
		.LOC 346
L98_maelstrom
		.LOC 333
	LDR R7, R5, #-2
	CONST R3, #0
	CMP R7, R3
	BRnp L97_maelstrom
		.LOC 349
	CONST R7, #3
	ADD R6, R6, #-1
	STR R7, R6, #0
	LEA R7, ship
	LDR R3, R7, #1
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R7, R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	LDR R7, R5, #-1
	LDR R3, R7, #5
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R3, R7, #2
	ADD R6, R6, #-1
	STR R3, R6, #0
	LDR R7, R7, #1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR collision
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #6	;; free space for arguments
	CONST R3, #0
	CMP R7, R3
	BRz L104_maelstrom
		.LOC 349
		.LOC 350
	LDR R7, R5, #-1
	CONST R3, #0
	STR R3, R7, #0
		.LOC 351
	LEA R7, L106_maelstrom
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR puts
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
		.LOC 352
	LEA R7, game_over
	CONST R3, #1
	STR R3, R7, #0
		.LOC 353
L104_maelstrom
		.LOC 355
	LDR R7, R5, #-1
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRz L107_maelstrom
		.LOC 355
		.LOC 356
	LDR R7, R5, #-1
	STR R7, R5, #-3
		.LOC 357
	LDR R7, R5, #-1
	LDR R7, R7, #1
	CONST R3, #0
	CMP R7, R3
	BRp L109_maelstrom
		.LOC 357
		.LOC 358
	LDR R7, R5, #-1
	ADD R7, R7, #1
	LDR R3, R7, #0
	CONST R2, #128
	ADD R3, R3, R2
	STR R3, R7, #0
		.LOC 359
	JMP L110_maelstrom
L109_maelstrom
		.LOC 360
	LDR R7, R5, #-1
	LDR R7, R7, #1
	CONST R3, #128
	CMP R7, R3
	BRn L111_maelstrom
		.LOC 360
		.LOC 361
	LDR R7, R5, #-1
	ADD R7, R7, #1
	LDR R3, R7, #0
	CONST R2, #128
	SUB R3, R3, R2
	STR R3, R7, #0
		.LOC 362
L111_maelstrom
L110_maelstrom
		.LOC 363
	LDR R7, R5, #-1
	LDR R7, R7, #2
	CONST R3, #0
	CMP R7, R3
	BRp L113_maelstrom
		.LOC 363
		.LOC 364
	LDR R7, R5, #-1
	ADD R7, R7, #2
	LDR R3, R7, #0
	CONST R2, #124
	ADD R3, R3, R2
	STR R3, R7, #0
		.LOC 365
	JMP L114_maelstrom
L113_maelstrom
		.LOC 366
	LDR R7, R5, #-1
	LDR R7, R7, #2
	CONST R3, #124
	CMP R7, R3
	BRn L115_maelstrom
		.LOC 366
		.LOC 367
	LDR R7, R5, #-1
	ADD R7, R7, #2
	LDR R3, R7, #0
	CONST R2, #124
	SUB R3, R3, R2
	STR R3, R7, #0
		.LOC 368
L115_maelstrom
L114_maelstrom
		.LOC 369
	LDR R7, R5, #-1
	ADD R3, R7, #1
	LDR R2, R3, #0
	LDR R7, R7, #3
	ADD R7, R2, R7
	STR R7, R3, #0
		.LOC 370
	LDR R7, R5, #-1
	ADD R3, R7, #2
	LDR R2, R3, #0
	LDR R7, R7, #4
	ADD R7, R2, R7
	STR R7, R3, #0
		.LOC 371
	LDR R7, R5, #-1
	LDR R7, R7, #6
	STR R7, R5, #-1
		.LOC 372
	LDR R7, R5, #-3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR draw_asteroid
	ADD R6, R6, #1	;; free space for arguments
		.LOC 373
	JMP L108_maelstrom
L107_maelstrom
		.LOC 374
	LDR R7, R5, #-1
	LDR R7, R7, #5
	CONST R3, #2
	CMP R7, R3
	BRnz L117_maelstrom
		.LOC 374
		.LOC 375
	LDR R7, R5, #-1
	STR R7, R5, #-3
		.LOC 376
	LDR R7, R5, #-1
	LDR R7, R7, #6
	STR R7, R5, #-1
		.LOC 377
	LDR R7, R5, #-3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR split
	ADD R6, R6, #1	;; free space for arguments
		.LOC 378
	JMP L118_maelstrom
L117_maelstrom
		.LOC 379
		.LOC 380
	LDR R7, R5, #-1
	STR R7, R5, #-3
		.LOC 381
	LDR R7, R5, #-1
	LDR R7, R7, #6
	STR R7, R5, #-1
		.LOC 382
	LDR R7, R5, #-3
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR remove_asteroid
	ADD R6, R6, #1	;; free space for arguments
		.LOC 383
L118_maelstrom
L108_maelstrom
		.LOC 384
L95_maelstrom
		.LOC 330
	LDR R7, R5, #-1
	CONST R3, #0
	CMP R7, R3
	BRnp L94_maelstrom
		.LOC 385
	JSR update_ship
	ADD R6, R6, #0	;; free space for arguments
		.LOC 386
	JSR update_bullets
	ADD R6, R6, #0	;; free space for arguments
		.LOC 387
	JSR blt_vmem
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
		.LOC 388
L93_maelstrom
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

		.LOC 390
;;;;;;;;;;;;;;;;;;;;;;;;;;;;rotate;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
rotate
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
		.LOC 390
		.LOC 391
	LDR R7, R5, #3
	CONST R3, #0
	CMP R7, R3
	BRz L120_maelstrom
		.LOC 391
		.LOC 392
	LEA R7, ship
	LDR R7, R7, #4
	CONST R3, #7
	CMP R7, R3
	BRnp L122_maelstrom
		.LOC 392
		.LOC 393
	LEA R7, ship
	CONST R3, #0
	STR R3, R7, #4
		.LOC 394
	JMP L121_maelstrom
L122_maelstrom
		.LOC 395
		.LOC 396
	LEA R7, ship
	ADD R7, R7, #4
	LDR R3, R7, #0
	ADD R3, R3, #1
	STR R3, R7, #0
		.LOC 397
		.LOC 398
	JMP L121_maelstrom
L120_maelstrom
		.LOC 399
		.LOC 400
	LEA R7, ship
	LDR R7, R7, #4
	CONST R3, #0
	CMP R7, R3
	BRnp L124_maelstrom
		.LOC 400
		.LOC 401
	LEA R7, ship
	CONST R3, #7
	STR R3, R7, #4
		.LOC 402
	JMP L125_maelstrom
L124_maelstrom
		.LOC 403
		.LOC 404
	LEA R7, ship
	ADD R7, R7, #4
	LDR R3, R7, #0
	ADD R3, R3, #-1
	STR R3, R7, #0
		.LOC 405
L125_maelstrom
		.LOC 406
L121_maelstrom
		.LOC 407
L119_maelstrom
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

		.LOC 409
;;;;;;;;;;;;;;;;;;;;;;;;;;;;thrust;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
thrust
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	;; function body
		.LOC 409
		.LOC 410
	LEA R7, ship
	LDR R3, R7, #2
	LDR R7, R7, #4
	LEA R2, t2vx
	ADD R7, R7, R2
	LDR R7, R7, #0
	SLL R7, R7, #2
	CMP R3, R7
	BRz L127_maelstrom
		.LOC 410
		.LOC 411
	LEA R7, ship
	ADD R3, R7, #2
	LDR R2, R3, #0
	LDR R7, R7, #4
	LEA R1, t2vx
	ADD R7, R7, R1
	LDR R7, R7, #0
	ADD R7, R2, R7
	STR R7, R3, #0
		.LOC 412
L127_maelstrom
		.LOC 413
	LEA R7, ship
	LDR R3, R7, #3
	LDR R7, R7, #4
	LEA R2, t2vy
	ADD R7, R7, R2
	LDR R7, R7, #0
	SLL R7, R7, #2
	CMP R3, R7
	BRz L129_maelstrom
		.LOC 413
		.LOC 414
	LEA R7, ship
	ADD R3, R7, #3
	LDR R2, R3, #0
	LDR R7, R7, #4
	LEA R1, t2vy
	ADD R7, R7, R1
	LDR R7, R7, #0
	ADD R7, R2, R7
	STR R7, R3, #0
		.LOC 415
L129_maelstrom
		.LOC 416
L126_maelstrom
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

		.LOC 418
;;;;;;;;;;;;;;;;;;;;;;;;;;;;fire;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
fire
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-1	;; allocate stack space for local variables
	;; function body
		.LOC 418
		.LOC 419
	JSR make_bullet
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
		.LOC 420
	LDR R7, R5, #-1
	CONST R3, #0
	CMP R7, R3
	BRz L132_maelstrom
		.LOC 420
		.LOC 421
	LEA R7, ship
	LDR R3, R5, #-1
	LDR R2, R7, #0
	CONST R1, #3
	LDR R7, R7, #4
	LEA R0, t2vx
	ADD R7, R7, R0
	LDR R7, R7, #0
	MUL R7, R1, R7
	ADD R7, R2, R7
	STR R7, R3, #1
		.LOC 422
	LEA R7, ship
	LDR R3, R5, #-1
	LDR R2, R7, #1
	CONST R1, #3
	LDR R7, R7, #4
	LEA R0, t2vy
	ADD R7, R7, R0
	LDR R7, R7, #0
	MUL R7, R1, R7
	ADD R7, R2, R7
	STR R7, R3, #2
		.LOC 423
	LEA R7, ship
	LDR R3, R5, #-1
	LDR R2, R7, #2
	LDR R7, R7, #4
	LEA R1, t2vx
	ADD R7, R7, R1
	LDR R7, R7, #0
	SLL R7, R7, #1
	ADD R7, R2, R7
	STR R7, R3, #3
		.LOC 424
	LEA R7, ship
	LDR R3, R5, #-1
	LDR R2, R7, #3
	LDR R7, R7, #4
	LEA R1, t2vy
	ADD R7, R7, R1
	LDR R7, R7, #0
	SLL R7, R7, #1
	ADD R7, R2, R7
	STR R7, R3, #4
		.LOC 425
L132_maelstrom
		.LOC 426
L131_maelstrom
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

		.LOC 428
;;;;;;;;;;;;;;;;;;;;;;;;;;;;reset;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
reset
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-4	;; allocate stack space for local variables
	;; function body
		.LOC 428
		.LOC 429
	JSR get_event
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-3
		.LOC 430
	LEA R7, bullet_headpointer
	LDR R7, R7, #0
	STR R7, R5, #-1
		.LOC 431
	LEA R7, asteroid_headpointer
	LDR R7, R7, #0
	STR R7, R5, #-2
		.LOC 432
	LEA R7, game_over
	CONST R3, #0
	STR R3, R7, #0
		.LOC 433
	LEA R7, L135_maelstrom
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR puts
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	JMP L137_maelstrom
L136_maelstrom
		.LOC 434
		.LOC 435
	JSR get_event
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-3
		.LOC 436
L137_maelstrom
		.LOC 434
	LDR R7, R5, #-3
	CONST R3, #0
	CMP R7, R3
	BRz L136_maelstrom
	JMP L140_maelstrom
L139_maelstrom
		.LOC 437
		.LOC 438
	LDR R7, R5, #-1
	STR R7, R5, #-4
		.LOC 439
	LDR R7, R5, #-1
	LDR R7, R7, #5
	STR R7, R5, #-1
		.LOC 440
	LDR R7, R5, #-4
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR remove_bullet
	ADD R6, R6, #1	;; free space for arguments
		.LOC 441
L140_maelstrom
		.LOC 437
	LDR R7, R5, #-1
	CONST R3, #0
	CMP R7, R3
	BRnp L139_maelstrom
	JMP L143_maelstrom
L142_maelstrom
		.LOC 442
		.LOC 443
	LDR R7, R5, #-2
	STR R7, R5, #-4
		.LOC 444
	LDR R7, R5, #-2
	LDR R7, R7, #6
	STR R7, R5, #-2
		.LOC 445
	LDR R7, R5, #-4
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR remove_asteroid
	ADD R6, R6, #1	;; free space for arguments
		.LOC 446
L143_maelstrom
		.LOC 442
	LDR R7, R5, #-2
	CONST R3, #0
	CMP R7, R3
	BRnp L142_maelstrom
		.LOC 447
	JSR init_ship
	ADD R6, R6, #0	;; free space for arguments
		.LOC 448
	JSR update
	ADD R6, R6, #0	;; free space for arguments
		.LOC 449
L134_maelstrom
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

		.LOC 452
;;;;;;;;;;;;;;;;;;;;;;;;;;;;main;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		.CODE
		.FALIGN
main
	;; prologue
	STR R7, R6, #-2	;; save return address
	STR R5, R6, #-3	;; save base pointer
	ADD R6, R6, #-3
	ADD R5, R6, #0
	ADD R6, R6, #-5	;; allocate stack space for local variables
	;; function body
		.LOC 453
		.LOC 455
	JSR get_event
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
		.LOC 457
	JSR init_ship
	ADD R6, R6, #0	;; free space for arguments
		.LOC 458
	JSR update
	ADD R6, R6, #0	;; free space for arguments
		.LOC 461
	LEA R7, L146_maelstrom
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR puts
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	JMP L148_maelstrom
L147_maelstrom
		.LOC 462
		.LOC 463
	JSR get_event
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
		.LOC 464
L148_maelstrom
		.LOC 462
	LDR R7, R5, #-1
	CONST R3, #0
	CMP R7, R3
	BRz L147_maelstrom
		.LOC 466
	LEA R7, L150_maelstrom
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR puts
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
	JMP L152_maelstrom
L151_maelstrom
		.LOC 467
		.LOC 469
	LEA R7, game_over
	LDR R7, R7, #0
	CONST R3, #0
	CMP R7, R3
	BRz L154_maelstrom
		.LOC 469
		.LOC 470
	JSR reset
	ADD R6, R6, #0	;; free space for arguments
		.LOC 471
	JMP L153_maelstrom
L154_maelstrom
		.LOC 473
	JSR get_event
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	STR R7, R5, #-1
		.LOC 476
	LDR R7, R5, #-1
	CONST R3, #0
	CMP R7, R3
	BRnp L156_maelstrom
		.LOC 476
		.LOC 477
	JSR make_random_asteroid
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #0	;; free space for arguments
	CONST R3, #0
	CMP R7, R3
	BRz L158_maelstrom
		.LOC 477
		.LOC 478
	JSR make_asteroid
	ADD R6, R6, #0	;; free space for arguments
		.LOC 479
L158_maelstrom
		.LOC 480
	JSR update
	ADD R6, R6, #0	;; free space for arguments
		.LOC 481
	JMP L157_maelstrom
L156_maelstrom
		.LOC 483
	LDR R7, R5, #-1
	STR R7, R5, #-2
	CONST R3, #106
	CMP R7, R3
	BRz L162_maelstrom
	CONST R7, #74
	LDR R3, R5, #-2
	CMP R3, R7
	BRnp L160_maelstrom
L162_maelstrom
		.LOC 483
		.LOC 484
	CONST R7, #1
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR rotate
	ADD R6, R6, #1	;; free space for arguments
		.LOC 485
	JMP L161_maelstrom
L160_maelstrom
		.LOC 487
	LDR R7, R5, #-1
	STR R7, R5, #-3
	CONST R3, #108
	CMP R7, R3
	BRz L165_maelstrom
	CONST R7, #76
	LDR R3, R5, #-3
	CMP R3, R7
	BRnp L163_maelstrom
L165_maelstrom
		.LOC 487
		.LOC 488
	CONST R7, #0
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR rotate
	ADD R6, R6, #1	;; free space for arguments
		.LOC 489
	JMP L164_maelstrom
L163_maelstrom
		.LOC 491
	LDR R7, R5, #-1
	STR R7, R5, #-4
	CONST R3, #107
	CMP R7, R3
	BRz L168_maelstrom
	CONST R7, #75
	LDR R3, R5, #-4
	CMP R3, R7
	BRnp L166_maelstrom
L168_maelstrom
		.LOC 491
		.LOC 492
	JSR thrust
	ADD R6, R6, #0	;; free space for arguments
		.LOC 493
	JMP L167_maelstrom
L166_maelstrom
		.LOC 495
	LDR R7, R5, #-1
	CONST R3, #32
	CMP R7, R3
	BRnp L169_maelstrom
		.LOC 495
		.LOC 496
	JSR fire
	ADD R6, R6, #0	;; free space for arguments
		.LOC 497
	JMP L170_maelstrom
L169_maelstrom
		.LOC 499
	LDR R7, R5, #-1
	STR R7, R5, #-5
	CONST R3, #113
	CMP R7, R3
	BRz L173_maelstrom
	CONST R7, #81
	LDR R3, R5, #-5
	CMP R3, R7
	BRnp L171_maelstrom
L173_maelstrom
		.LOC 499
		.LOC 500
	LEA R7, L174_maelstrom
	ADD R6, R6, #-1
	STR R7, R6, #0
	JSR puts
	LDR R7, R6, #-1	;; grab return value
	ADD R6, R6, #1	;; free space for arguments
		.LOC 501
	JSR reset
	ADD R6, R6, #0	;; free space for arguments
		.LOC 502
	JMP L153_maelstrom
L171_maelstrom
L170_maelstrom
L167_maelstrom
L164_maelstrom
L161_maelstrom
L157_maelstrom
		.LOC 505
L152_maelstrom
		.LOC 467
	JMP L151_maelstrom
L153_maelstrom
		.LOC 506
	CONST R7, #0
L145_maelstrom
	;; epilogue
	ADD R6, R5, #0	;; pop locals off stack
	ADD R6, R6, #3	;; free space for return address, base pointer, and return value
	STR R7, R6, #-1	;; store return value
	LDR R5, R6, #-3	;; restore base pointer
	LDR R7, R6, #-2	;; restore return address
	RET

		.DATA
score 		.BLKW 1
		.DATA
score_display 		.BLKW 7
		.DATA
ship 		.BLKW 5
		.DATA
L174_maelstrom 		.STRINGZ "Quit.\n"
		.DATA
L150_maelstrom 		.STRINGZ "Score: 0\n"
		.DATA
L146_maelstrom 		.STRINGZ "Press any key to begin!\n"
		.DATA
L135_maelstrom 		.STRINGZ "\nPress any key to restart\n"
		.DATA
L106_maelstrom 		.STRINGZ "game over\n"
		.DATA
L103_maelstrom 		.STRINGZ "\n"
		.DATA
L102_maelstrom 		.STRINGZ "score: "
