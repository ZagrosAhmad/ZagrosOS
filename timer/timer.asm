; made be ai rewrite it!!!!!!!!!!!!!!!!!!!!!
CPU 8086
; Input: AX = Number of timer ticks to wait (~18.2 ticks = 1 second)
wait_timer:
	push ax
	push bx
	push cx
	push dx

	cmp ax, 0
	je .done

	mov bx, ax          ; Store requested ticks in BX

	; Get starting clock tick count
	mov ah, 0x00
	int 0x1A            ; Returns tick count in CX:DX
	add dx, bx          ; Target tick count = start ticks + requested delay
	mov bx, dx          ; Save target lower word in BX

.wait_loop:
	mov ah, 0x00
	int 0x1A            ; Read current tick count into CX:DX
	cmp dx, bx          ; Compare current lower word with target
	jb .wait_loop       ; Loop until current >= target

.done:
	pop dx
	pop cx
	pop bx
	pop ax
	ret
