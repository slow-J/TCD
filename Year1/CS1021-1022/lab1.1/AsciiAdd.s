	AREA	AsciiAdd, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR	R1, ='2'	; R1 = 0x32 (ASCII symbol '2')
	LDR	R2, ='4'	; R2 = 0x34 (ASCII symbol '4')	
	LDR R3, =48
	SUB R1, R1, R3
	SUB R2, R2, R3
	ADD R0, R1, R2
	ADD R0, R0, R3  ; your program goes here
	
stop	B	stop

	END	