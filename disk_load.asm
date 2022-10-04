; load DH sectors to ES:BX from drive DL
disk_load:
    push dx ; save dx for later
    mov ah, 0x02 ; BIOS func
    mov al, dh ; read dh sectors
    mov ch, 0x00 ; select cylinder 0
    mov dh, 0x00 ; select head 0
    mov cl, 0x02 ; start reading from second sector

    int 0x13

    jc disk_error

    pop dx
    cmp dh, al ; if AL (sectors read) != DH (sectors expected)
    jne disk_error ; display error message
    ret

disk_error:
    mov bx, DISK_ERROR_MESSAGE
    call print_string
    jmp $

; Data
DISK_ERROR_MESSAGE: db "Disk read error!", 0