	AREA	Adjust, CODE, READONLY
	IMPORT	main
	IMPORT	getPicAddr
	IMPORT	putPic
	IMPORT	getPicWidth
	IMPORT	getPicHeight
	EXPORT	start

start

	BL	getPicAddr	; load the start address of the image in R4
	MOV	R4, R0
	BL	getPicHeight	; load the height of the image (rows) in R5
	MOV	R5, R0
	BL	getPicWidth	; load the width of the image (columns) in R6
	MOV	R6, R0
	
; your code goes here
	LDR R1, =0			;div
	LDR R2, =0			;div
	LDR R3, =0			;Blue
	LDR R7, =0 			;Green
	LDR R8, =0			;Red
	LDR R9, =16			;contrast
	LDR R10, =0			;brightness
	LDR R11, =0			;count row
	LDR R12, =0			;count col
	
row
	CMP R11, R5			;if(row!=colHeight)
	BEQ endRow			;{
	
column
	CMP R12, R6			;if(col!=rowWidth)
	BEQ endColumn			;{
	;BLUE
	LDR R1, [R4] 			;R1=array[i]
	AND R1, R1, #0x00FF0000		;blue buffer
	LSR R1, #16				

	MUL R1, R9, R1			;change contrast
	MOV R2, #0			;quotient=0
	BL div
finDiv
	MOV R3, R2			;R3=R1/16
	ADD R3, R3, R10			;add brightness

	MOV R1, #0xFF000000
	CMP R3, R1			;if (R3<0)
	BLO notUnder			;{
	MOV R3, #0			;R3=0
notUnder				;}

	CMP R3, #255			;if (R3>255)
	BLS notOver			;{
	MOV R3, #255			;R3=255
notOver					;}
	LSL R3, #16			;logical shift left

	;GREEN
	LDR R1, [R4]
	AND R1, R1, #0x0000FF00		;green buffer
	LSR R1, #8			;shift to right
	
	MUL R1, R9, R1			;change contrast	
	MOV R2, #0			;quotient = 0
	BL div2
finDiv2
	MOV R7, R2			;R7=R1/16
	ADD R7, R7, R10			;add brightness
	
	MOV R1, #0xFF000000		
	CMP R7, R1			;if (R7<0)
	BLO notUnder2			;{
	MOV R7, #0			;R7=0
notUnder2				;}

	CMP R7, #255			;if (R7>255)
	BLS notOver2			;{
	MOV R7, #255			;R7=255
notOver2				;}

	LSL R7, #8			;logical shift left


	;RED
	LDR R1, [R4]
	AND R1, R1, #0x000000FF		;red buffer
	
	MUL R1, R9, R1			;change contrast
	MOV R2, #0			;quotient = 0
	BL div3
finDiv3
	MOV R8, R2			;R8=R1/16
	ADD R8, R8, R10			;add brightness
		
	MOV R1, #0xFF000000
	CMP R8, R1			;if (R7<0)
	BLO notUnder3			;{
	MOV R8, #0			;R7=0
notUnder3				;}

	CMP R8, #255			;if (R7>255)
	BLS notOver3			;{
	MOV R8, #255			; R7=255
notOver3				;}

	ADD R7, R3, R7			;green+blue
	ADD R7, R7, R8			;+red
	STR R7, [R4]			;store back to array
	ADD R4, R4, #4			;array[i+4]
	
	
	ADD R12, R12, #1		;column++
	B column
endColumn				;}

	ADD R11, R11, #1		;row++
	MOV R12, #0			;column=0
	B row
endRow					;}

	BL	putPic			; re-display the updated image

stop	B	stop

	
div					; while 
	CMP R1, #16			;(remainder >= b )
	BLO finDiv			; {
	ADD R2, R2, #1			;quotient = quotient + 1 ;
	SUB R1, R1, #16			;remainder = remainder - b ;
	B div				; }

div2					; while 
	CMP R1, #16			;(remainder >= b )
	BLO finDiv2			; {
	ADD R2, R2, #1			;quotient = quotient + 1 ;
	SUB R1, R1, #16			;remainder = remainder - b ;
	B div2				; }
	
div3					; while 
	CMP R1, #16			;(remainder >= b )
	BLO finDiv3			; {
	ADD R2, R2, #1			;	quotient = quotient + 1 ;
	SUB R1, R1, #16			;	remainder = remainder - b ;
	B div3				; }

	
	END	
