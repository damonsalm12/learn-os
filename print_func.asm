; address of string in bx
print_string:
    pusha
    mov ah, 0x0e
    print_next:
        mov cx, [bx]
        mov al, cl
        cmp al, 0
        je end
        int 0x10
        mov al, ch
        cmp al, 0
        je end
        int 0x10
        add bl, 2
        jmp print_next
    end:
        popa
        ret

; value in dx
print_hex:
    pusha
    mov ah, 0x0e
    mov cx, 0x0009

    mov bx, dx
    shr bx, 12

    cmp bx, cx
    jg add_alpha_0
    add bx, '0'
    jmp save_alpha_0
    add_alpha_0:
        add bx, 'W'
    save_alpha_0:
    mov BYTE [HEX_OUT+2], bl

    mov bx, dx
    and bx, 0x0f00
    shr bx, 8
    cmp bx, cx
    jg add_alpha_1
    add bx, '0'
    jmp save_alpha_1
    add_alpha_1:
        add bx, 'W'
    save_alpha_1:
    mov BYTE [HEX_OUT+3], bl

    mov bx, dx
    and bx, 0x00f0
    shr bx, 4
    cmp bx, cx
    jg add_alpha_2
    add bx, '0'
    jmp save_alpha_2
    add_alpha_2:
        add bx, 'W'
    save_alpha_2:
    mov BYTE [HEX_OUT+4], bl


    mov bx, dx
    and bx, 0x000f
    cmp bx, cx
    jg add_alpha_3
    add bx, '0'
    jmp save_alpha_3
    add_alpha_3:
        add bx, 'W'
    save_alpha_3:
    mov BYTE [HEX_OUT+5], bl
    mov bx, HEX_OUT
    call print_string
    popa
    ret





; DATA
HEX_OUT: db '0x0000',0