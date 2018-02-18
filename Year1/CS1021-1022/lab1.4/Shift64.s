	AREA	Shift64, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR	R0, =0x13131313		
	LDR	R1, =0x13131313		
	LDR	R2, =2
	MOV R3, R2					; count = value
	LDR R4, =0x80000000			; maskForPositive = 0x80000000
	LDR R5, =0x7FFFFFFF			; MAX_POSITIVE_VALUE
	LDR R6, =0x00000001			; maskForNegative = 0x00000001

	CMP R2, R5					; if(value == positive)
	BHI elsenegative			; {
	
whilecount
	CMP R3, #0					; while
	BEQ endwhilecount			; (count!=0){
	MOVS R1, R1, LSR #1			; R1 logic shifted right by 1, carry code flag set to bit shifted out
	BCS elseifset				; if(carry==0){
	MOV R0, R0, LSR #1			; R0 logic shifted right by 1
	SUB R3, R3, #1				; count = count - 1
	B endifclear				; }
elseifset						; else{
	MOV R0, R0, LSR #1			; R0 logic shifted right by 1
	ORR R0, R0, R4				; most significant bit of R0 set to 1, using mask1
	SUB R3, R3, #1				; count = count - 1
endifclear						; }
	B whilecount				; }
endwhilecount
	
	B endifpositive				; }
elsenegative					; else{
	
	LDR R7, =0xFFFFFFFF			; maskToInvert = 0xFFFFFFFF
	SUB R3, R3, #1				; count--
	EOR R3, R3, R7				; bits inverted to change count from a negative to its positive equivalent
	
whilegreaterthanzero
	CMP R3, #0					; while
	BEQ endwhilegreaterthanzero	; (count!=0){
	MOVS R0, R0, LSL #1			; R0 logic shifted left by 1, carry code flag set to bit shifted out
	BCS elseifsettoone			; if(carry==0){
	MOV R1, R1, LSL #1			; R1 logic shifted left by 1
	SUB R3, R3, #1				; count = count - 1
	B endifone					; {
elseifsettoone					; else{
	MOV R1, R1, LSL #1			; R1 logic shifted left by 1
	ORR R1, R1, R6				; least significant of R1 bit set to 1, using mask2
	SUB R3, R3, #1				; count = count - 1
endifone						; }
	B whilegreaterthanzero		; }
endwhilegreaterthanzero

endifpositive					; }

stop	B	stop


	END
		