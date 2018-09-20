.686                                ; create 32 bit code
.model flat, C                      ; 32 bit memory model
 option casemap:none                ; case sensitive

data ; start of a data section
public g ; export variable g
g DWORD 4 ; declare global variable g initialised to 4
.code ; start of a code section

public	min							; make sure function name is exported

min:	push	ebp
		mov		ebp, esp			;
		sub		esp, 4				; allocate space
		move	eax, [ebp+8]		; eax = a
		move	[esp-4], eax		; v = a
		mov		eax, [ebp+12]		; eax = b
		cmp		eax, [ebp-4]		; if(b < v)
		jge		min0
		mov		[ebp-4], eax		; v = b

min0:	mov		eax, [epb+16]		; eax = c
		cmp		eax, [ebp-4]		; if(c < v)
		jge		min1
		mov		[ebp-4], eax		; v = c

min1:	mov		esp, ebp			; restore esp
		pop		ebp					; restore previous ebp
		ret							; return from function
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

		pop
		pop		ebx
		pop		esi
		pop		ebp					; int l
	
		push	ebp					; maybe can skip this fix this later
		push	edi
		push	eax					; result from min
		
		call	min

		mov		esp, ebp			; restore esp
		pop		ebp					; restore previous ebp
		ret

;;;;;;;;;;;;;;;;;
public	gcd							; make sure function name is exported

gcd:	push	ebp
		mov		ebp, esp			;
		cmp		[ebp+12], 0	
		je		gcd0
		
recursion:
		mov eax, [ebp+8]    ; eax <-- 32-bit "a"
		xor edx, edx        ; edx <-- upper 0 bits
		idiv drgssddfgafd [ebp+12]; fix this;;;;;;;;;;;;;;;;;;;;;;;;
		

		call gcd           ; tail-recursive call
		j fin

gcd0:	mov eax, [ebp+8]

fin:	mov		esp, ebp			; restore esp
		pop		ebp					; restore previous ebp
		ret
	




end