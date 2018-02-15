	AREA	ConsoleInput, CODE, READONLY
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
	LDR R4, =0 	; running total = 0
	LDR R5, =10
	LDR R11, =0	; ascii into hex
read
	BL	getkey		; read key from console
	CMP	R0, #0x0D  	; while (key != CR)
	BEQ	endRead		; {
	BL	sendchar	;   echo key back to console

	
	SUB R11, R0, #0x30	;
	MUL R4, R5, R4		;running total*10
	ADD R4, R11, R4		;running total + user input
	

				

	B	read		; }
	
endRead

stop	B	stop

 AREA	MyStrings, DATA, READONLY
hi	DCB	"Enter your desired numbers here > ",0

	END	