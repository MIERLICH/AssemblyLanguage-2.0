%include "io.mac"

section .text
    global caesar
    extern printf

caesar:
    push    ebp
    mov     ebp, esp
    pusha

    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    
    mov edx, 0    
    mov ax, di
    mov cx, 26
    div cx
    mov di, dx
    
    mov edx, [ebp + 8]  ; ciphertext
    mov ecx, [ebp + 20] ; length
    xor eax, eax
run:
    cmp ecx, 0
    jl exit
    
    dec ecx
    mov al, [esi+ecx]
    ;check caracter
    cmp al, 65
    jl scrie
    cmp al, 90
    jg posibil_lit_mica
    
    ;Caracter mare
    add eax, edi
    cmp eax, 91
    jl scrie
    sub eax, 26
    jmp scrie
    
posibil_lit_mica:
    cmp al, 97
    jl scrie
    cmp al, 122
    jg scrie

    ;Caracter mic
    add eax, edi
    cmp eax, 123
    jl scrie
    sub eax, 26
    jmp scrie
scrie:
    mov [edx+ecx], al
    xor eax, eax
    jmp run
exit:
    popa
    leave
    ret