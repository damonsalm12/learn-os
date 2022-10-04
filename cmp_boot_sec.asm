[org 0x7c00]

mov bx, 3

cmp bx, 4
jl less_than
jle less_than_equal
jmp else

less_than_equal:
    mov al, 'A'
    jmp end

less_than:
    mov al, 'B'
    jmp end
else:
    mov al, 'C'
    jmp end
end: 
    call print_func
    jmp $
%include "print_func.asm"

times 510 -($ - $$) db 0
dw 0xaa55


