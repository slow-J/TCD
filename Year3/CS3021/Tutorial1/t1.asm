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

		pop		ebx					; int i
		pop		esi					; int j
		pop		edi					; int k
		
		push	esi
		push	ebx
		push	g					; global variable; may be wrong

	
		call	min

		add		esp, 4
		pop		ebx
		pop		esi
		pop		ebp					; int l
	
		push	ebp					; maybe can skip this fix this later
		push	edi
		push	eax					; result from min
		
		
		call	min

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

		pop		ebx					; int a
		pop		esi					; int b

		xor		edx, edx			;remainder	
		mov		eax, ebx		
		mov		ecx, esi			; fix
		idiv	ecx					;

		push	edx
		push	esi	

		mov		esp, ebp			; restore esp
		pop		ebp					; restore previous ebp
		call gcd					;recursive
		
gcd0:	mov eax, [ebp+8]

		mov		esp, ebp			; restore esp
		pop		ebp					; restore previous ebp
		ret		0
	




end