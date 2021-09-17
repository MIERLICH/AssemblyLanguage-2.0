%include "io.mac"

section .text
    global my_strstr
    extern printf

my_strstr:
    push    ebp
    mov     ebp, esp
    pusha

    mov     edi, [ebp + 8]      ; substr_index
    mov     esi, [ebp + 12]     ; haystack
    mov     ebx, [ebp + 16]     ; needle
    mov     edx, [ebp + 24]     ; needle_len

    xor ecx, ecx
    push ecx ;idx substring
run:
    cmp ecx, [ebp + 20]
    jge exit
        
    mov eax, [esi + ecx]
    push ecx ;pun idx curent in stringul mare
    mov ecx, [esp + 4] ;idx substring
    cmp ecx, edx
    je afara
    cmp eax, [ebx + ecx]
    jne calc
    jmp afara    
calc:
    mov ecx, 0
    mov [esp + 4], ecx
aici:
    pop ecx   
    inc ecx
    jmp run    
exit:
    mov eax, [ebp + 20]
    inc eax
    mov [edi], eax
    pop ecx
    popa
    leave
    ret
afara:
    pop eax
    pop ecx
    sub eax, ecx
    mov [edi], eax
    popa
    leave
    ret