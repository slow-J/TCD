	AREA	ArrayMove, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR	R0, =array
	LDR	R1, =N
	LDR	R2, =6		; move from index
	LDR	R3, =3		; move to index
	
	
	SUB R6, R2, R3				;index difference
	LDR R7, [R0, R2, LSL#2]

shiftRight
	CMP R6, #0					;if(R6==0)
	BEQ finish					;Branch to finish
	SUB R4, R2, #1 	 		  	;R4 = next position down in array
	LDR R5, [R0, R4, LSL#2]   	
	STR R5, [R0, R2, LSL#2]   
	SUB R2, R2, #1
	SUB R6, R6, #1
	B shiftRight
	
finish
	
	STR R7, [R0, R3, LSL#2] 	

	
stop	B	stop


	AREA	TestArray, DATA, READWRITE

N	equ	9
array	DCD	7,2,5,9,1,3,2,3,4

	END	