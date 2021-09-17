%include "io.mac"

section .text
global otp

otp:
    push    ebp
    mov     ebp, esp
    pusha
    mov     edx, [ebp + 8]      ; ciphertext
    mov     esi, [ebp + 12]     ; plaintext
    mov     edi, [ebp + 16]     ; key
    mov     ecx, [ebp + 20]     ; length

run:
    cmp ecx, 0
    jl exit    
    dec ecx
    mov al, byte [esi + ecx]
    mov bl, byte [edi + ecx]
    ;xor intre text si cheie
    xor al, bl;
    ;scriu rezultatul in output
    mov [edx+ecx], al
    jmp run
exit:
    popa
    leave
    ret