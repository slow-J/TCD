	AREA	ShiftAndAdd, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR	R1, =9
	LDR	R2, =10
	LDR R3, =8				; power = MAX_POWER = 31
	LDR R4, =0				; finished =false
	MOV R5, R2				; remainingDivisor = divisor
	LDR R7, =1			
	
 	
whNotFin				
	CMP R4, #0				; while(!finished)
	BNE endWhNotFin 		;{
	MOV R6, R7, LSL R3 		; 2^power 
	CMP R5, R6				;if(remainingDivisor>=2^power)
	BLO elseIfLower			;{
	SUB R5, R5, R6			;remainingDivisor=remainingDivisor-2^power
	MOV R0, R1, LSL R3		;a*2^power
	SUB R3, R3, #1			;power=power-1
	LDR R4, =1				;finished = true
	B endIfHigher			;}
elseIfLower					;else{
	SUB R3, R3, #1			;power=power-1
endIfHigher					;}
	B whNotFin				;}
endWhNotFin					

whilepower					
	CMP R3, #0				;while(power!=0)
	BEQ endwhilepower		;{
	MOV R6, R7, LSL R3 		; 2^power 
	ADD R11, R0, R6			;
	CMP R5, R6				;if(remainingDivisor>=2^power)							
	BLO endifgreater		;{
	ADD R0, R0, R1, LSL R3	;+a*2^power
	SUB R5, R5, R6			;remainingDivisor=remainingDivisor-2^power
endifgreater				;}
	SUB R3, R3, #1			;power=power-1
	B whilepower			;}
endwhilepower					
					
	LDR R8, =0
	LDR R9, =2				; let a = 10 and b = 2, for a/b
	MOV R10, R2				; remainder = a 
while						; while 
	CMP R10, R9				;(remainder >= b )
	BLO endwh				; {
	ADD R8, R8, #1			;	quotient = quotient + 1 ;
	SUB R10, R10, R9		;	remainder = remainder - b ;
	B while					; }
endwh
	
	CMP R10, #0				;if(divisor = odd)
	BEQ endifeven			;{
	ADD R0,	R0, R1			;+a*2^0
endifeven					;}
stop	B	stop


	END	
	