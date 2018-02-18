	AREA	GCD, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	
	LDR R0, =0
	LDR R2, =24
	LDR R3, =32
while				; while 
	CMP R2, R3 		; ( a != b )
	BEQ endwhile	; {
	CMP R2, R3		; if ( a > b )
	BLS elsesub		; {
	SUB R2, R2, R3	;a = a - b ;
	B endifsub		;}
elsesub				;e l s e
	SUB R3, R3, R2	;{b = b - a ;
endifsub			;}
	B while
endwhile			;}
	MOV R0, R2
	
stop	B	stop

	END	