[org 0x7c00]

mov [BOOT_DRIVE], dl ; BIOS stores boot drive in DL

mov bp, 0x8000
mov sp, bp ; Set stack out of the way

mov bx, 0x9000
mov dh, 5
mov dl, [BOOT_DRIVE]
call disk_load

mov dx, [0x9000] ; print out first loaded word
call print_hex

mov dx, [0x9000 + 512] ; print first word from second sector
call print_hex 

jmp $

%include "print_func.asm"
%include "disk_load.asm"

; GLOBAL VARS
BOOT_DRIVE: db 0

; Bootsector padding
times 510-($-$$) db 0
dw 0xaa55

; two sectors to load
times 256 dw 0xdada
times 256 dw 0xface
times 256 dw 0x1111
times 256 dw 0x2222
times 256 dw 0x3333