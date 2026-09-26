[org 0x1000]
cpu 8086
start:
	cli 
	xor ax, ax
	mov ss, ax
	mov ax, cs
	mov sp, 0x900
	mov ds, ax
	mov es, ax
	sti
	call clear_screen
%include "program/shell.asm"
%include "timer/timer.asm"
%include "screen/vga_text.asm"
%include "storge/biosdisk.asm"
%include "memory/memory.asm"
msg db "!shell in kernel used not in disk!", 0
