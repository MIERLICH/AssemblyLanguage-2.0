%include "io.mac"

section .text
    global bin_to_hex
    extern printf

valoare:
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

calc:
    push ebp
    mov ebp, esp
    mov eax, [ebp + 8]
    cmp eax, 0
    je exit_calc    
    push eax
    call valoare
    pop eax    
    mov edx, [ebp + 12]
    mov ecx, [ebp + 16]
    mov [edx + ecx], eax    
exit_calc:
    leave
    ret

bin_to_hex:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; hexa_value
    mov     esi, [ebp + 12]     ; bin_sequence
    ;mov     ecx, [ebp + 16]     ; length
  
    xor eax, eax
    push eax
    xor ebx, ebx
    xor ecx, ecx
    xor edi, edi
run:
    mov bl, byte [esi+ecx]
    sub bl, 48
    or eax, ebx
    inc ecx
    inc edi
    
    cmp edi, 4
    jne pas
    push edx
    push eax
    call calc
    ;chem functia de afisare
    xor edi, edi
    xor eax, eax
pas:
    cmp ecx, [ebp + 16]
    je exit
    shl eax, 1
    jmp run
exit:
    shr eax, 28
    push eax
    call valoare
    pop eax
    mov [edx], al
    popa
    leave
    ret