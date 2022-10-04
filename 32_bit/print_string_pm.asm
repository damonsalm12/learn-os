[bits 32]

VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

; prints a null-terminated string pointed to by EBX
print_string_pm:
    pusha
    mov edx, VIDEO_MEMORY

print_string_pm_loop:
    mov al, [ebx] ; store the char at ebx in al
    mov ah, WHITE_ON_BLACK ; store the attributes in ah

    cmp al, 0 ; if true, string is done
    je print_string_pm_done

    mov [edx], ax ; store character and attributes into character cell

    add ebx, 1 ; increment ebx to next character
    add edx, 2 ; move to the next character cell in vid mem
    jmp print_string_pm_loop ; loop to print next char

print_string_pm_done:
    popa
    ret