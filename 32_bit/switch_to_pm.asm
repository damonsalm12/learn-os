[bits 16]
; Switch to protected mode
switch_to_pm:
    cli ; switch off interrupts
    
    lgdt [gdt_descriptor]; Load global descriptor table

    mov eax, cr0 ; Set first bit of cr0 to switch to protected mode
    or eax, 0x1
    mov cr0, eax

    jmp CODE_SEG:init_pm ; make far jump to 32 bit code and flush pipelined instructions

[bits 32]
; Initialize registers and the stack once in PM
init_pm:

    mov ax, DATA_SEG ; point segment registers to data selector in GDT
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000 ; update stack to the top of the free space
    mov esp, ebp

    call BEGIN_PM