      add   r0, #4, r9--
min

min:  add   r26, r0, r1     ; v=c
      sub   r27, r1, r0(C)  ; b<v
      jge   min0
      xor   r0, r0, r0
      add   r27, r0, r1     ; c<v
      
min0: sub   r28, r1, r0(C)  ; c<v0
      jge   min1
      xor   r0, r0, r0
      add   r28, r0, r1
      
min1: ret   r25, 0          ; return r28
      xor   r0, r0, r0      

p

p:    add   r9, r0, r10
      add   r26, r0, r11
      
      call  r25, min
      xor   r0, r0, r0
      add   r27, r0, r12
      add   r1, r10, r10
      add   r28, r0, r11            
      
      call  r25, min
      xor   r0, r0, r0
      add   r24, r0, r12
      ret   r25, 0
      xor   r0, r0, r0
