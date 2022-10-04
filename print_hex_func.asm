; value in dx
print_hex:
    pusha
    mov ah, 0x0e
    mov [HEX_OUT], '1'
    mov bx, HEX_OUT
    call print_func
    popa
    ret

%include "print_func.asm"

; DATA
HEX_OUT: db '0x0000',0