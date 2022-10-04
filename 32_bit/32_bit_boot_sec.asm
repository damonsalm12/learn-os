; A boot sector that enters 32 bit protected mode
[org 0x7c00]
    
    mov bp, 0x9000 ; Set the stack
    mov sp, bp

    mov bx, MSG_REAL_MODE
    call print_string

    mov ax, 0x3
    int 0x10 ; set vga text mode 3

    call switch_to_pm

    jmp $

%include "../print_func.asm"
%include "gdt.asm"
%include "print_string_pm.asm"
%include "switch_to_pm.asm"

[bits 32]
; Arrival point after switching to and initializing protected mode
BEGIN_PM:
    mov ebx, MSG_PROT_MODE
    call print_string_pm

    jmp $

; Global variables
MSG_REAL_MODE db "Started in 16-bit Real Mode", 0
MSG_PROT_MODE db "Successfully landed in 32-bit Protected Mode", 0

; Bootsector patting
times 510-($-$$) db 0
dw 0xaa55
