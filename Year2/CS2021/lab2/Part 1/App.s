	AREA table, DATA, READWRITE
;   	bits that need to be turned on from values 0 - F
ttb DCD 0x00003780,0x00000300,0x00009580,0x00008780,0x0000A300,0x0000A680,0x0000B680,0x00000380,0x0000B780,0x0000A380,0x0000B380,0x0000B600,0x00003480,0x0009700,0x0000B480,0x0000B080	
		
		;0000 0000 0000 0000 0011 0111 1000 0000
		;31   27   23   19   15   11   7    3
		;                  . G FE  DCB A
		; A = P0.7
		; B = P0.8
		; C = P0.9
		; D = P0.10
		; E = P0.12
		; F = P0.13
		; G = P0.15
		; RDP = P0.16
		
	AREA	AsmTemplate, CODE, READONLY
	IMPORT	main

; 7 segment display
; (c) John Carbeck, 2018.

	EXPORT	start
start

IO0DIR	EQU	0xE0028008
IO0SET	EQU	0xE0028004
IO0CLR	EQU	0xE002800C

	LDR	R1,=IO0DIR
	LDR	R2,=0x0001B780
;   0000 0000 0000 0001 1011 0111 1000 0000
;   31   27   23   19   15   11   7    3
	STR	R2,[R1]		
	LDR	R1,=IO0SET
	STR	R2,[R1]		
	LDR	R2,=IO0CLR

	LDR R3, =4
	LDR R4, =ttb
	LDR R5, =0x000FFFF0 ;all leds
restart
	LDR	R6, =15    		;end of table
	MUL R7, R6, R3		; multiply by 4 for memory sized jumpe
while
	CMP R6, #0			;for loop counting down from 15
	BLT restart
	ADD R8, R4, R7		;start of table plus memory offset
	LDR R8, [R4, R7]	;load value from table
	STR R5, [R2]		;turn off all led that are on
	STR R8, [R1]		;turn on bits specified by value
;delay for about a half second
	LDR	R9, =5000000
dloop	SUBS	R9, R9, #1
	BNE	dloop
	SUB R6, R6, #1
	SUB R7, R7, #4
	B while
	
stop	B	stop
	END