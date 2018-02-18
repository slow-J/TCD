	AREA	Anagram, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR	R1, =stringA
	LDR	R2, =stringB
	LDR R5, =0			; countA
	LDR	R6, =0			; countB
	
	
while
	LDRB R3, [R1]		; temp	
	CMP R3, #'A' 		; if (char >= 'A'
	BLO endifLC  		; AND
	CMP R3, #'Z' 		; char <= 'Z')
	BHI endifLC
	ADD R3, R3, #0x20 	; char = char + 0x20
	STRB R3, [R1]		; Memory.byte[address] = char
	
endifLC	
	ADD R1, R1, #1
	ADD R5, R5, #1		;countA++
	LDRB R3, [R1]		
	CMP R3, #0x0		;if char=0
	BEQ endWhile		;break
	B while

endWhile

while2
	LDRB R4, [R2]		; temp	
	CMP R4, #'A' 		; if (char >= 'A'
	BLO endifLC2 		; AND
	CMP R4, #'Z' 		; char <= 'Z')
	BHI endifLC2
	ADD R4, R4, #0x20 	; char = char + 0x20
	STRB R4, [R2] 		; Memory.byte[address] = char

endifLC2	
	ADD R2, R2, #1
	ADD R6, R6, #1		;countB++
	LDRB R4, [R2]		; Memory.byte[address] = char
	CMP R4, #0x0		;if char=0
	BEQ endWhile2		;break

	B while2

endWhile2
	SUB R1, R1, R5		;adr = adr-loopCount
	SUB R2, R2, R6  	;adr = adr-loopCount
	

	LDR R0, =1			; isAnagram=1
	
	CMP R0, #0			; if( anagram =0
	BEQ endcompletely	; {end
						;}
					
	LDRB R7, [R1]		; charA=Memory.word[adr]
	LDRB R8, [R2]
	LDR R9, =0			; count for while3
while3					; while
			
	
	CMP R7, R8
	BEQ anagram
	ADD R9, R9, #1		;count++
	ADD R2, R2, #1		; adress=address+1
	LDRB R8, [R2]		; charB=Memory.word[adr]
	CMP R8, #0x0		; if (next char =0)
	BEQ notAnagram		
	B while3
anagram
	ADD R8, R8, #0x20	;char=upper ;if already used
	STRB R8, [R2]
	SUB R2, R2, R9
	LDR R9, =0
	
	LDRB R8, [R2]
	ADD R1, R1, #1		;adr++
	LDRB R7, [R1]
	CMP R7, #0x0		;if (next char=0)
	BEQ endcompletely	;break
	B while3

notAnagram
	MOV R0, #0			; anagram=0

endcompletely	
stop	B	stop



	AREA	TestData, DATA, READWRITE

stringA	DCB	"bests",0
stringB	DCB	"beets",0

	END
