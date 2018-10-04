includelib legacy_stdio_definitions.lib
extrn printf:near
.data
option casemap:none

public g
g QWORD 4;

.code

;;;;;;;;;;;;
public	min
min:	mov		rax, rcx	; v = a
		cmp		rax, rdx
		jle		min0
		mov		rax, rdx

min0:	mov		rsi, r8
		cmp		rax, rsi
		jle		min1
		mov		rax, r8

min1:	ret		0;

;;;;;;;;;;;;
public	p
p:		mov		rbx, rcx	; i
		mov		rsi, rdx	; j
		sub		rsp, 32		; shadow space
		mov		r8, rsi		; j 
		mov		rdx, rbx
		mov		rcx, g
		
		call	min				;result in rax
		add		rsp, 32

		mov		rbx, r9	; l
		mov		rsi, r8	; k
		sub		rsp, 32		; shadow space

		mov		r8, rbx
		mov		rdx, rsi
		mov		rcx, rax
		
		call	min
		add		rsp, 32
		
		ret		0
		
;;;;;;;;;;;;
public	gcd
gcd:	;rcx = a rdx = b
		xor		rsi, rsi	; 0		
		cmp		rsi, rdx	; b
		je		gcd0
		
		mov		rsi, rdx

		xor		rdx, rdx			;remainder	
		mov		rax, rcx		
		mov		rcx, rsi		; fix
		idiv	rcx

		
		sub		rsp, 32		; shadow space
		mov		rdx, rdx
		mov		rcx, rsi	
		
		
		call	 gcd
		add		rsp, 32		; shadow space
		
		jmp		gcd1
		
gcd0:	mov		rax, rcx	

gcd1:	ret		0	
		
;;;;;;;;;;;;
public	q

fxp2	db	'a = %I64d b = %I64d c = %I64d d = %I64d e = %I64d sum = %I64d', 0AH, 00H

q:		xor		rax, rax
		add		rax, rcx		; a
		add		rax, rdx		; b
		add		rax, r8			; c
		add		rax, r9			; d
		add		rax, [rsp+40]	; e

		mov		r13, rcx		; a ---moving all params into regs
		mov		r12, rdx		; b
		mov		r11, r8			; c
		mov		r14, r9			; d
		mov		rbx, [rsp+40]	; e

		push	rax				; preserve rax
		
		sub		rsp, 32
		sub		rsp, 16
		mov		[rsp+48], rax	; sum
		mov		[rsp+40], rbx	; e
		mov		[rsp+32], r14	; d	
		mov		r9, r11			; c		
		mov		r8, r12			; b
		mov		rdx, r13		; a
		
		xor		rax, rax
		lea		rcx, fxp2		; string
		
		call 	printf
		add		rsp, 16
		add		rsp, 32
		

		pop		rax

		ret		0

public	qns

fxp3	db	'qns', 0AH, 00H

qns:	;lea		rcx, fxp3
		;call	printf

		sub		rsp, 32
		lea		rcx, fxp3
		call	printf
		add		rsp, 32

		xor		rax, rax
		ret		0
end