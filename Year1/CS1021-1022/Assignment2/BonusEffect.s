	AREA	BonusEffect, CODE, READONLY
	IMPORT	main
	IMPORT	getPicAddr
	IMPORT	putPic
	IMPORT	getPicWidth
	IMPORT	getPicHeight
	EXPORT	start

start

	BL	getPicAddr		; load the start address of the image in R4
	MOV	R4, R0
	BL	getPicHeight		; load the height of the image (rows) in R5
	MOV	R5, R0
	BL	getPicWidth		; load the width of the image (columns) in R6
	MOV	R6, R0

; your code goes here
	LDR R1, =0			;div
	LDR R2, =0			;div
	LDR R3, =0			;Blue
	LDR R7, =0 			;Green
	LDR R8, =0			;Red

	LDR R11, =0			;count row
	LDR R12, =0			;count col
	
row
	CMP R11, R5			;if(row!=colHeight)
	BEQ endR			;{
	
column
	CMP R12, R6			;if(col!=rowWidth)
	BEQ endC			;{
	;BLUE
	LDR R1, [R4]
	AND R1, R1, #0x00FF0000		;blue buffer
	LSR R1, #16				
	MOV R3, #255				
	SUB R3, R3, R1			;invert colours
	MOV R1, #0xFF000000
	CMP R3, R1
	BLO notUnder			;if (R3<0)
	MOV R3, #0			;R3=0
notUnder

	CMP R3, #255			;if (R3>255)
	BLS notOver			;R3=255
	MOV R3, #255
notOver	
	LSL R3, #16			;logical shift left

	;GREEN
	LDR R1, [R4]
	AND R1, R1, #0x0000FF00		;green buffer
	LSR R1, #8				

	MOV R7, #255				
	SUB R7, R7, R1			;invert colours
	MOV R1, #0xFF000000		
	CMP R7, R1
	BLO notUnder2			;if (R7<0)
	MOV R7, #0			;R7=0
notUnder2

	CMP R7, #255			;if (R7>255)
	BLS notOver2			;R7=255
	MOV R7, #255
notOver2	

	LSL R7, #8			;logical shift left


	;RED
	LDR R1, [R4]
	AND R1, R1, #0x000000FF		;red buffer
	MOV R8, #255				
	SUB R8, R8, R1		;invert colours
		
	MOV R1, #0xFF000000
	CMP R8, R1
	BLO notUnder3			;if (R7<0)
	MOV R8, #0			;R7=0
notUnder3

	CMP R8, #255			;if (R7>255)
	BLS notOver3			;{
	MOV R8, #255			; R7=255
notOver3				;}

	ADD R7, R3, R7
	ADD R7, R7, R8
	STR R7, [R4]			;store back to array
	ADD R4, R4, #4			;array[i+4]
	
	
	ADD R12, R12, #1		;column++
	B column
endC

	ADD R11, R11, #1		;row++
	MOV R12, #0
	B row
endR	

	BL	putPic			; re-display the updated image

stop	B	stop


	
	END	
