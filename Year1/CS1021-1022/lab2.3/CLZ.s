	AREA	CLZ, CODE, READONLY
	IMPORT	main
	EXPORT	start

start
	LDR R3, =0			;temp
	LDR R6, =0
	LDR	R4, =0x40000024
	LDR	R5, =undefinedHandler ; Address of new undefined handler
	STR	R5, [r4]			; Store new undef handler address
	
	LDR	R4, =	0x00FFFFFF
	
	DCD	0x716F0F14			; POW r0, r4, r5 (r0 = r4 ^ r5)
		
stop	B	stop	


; Undefined exception handler
undefinedHandler
	STMFD	sp!, {R0-R12, LR}	; save registers

	LDR	R4, [lr, #-4]		; load undefinied instruction
	BIC	R5, R4, #0xFFF0FFFF	; clear all except opcode bits
	TEQ	R5, #0x00010000		; check for undefined opcode 0x1
	BNE	endWh				; if (power instruction) branch to endif1

	BIC	R5, R4, #0xFFFFFFF0	;isolate Rm register number
	BIC	R7, R4, #0xFFFF0FFF	;isolate Rd register number
	MOV	R7, R7, LSR #8		;R7>>#8

	LDR	R6, [sp, R5, LSL #2]	;grab saved Rm off stack

	BL	clzSub			;  call clz subroutine

	STR	R6, [sp, R7, LSL #2]	;  save result over saved Rd		
endWh					; }
	LDMFD	sp!, {R0-R12, PC}^	; restore register and CPSR


;clz subroutine
clzSub
	STMFD	sp!, {R1, lr}
while
	BIC	R3, R1, #0x7FFFFFFF	; clear all bit except most significant
	CMP R3, #0				; if(tmp == 0)
	BNE endClz				; branch endClz
	ADD R6, R6, #1			; total++
	LSL	R1, R1, #1			; number << 1
	B	while
endClz
	LDMFD	sp!, {R1, pc}

	END