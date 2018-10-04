option casemap:none             ; case sensitive
 
.code

;
; fib64.asm
;
; Copyright (C) 2012 - 2017 jones@scss.tcd.ie
;

;
; example mixing C/C++ and x64 assembly language
;
; _int64 fib(_int64 n) {
;
;   _int64 fi, fj, t;
;
;   if (n <= 1)
;       return n;
;
;   fi = 0; 
;   fj = 1;
;   while (n > 1) {
;       t = fj;
;       fj = fi + fj;
;       fi = t;
;       n--;
;   }
;   return fj;
; }
;
; parameter n   rcx
;

public  fibX64                      ; export function name

fibX64:     mov     rax, rcx        ; rax = n
            cmp     rax, 1          ; if (n <= 1)
            jle     fibX64_1        ; return n
            xor     rdx, rdx        ; fi = 0
            mov     rax, 1          ; fj = 1
fibX64_0:
            cmp     rcx, 1          ; while (n > 1)
            jle     fibX64_1        ;
            mov     r10, rax        ; t = fj
            add     rax, rdx        ; fi = fi + fj
            mov     rdx, r10        ; fi = t
            dec     rcx             ; n--
            jmp     fibX64_0        ;
fibX64_1:   ret                     ; return rax

            end
    