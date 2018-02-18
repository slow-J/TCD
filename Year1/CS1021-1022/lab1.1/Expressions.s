	AREA	Expressions, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR	R1, =5	; x = 5
	LDR	R2, =6	; y = 6
	
	LDR R3, =3
	LDR R4, =5
	MUL R4, R1, R4 ; result = 5x
	MOV R5, R1     
	MUL R5, R1, R5
	MUL R5, R3, R5
	ADD R0, R5, R4
	
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	LDR R6, =2
	LDR R7, =6
	LDR R8, =3
	MUL R7, R1, R7 ; result = 6x
	MUL R7, R2, R7 ; result = 6xy
	MOV R9, R1
	MUL R9, R1, R9 ; result = x^2
	MUL R9, R6, R9
	MOV R10, R2
	MUL R10, R2, R10
	MUL R10, R8, R10
	ADD R0, R10, R9
	ADD R0, R0, R7
	
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		
	LDR R3, = 4
	LDR R4, = 3
	LDR R5, = 8
	MOV R6, R1
	MUL R6, R1, R6
	MUL R7, R1, R6
	MUL R6, R3, R6 ; result = 4x^2
	MUL R4, R1, R4
	SUB R0, R7, R6
	ADD R0, R0, R4
	ADD R0, R0, R5
	
stop	B	stop

	END	