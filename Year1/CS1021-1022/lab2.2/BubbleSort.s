	AREA	BubbleSort, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR	R4, =array	; address of array
	LDR	R5, =arrayN	; address of array size
	LDR	R5, [R5]	; load array size


	LDR R6, =1				
while						;do{
	CMP R6, #1				
	BNE endWhile
	LDR R6, =0				;swapped = false;
	LDR R7, =1				
whilefour
	CMP R7, R5				;if(i>N)	branch endwhilefour;
	BHS branchToWhile
	SUB R11, R7, #1
	LDR R10, [R4, R11, LSL#2] 
	LDR R1, [R4, R7, LSL#2]			;if ( array[i-1] > array[ i ] )
	CMP R10, R1 				
	BLS endIfLower
	BL funcA 				;swap ( array , i-1, i ) ;
	LDR R6, =1				;swapped = true ;
			
endIfLower					
	ADD R7, R7, #1	
	B whilefour

branchToWhile
	B while

endWhile					;} while(swapped)
	
stop	B	stop

funcA
	STMFD sp!, {R4, R11, R7, lr}		; swap(array, i-1, i){
	LDR R1, [R4, R7, LSL #2]		; valueA = array[i]
	LDR R2, [R4, R11, LSL #2]		; valueB = array[i-1]
	STR R1, [R4, R11, LSL #2] 		; array[i-1] = valueA
	STR R2, [R4, R7, LSL #2]		; array[i] = valueB
	LDMFD sp!, {R4, R11, R7, pc}

	AREA	TestArray, DATA, READWRITE

; Array Size
arrayN	DCD	15

; Array Elements
array	DCD	33,17,18,92,49,28,78,75,22,13,19,13,8,44,35

	END	