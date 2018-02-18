	AREA	SymmDiff, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
						; cCount =0
	LDR	R1, =AElems		
	LDR	R2, =ASize
	LDR	R3, =BElems	
	LDR R4, =BSize
	LDR R5, =CElems		; cAdr = CElems
	LDR R6, =CSize
	LDR R7, =0			; aCount
	LDR R11, =0			; cCount
	LDRB R7, [R2]		; aCount=Memory.word[aSize]
	LDRB R8, [R1]    	; aAdr = AElems
	CMP R7, #0			; while (aCount>0){
	BLS endwh	
	
while	
	
; a=mem.word[adr]
	LDRB R9, [R4]		; bCount = mem.word[Bsize]
	LDRB R10, [R3]		; bAdr = bElems
	CMP R9, #0			; while (bCOunt >0 
	BLS endwh			; && mem.word[bAdr]!)
	SUB R9, R9, #1		; {bCount--
	ADD R3, R3, #4		; bAdr+=4
	B while				; }
endwh	
while2
	CMP	R9, #0			; if (bCount!=0)
	BEQ endwhile		
	LDRB R12, [R5] 		; {mem.word(cAdr) = a
	ADD R5, R5, #4		; Cadr +=4
	ADD R11, R11, #1	; Ccount++
	ADD R1, R1, #4		; aAdr+=4
	SUB R7, R7, #1		; aCount--
	STRB R11, [R6]		; mem.word[csize] = cCount
endwhile
	B while2
		
		
stop	B	stop


	AREA	TestData, DATA, READWRITE

ASize	DCD	8			; Number of elements in A
AElems	DCD	4,6,2,13,19,7,1,3	; Elements of A

BSize	DCD	6			; Number of elements in B
BElems	DCD	13,9,1,20,5,8		; Elements of B

CSize	DCD	0			; Number of elements in C
CElems	SPACE	56			; Elements of C

	END
