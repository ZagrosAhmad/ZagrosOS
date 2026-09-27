cpu 8086
read_sector:
	push ax
	push si
	mov [count], ax
	mov [adder], di
	mov [adders], si
	mov [s_start], bx
	mov ah, 0x42
	mov si, dap
	int 0x13
	pop ax
	pop si
	ret
write_sector:
	push ax
	push si
	mov [count], ax
	mov [adder], di
	mov [adders], si
	mov [s_start], bx
	mov ah, 0x43
	mov si, dap
	int 0x13
	pop ax
	pop si
	ret
ALIGN 4
dap:
	db 0x10
	db 0x00
count:	dw 0
adder:	dw 0
adders:	dw 0x0000
s_start:dd 0
		dd 0
