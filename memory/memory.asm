cpu 8086
;---------------------------------------------------
; input is cx, di, si 
; anything is saved
;---------------------------------------------------
memory_cmp:
	push di
	push si
	push cx
	push ax
	inc cx
.ok:
	dec cx
	cmp cx, 0
	je .done
	rep cmpsb
	je .ok
	cmp al, [si]
	pop ax
	pop cx
	pop si
	pop di
	ret
.done:
	cmp al,al
	pop ax
	pop cx
	pop si
	pop di
	ret
;---------------------------------------------------
; input is cx, di, si  
; anything is saved
;---------------------------------------------------	
move_memory_inside_seg:
	push di
	push si
	push cx
	push ax
.loop:
	lodsb
	mov [di], al
	inc di
	loop .loop

	pop ax
	pop cx
	pop si
	pop di
	ret
