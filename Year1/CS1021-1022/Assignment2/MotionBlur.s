	AREA	MotionBlur, CODE, READONLY
	IMPORT	main
	IMPORT	getPicAddr
	IMPORT	putPic
	IMPORT	getPicWidth
	IMPORT	getPicHeight
	EXPORT	start
	PRESERVE8

start

	BL	getPicAddr		; load the start address of the image in R4
	MOV	R4, R0
	BL	getPicHeight		; load the height of the image (rows) in R5
	MOV	R5, R0
	BL	getPicWidth		; load the width of the image (columns) in R6
	MOV	R6, R0
	
	LDR R1, =5			;radius
	LDR R2, =0			;iterations
	LDR R3, =0			;Blue
	LDR R7, =0 			;Green
	LDR R8, =0			;Red
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
	MOV R3, R1			;R3=R1

	;GREEN
	LDR R1, [R4]
	AND R1, R1, #0x0000FF00		;green buffer
	
	MOV R7, R1			;R7=R1
	

	;RED
	LDR R1, [R4]
	AND R1, R1, #0x000000FF		;red buffer
	
	MOV R8, R1			;R8=R1
			

	ADD R7, R3, R7			;green+blue
	ADD R7, R7, R8			;+red
	STR R4, [sp, #-4]!
	CMP R12, #0
	BEQ endW
	STR R7, [R4]			;store back to array
endW	
	ADD R4, R4, #4			;array[i+4]
	ADD sp, sp, #4
	ADD R12, R12, #1		;column++
	B column
endColumn				;}

	ADD R11, R11, #1		;row++
	MOV R12, #0			;column=0
	B row
endRow					;}

	BL	putPic			; re-display the updated image

stop	B	stop


	END	
