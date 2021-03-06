	AREA	Unique, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR R0, =1		; areUniqueValues = 1
	LDR	R1, =VALUES	; adr
	LDR R2, =COUNT	; #ofElems
	LDR R2, [R2]	
	LDR R3, =0		; count=0
	MOV R4, R2		; #ofElemsRemaining = #ofElems
	LDR R5, =4		; word size
	LDR	R6, =0		; countOfElemsToBeChecked= 0
	LDR R7, =0		; adrMove = 0

while
	CMP R6, R2					; while(countOfElemsToBeChecked<#ofElems
	BHS endwhile				; AND
	CMP R0, #1					; areUniqueValues==1)
	BNE endwhile				; {
	LDR R8, [R1]				; charA=Memory.word[adr]
whileCharsChecked				; while
	CMP R3, R4					; (count<#ofElemsRemaining)
	BHS endWhileCharsChecked	; {
	ADD R1, R1, #4				; adress=address+4
	LDR R9, [R1]				; charB=Memory.word[adr]
	CMP R8, R9					; if(charA=charB)
	BNE endifequal				; {
	MOV R0, #0					; areUniqueValues = 0
endifequal						; }
	ADD R3, R3, #1				; count = count + 1
	B	whileCharsChecked		; }
endWhileCharsChecked
	SUB R3, R3, #1				; count = count - 1
	MUL R7, R3, R5				; adrMove = count*4
	SUB R1, R1, R7				; adress = address - adrMove
	LDR R3, =0					; count is reset to 0
	ADD R6, R6, #1				; countOfElemsToBeChecked=countOfElemstoBeChecked+1
	SUB R4, R4, #1				; #ofElemsRemaining = #ofElemsRemaining - 1
	B while						; }
endwhile
	
stop	B	stop


	AREA	TestData, DATA, READWRITE

COUNT	DCD	10
VALUES	DCD	5, 2, 7, 4, 13, 4, 18, 8, 9, 12


	END
