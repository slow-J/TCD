	AREA	ProperCase, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR R1, =testStr
	
	LDRB R2, [R1]		; char = Memory.byte[address]	

	CMP R2, #'a' 		; if (char >= 'a'
	BLO endifHC  		; AND
	CMP R2, #'z' 		; char <= 'z')
	BHI endifHC		; {
	SUB R2, R2, #0x20 	; char = char – 0x20
	STRB R2, [R1] 		; Memory.byte[address] = char
endifHC				; }
	
	ADD R1, R1, #1		; adr = adr +1
	LDRB R2, [R1]		; char = Memory.byte[address]
	
while
	CMP R2, #0		; while(char!=0)
	BEQ endWhile		; {
	

	CMP R2, #0x20		; if (char!=SPACE)
	BEQ elseNotSpace	;{
	
	CMP R2, #'A' 		; if (char >= 'A'
	BLO endifLC  		; AND
	CMP R2, #'Z' 		; char <= 'Z')
	BHI endifLC		; {
	ADD R2, R2, #0x20 	; char = char + 0x20
	STRB R2, [R1] 		; Memory.byte[address] = char
endifLC				; {
	B endifSpace
elseNotSpace			; } else{
	
				; 
				; 
	ADD R1, R1, #1		; adr = adr +1
	LDRB R2, [R1]		; char = Memory.byte[address]
	CMP R2, #'a' 		; if (char >= 'a'
	BLO endifFirst  	; AND
	CMP R2, #'z' 		; char <= 'z')
	BHI endifFirst		; {
	SUB R2, R2, #0x20 	; char = char – 0x20
	STRB R2, [R1] 		; Memory.byte[address] = char
endifFirst			; }

endifSpace			; }
	ADD R1, R1, #1		; adr = adr +1
	LDRB R2, [R1]		; char = Memory.byte[address]
	
	B while			; }
endWhile

		




stop	B	stop



	AREA	TestData, DATA, READWRITE

testStr	DCB	"hello WORLD",0

	END
