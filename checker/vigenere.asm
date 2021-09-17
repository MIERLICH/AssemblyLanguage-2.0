%include "io.mac"

section .data
     ;msg  db  'Hello, world!',0xa
     cheie TIMES 512 db 0 

section .text
    global vigenere
    extern printf

vigenere:
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     ecx, [ebp + 16]     ; plaintext_len
    mov     edi, [ebp + 20]     ; key
    mov     ebx, [ebp + 24]     ; key_len

    mov ecx, 0
    mov ebx, 0
    ;Step 1. La pasul 1 replic cheia la lungimea necesara
key:
    cmp ecx, [ebp + 16]
    je stop
    
    mov al, [esi + ecx]
    cmp al, 65
    jl stand_ebx
    cmp al, 122
    jg stand_ebx
    ;A-z
    cmp al, 97
    jge work
    ;A-96
    cmp al, 91
    jge stand_ebx
work:
    mov al, [edi + ebx]
    mov [edx + ecx], al
    jmp inc_ebx
    
stand_ebx:   
    mov al, [esi + ecx]
    mov [edx + ecx], al
    inc ecx
    jmp key
inc_ebx:
    inc ecx
    inc ebx
    cmp ebx, [ebp + 24]
    jne key
    mov ebx, 0
    jmp key
stop:

    ;Step2. La pasul 2 fac xor si scriu rezultatul
    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     ecx, [ebp + 16]     ; plaintext_len
    mov     edi, [ebp + 20]     ; key
    mov     ebx, [ebp + 24]     ; key_len
    xor ecx, ecx
run:
    cmp ecx, [ebp+16]
    je exit
    
    mov al, byte [esi + ecx]
    cmp al, 65
    jl scrie
    cmp al, 91
    jge posibil_lit_mica
    ;Caracter mare
    xor ebx, ebx
    mov bl, byte [edx + ecx]
    sub bl, 65
    add al, bl
    cmp al, 91
    jl scrie
    sub al, 26
    jmp scrie
    
posibil_lit_mica:
    mov al, byte [esi + ecx]
    cmp al, 97
    jl scrie
    cmp ax, 122
    jg scrie
    ;Caracter mic
    xor ebx, ebx
    mov bl, byte [edx + ecx]
    sub bl, 65
    add al, bl
    cmp ax, 123
    jl scrie
    sub al, 26
    jmp scrie 
scrie: 
    mov [edx + ecx], al;
    inc ecx
    jmp run
exit:
    popa
    leave
    ret