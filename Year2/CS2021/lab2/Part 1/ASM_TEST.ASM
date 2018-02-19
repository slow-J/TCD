NAME ASMTEST

$include(LOOKUPTABLE.INC)

?PR?TSEG?ASM_TEST SEGMENT CODE
PUBLIC  ASM_LOOKUP_ROUTINE

RSEG ?PR?TSEG?ASM_TEST
using   0

ASM_LOOKUP_ROUTINE:

   MOV DPTR, #TABLE    ; DPTR points to the start of the lookup table
   MOV A, #4           ; A is the offset from the start of the lookup table
   MOVC A, @A + DPTR   ; Moves the (A+1)th item into the Accumulator

   RET
   END