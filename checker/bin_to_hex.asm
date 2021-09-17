%include "io.mac"

section .text
    global bin_to_hex
    extern printf

bin_to_hex:
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]      ; hexa_value
    mov     esi, [ebp + 12]     ; bin_sequence
    mov     ecx, [ebp + 16]     ; length

    popa
    leave
    ret