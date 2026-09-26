cpu 8086
;---------------------------------------------------
; input is only si  
; anything is saved
;---------------------------------------------------
ALIGN 4 
clear_screen:
	push ax
	push bx
	push cx
	push dx
	mov ah, 0x06
	mov al, 0x00
	mov bh, 0x02
	xor cx,cx
	mov dx, 0x184f
	int 10h
	mov ah, 2h
	mov bh, 00h
	xor dx,dx
	int 10h
	pop dx
	pop cx
	pop bx
	pop ax
	ret
ALIGN 4 
print_string:
	push ax
	push si
	push bx
	mov ah, 0x0e
	mov bl, 0 			;for now
.loop:
	lodsb
	cmp al, 0
	je .end
	int 0x10
	jmp .loop
.end:
	pop bx
	pop si
	pop ax
	ret
