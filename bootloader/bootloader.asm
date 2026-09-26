[org 0x7c00]

start:
    ; Force CS to 0x0000 to normalize segment offsets
    jmp 0x0000:step2

step2:
    cld
    cli
    xor ax, ax
    mov ss, ax
    mov sp, 0x7C00
    mov ds, ax
    mov es, ax
    sti

    mov [boot_drive], dl    ; Save boot drive passed by BIOS in DL

    ; Extended Read (LBA) via BIOS INT 0x13
    mov ah, 0x42
    mov si, dap
    int 0x13
    jc disk_error           ; Jump if carry flag set (read failed)

    mov dl, [boot_drive]    ; Restore boot drive for stage 2 payload
    jmp 0x0000:0x1000       ; Jump to loaded payload

disk_error:
    cli
    hlt                     ; Infinite loop on failure

align 4
dap:
    db 0x10                 ; Packet size (16 bytes)
    db 0x00                 ; Reserved (always 0)
    dw 2                    ; Number of sectors to read
    dw 0x1000               ; Target buffer offset
    dw 0x0000               ; Target buffer segment
    dd 1                    ; Lower 32 bits of LBA sector
    dd 0                    ; Upper 32 bits of LBA sector

boot_drive db 0

times 510-($-$$) db 0
dw 0xAA55
