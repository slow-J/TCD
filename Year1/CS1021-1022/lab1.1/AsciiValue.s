	AREA	AsciiValue, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR	R4, ='2'	; Load '2','0','3','4' into R4...R1
	LDR	R3, ='0'	;
	LDR	R2, ='3'	;
	LDR	R1, ='4'	;
	
	LDR R5, =48
	LDR R6, =1000
	LDR R7, =100
	LDR R8, =10
	
	SUB R4, R4, R5
	MUL R4, R6, R4	; result = 2*1000
	SUB R3, R3, R5
	MUL R3, R7, R3	; result = 0*100
	SUB R2, R2, R5
	MUL R2, R8, R2	; result = 3*10
	SUB R1, R1, R5	; result = 4
	
	ADD R0, R1, R2
	ADD R0, R0, R3
	ADD R0, R0, R4	; result = 2034
	
	
	
stop	B	stop

	END	