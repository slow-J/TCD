	AREA	Divide, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR R0, = 0

	CMP R3, #0
	BEQ endifzero
	MOV R1, R2		; remainder = a ;
while				; while 
	CMP R1, R3		;(remainder >= b )
	BLO endwh		; {
	ADD R0, R0, #1	;	quotient = quotient + 1 ;
	SUB R1, R1, R3	;	remainder = remainder - b ;
	B while			; }
endwh
endifzero
stop	B	stop

	END	