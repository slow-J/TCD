	AREA	Val2Dec, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR	R4, =7890
	LDR	R5, =decstr
	LDR 	R6, =4
	
	LDR R8, =0			; digits = 0
while	
	CMP R4, #0			; if (value!=0)	branch endWhile;
	BEQ endWhile
	BL func1			; divide()
	SUB SP, SP, #4		; sp-=4
	STR R7, [SP]		; push remainder onto stack
	MOV R4, R0			; value = quotient
	ADD R8, R8, #1		; digits++
	B while				
endWhile

pop				
	CMP R8, #0			; if (digits!=0)	branch endPop
	BEQ endPop		
	LDR R9, [SP]		; pop first digit
	ADD SP, SP, #4
	ADD R9, R9, #0x30	; convert digit to ascii
	STRB R9, [R5]		; store digit in string
	ADD R5, R5, #1		; stringAdr++
	SUB R8, R8, #1		; digits--
	B pop			
endPop


stop	B	stop

func1
	STMFD sp!, {R4, lr}	; divide(int value){
	LDR R0, =0			; c = 0
	LDR R2, =10			; b = 10

whileDivide			
	CMP R4, R2			; if (a>b)	branch endWhileDivide;
	BLO endWhileDivide
	SUB R4, R4, R2		; a = a-b
	ADD R0, R0, #1		; c++
	B	whileDivide			
endWhileDivide
	
	MOV R7, R4			; remainder = a
	LDMFD sp!, {R4, pc}

	AREA	TestString, DATA, READWRITE

decstr	SPACE	16

	END	
