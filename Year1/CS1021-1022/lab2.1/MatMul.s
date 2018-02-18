	AREA	MatMul, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR	R0, =matR
	LDR	R1, =matA
	LDR	R2, =matB
	LDR	R3, =N
	
	LDR R4, =0				;i=0
	LDR R5, =0				;j=0
	LDR R6, =0				;k=0
	
	LDR R8, =0
	LDR R9, =0
	LDR R10,=0
	LDR R11,=0
	LDR R12, =0
	
while1
	CMP R4, R3				;if(i>N)
	BHS endWh1				;Branch to endWhile1		;for ( i = 0 ; i < N; i ++) 

	
while2
	CMP R5, R3				;if(j>N)					;for (j=0; j<N, j++)
	BHS endWh2				;Branch to endWhile2	

	MOV R7, #0				;r=0
	
while3	
	CMP R6, R3				;if(k>N)					;for (k=0; k<N, k++)
	BHS endWh3				;Branch to endWhile3

	MUL R8, R4, R3			;index= row(i) * row_size
	ADD R8, R8, R6			;index= index +col (k)
	LDR R9, [R1, R8, LSL #2] ; elem = Memory.Word[pArr + (index*4)]
	
	MUL R10, R6, R3			;index= row(k) * row_size
	ADD R10, R10, R5		;index= index + col(j)
	LDR R11, [R2, R10, LSL #2] ;elem = Memory.Word[pArr + (index*4)]
	
	MUL R12, R9, R11		;R12= A[ i , k ] * B[ k , j ]
	ADD R7, R7, R12 		;r = r + ( A[ i , k ] * B[ k , j ] )
	
	ADD R6, R6, #1			;k++
	B while3				;loop back to while3
	
endWh3
	MOV R6, #0				;k=0
	
	MUL R12, R4, R3
	ADD R12, R12, R5
	STR R7, [R0, R12, LSL #2] ;R[ i , j ] = r 
	ADD R5, R5, #1			;j++	
	B while2
	
endWh2
	MOV R5, #0				;j=0
	ADD R4, R4, #1			;i ++
	B while1
	
endWh1
	
stop	B	stop

	AREA	TestArray, DATA, READWRITE

N	EQU	4

matA	DCD	5,4,3,2
	DCD	3,4,3,4
	DCD	2,3,4,5
	DCD	4,3,4,3

matB	DCD	5,4,3,2
	DCD	3,4,3,4
	DCD	2,3,4,5
	DCD	4,3,4,3

matR	SPACE	64

	END	