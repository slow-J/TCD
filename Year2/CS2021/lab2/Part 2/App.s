	AREA table, DATA, READWRITE

ttb DCD 0x00003780,0x00000300,0x00009580,0x00008780,0x0000A300,0x0000A680,0x0000B680,0x00000380,0x0000B780,0x0000A380,0x0000B380,0x0000B600,0x00003480,0x0009700,0x0000B480,0x0000B080	

	AREA	AsmTemplate, CODE, READONLY
	IMPORT	main

; 7 segment display
; (c) John Carbeck, 2018.

	EXPORT	start
start
IO0DIR	EQU	0xE0028008
IO0SET	EQU	0xE0028004
IO0CLR	EQU	0xE002800C

IO1PIN	EQU	0xE0028010

	LDR	R1,=IO0DIR
	LDR	R2,=0x0001B780	;select P1.19--P1.16
	STR	R2,[R1]		;make them outputs
	LDR	R1,=IO0SET
	STR	R2,[R1]		;set them to turn the LEDs off
	LDR	R2,=IO0CLR

	LDR R9, =ttb
	LDR R10, =0
	LDR R5, =0x00f00000
while
	LDR R4, =IO1PIN
	LDR R6, [R4]
	AND R4, R6, R5
	LSR R4, #20
	LDR R6, =4
	LDR R7, =0
for
	CMP R6, #0
	BLE endFor
	SUB R6, R6, #1
	LSRS R4, #1			;shift right 1 and set flags	
	BCS for				;branch if carry flag set
	ADD R7, R7, #1 		;R7 count of 0s in IO1PIN
	B	for
endFor
	CMP R7, #1
	BLT endCheck
	CMP R7, #2
	BGT moreThanTwo
	SUB R10, R10, #1
	B	endCheck
moreThanTwo	
	ADD R10, R10, #1
endCheck
	CMP R10, #0
	BGE notNeg
	LDR R10, =15
notNeg
	CMP R10, #15
	BLE notOver
	LDR R10, =0
notOver
	LDR R11, =4
	MUL R8, R11, R10
	LDR R8, [R9, R8]
	LDR R4, =0x000FFFF0
	STR R4, [R2]
	STR R8, [R1]
	
	LDR	R12, =5000000
dloop	SUBS	R12, R12, #1
	BNE	dloop
	
	B while
stop 	B 	stop
	END