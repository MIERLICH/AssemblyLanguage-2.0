%include "io.inc"

section .text
global CMAIN

valoare:
   PRINT_STRING "SUUKA"
   push ebp
   mov ebp, esp
   mov eax, [ebp + 8]
   cmp eax, 10
   jl mai_mic
   add eax, 55
   jmp afara
mai_mic:
   add eax, 48
afara:
   mov [ebp + 8], eax
   leave
   ret

CMAIN:
    ;write your code here
    
    mov eax, 
    push eax
    call valoare
    pop eax
    PRINT_STRING "----->"
    PRINT_CHAR al
    ret