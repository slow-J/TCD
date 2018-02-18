	AREA	Flags, CODE, READONLY
	IMPORT	main
	EXPORT	start

start

	LDR R0 , =0xC0001000
	LDR R1 , =0x51004000
	ADDS R2 , R0 , R1 ; result = 0x11005000, N=0, Z=0, C=1, V=0 
	LDR R3 , =0x92004000
	SUBS R4 , R3 , R3 ; result = 0x00000000, N=0, Z=1, C=1, V=0
	LDR R5 , =0x74000100
	LDR R6 , =0x40004000
	ADDS R7 , R5 , R6 ; result = 0xB4004100, N=1, Z=0, C=0, V=1
	LDR R1 , =0x6E0074F2
	LDR R2 , =0x211D6000
	ADDS R0 , R1 , R2 ; result = 0x8F1DD4F2, N=1, Z=0, C=0, V=1
	LDR R1 , =0xBF2FDD1E
	LDR R2 , =0x40D022E2
	ADDS R0 , R1 , R2 ; result = 0x00000000, N=0, Z=1, C=1, V=0


	
stop	B	stop

	END	