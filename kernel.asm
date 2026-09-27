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
	mov si, warring
	call print_string
	mov cx, 36
.loop:
	mov ax, 3
	call wait_timer
	call clear_screen
	mov si, warring
	call print_string
	loop .loop
	call clear_screen
%include "program/shell.asm"
%include "timer/timer.asm"
%include "screen/vga_text.asm"
%include "storge/biosdisk.asm"
%include "memory/memory.asm"
warring db "Warring", 0
