.686                                ; create 32 bit code
.model flat, C                      ; 32 bit memory model
 option casemap:none                ; case sensitive

data segment; start of a data section
public g ; export variable g
g DWORD 4 ; declare global variable g initialised to 4
data ends
.code ; start of a code section

public	min							; make sure function name is exported

min:	push	ebp
		mov		ebp, esp			;
		mov		esi, [ebp+8]		; esi = a
		mov		eax, esi			; eax = a
		mov		esi, [ebp+12]		; esi = b
		cmp		esi, eax			; if(b < v)
		jge		min0
		mov		eax, esi			; eax = b

min0:	mov		esi, [ebp+16]		; esi = c
		cmp		esi, eax			; if(c < v)
		jge		min1
		mov		eax, esi			; eax = c

min1:	mov		esp, ebp			; restore esp
		pop		ebp					; restore previous ebp
		ret		0					; return from function


;;;;;;;;;;;;;;;;;;;;
public	p							; make sure function name is exported

p:		push	ebp
		mov		ebp, esp			;
		
		push	[ebp+12]
		push	[ebp+8]
		push	g					; global variable

	
		call	min

		add		esp, 12				; remove from stack
	
		push	[ebp+20]
		push	[ebp+16]
		push	eax					; result from min
		
		call	min

		add		esp, 12
		mov		esp, ebp			; restore esp
		pop		ebp					; restore previous ebp
		ret		0

;;;;;;;;;;;;;;;;;
public	gcd							; make sure function name is exported

gcd:	push	ebp
		mov		ebp, esp			;
		mov		edi, 0

		cmp		[ebp+12], edi	
		je		gcd0

		xor		edx, edx			;remainder	
		mov		eax, [ebp+8]		
		mov		ecx, [ebp+12]		; fix
		idiv	ecx					;

		push	edx
		push	[ebp+12]	

		call gcd					; recursive
		
		add		esp, 8				; pop off stack
		jmp		gcd1

gcd0:	mov eax, [ebp+8]

gcd1:	mov		esp, ebp			; restore esp
		pop		ebp					; restore previous ebp
		ret		0
	




end