	AREA	StatEval, CODE, READONLY
	IMPORT	main
	IMPORT	getkey
	IMPORT	sendchar
	IMPORT 	fputs
	EXPORT	start
	PRESERVE8


start

	LDR	R0, =hi
    LDR	R1, =0
    BL	fputs
	LDR R4, =0 			; running total = 0
	LDR R5, =10
	LDR R6, =0     		; loop count
	LDR R7, =0			; sum
	LDR R8, =0			; max
	LDR R9, =0x7FFFFFFF	; min
	LDR R10, =0			; mean count
	LDR R11, =0			; ascii into hex
	LDR R12, =0			; arbitary number used in mean calculation
	
read
	BL	getkey			; read key from console
	CMP R0, #0x20
	BEQ skipDown
	CMP	R0, #0x0D  		; while (key != CR)
	BEQ	endRead			; {
	BL	sendchar		;   echo key back to console

	
	SUB R11, R0, #0x30	;
	MUL R4, R5, R4		;running total*10
	ADD R4, R11, R4		;running total + user input
	
	ADD R6, R6, #1		; count++
	
	ADD R7, R7, R11		; sum

	
	
	CMP R11, R8			; if (number > max)
	BHI	replaceMax		;{
	B ctd				;	
replaceMax				;
	MOV R8, R11			;max = number
						;}	
ctd


	CMP R11, R9			;if (number < min)
	BLO replaceMin		;{
	B ctd2				;
replaceMin				;	
	MOV R9, R11			;min = number	
ctd2					;}
	
	B	read			;} 
	
endRead

skipDown
	BL sendchar
	MOV R12, R7

while 
	CMP R12, R6			; mean if (loop <= sum)
	BLO endWh			; {
						;	
	SUB R12, R12, R6	; sum = (sum - loop count)
	ADD R10, R10, #1	; mean++	
	B while				; }
endWh
	B read

	SUB R7, R7, #0x30	; changing ascii to hex
	
	
stop	B	stop


 AREA	MyStrings, DATA, READONLY
 
hi	DCB	"Enter your desired numbers here > ",0

	END	