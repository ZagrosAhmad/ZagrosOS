; i dont know how is work i found is on my old project

cpu 8086
xor bx,bx
shell:
	mov si, idk_name_of_it
	call print_string

.loop:
	mov ah, 0x00
	int 16h
	cmp al, 0x0D           ; Enter key
	je enter_key
	cmp al, 0x08           ; Backspace key
	je delete_key
	cmp al, 0x20           ; Printable char limits
	jl .loop
	cmp al, 0x7e
	jg .loop
	cmp bx, 31             ; Limit buffer size to prevent overflow
	je .loop

	mov [buffer + bx], al  ; Store character
	mov ah, 0x0e
	int 10h                ; Echo to screen
	inc bx
	jmp .loop

enter_key:
	mov byte [buffer + bx], 0 ; Null-terminate exactly where the cursor is
	mov bx, 0000              ; Reset buffer index for next time
	push si
	mov si, newline
	call print_string
	mov si, clear
	mov di, buffer
	mov cx, 6
	call checking
	cmp al, 0
	je Lclear
	mov si, help
	mov di, buffer
	mov cx, 5                 ; Compare 5 bytes ("help" + null terminator)
	call checking
	cmp al, 0
	je work
	mov si, Basic
	mov di, buffer
	mov cx, 6                 ; Compare 5 bytes ("help" + null terminator)
	call checking
	cmp al, 0
	je LBasic
	jmp shell

delete_key:
	cmp bx, 0000
	je shell.loop
	dec bx
	mov ah, 0x0e
	mov al, 0x08
	int 10h
	mov al, ' '
	int 10h
	mov al, 0x08
	int 10h
	jmp shell.loop
.done:
	ret
checking:
.loop:
	mov al, [si]
	cmp al, [di]
	jne fail
	inc si
	inc di
	loop .loop
	mov al, 0 
	ret 	
fail:
	mov al, 1
	ret

work:
	pop si
	mov si, help
	call print_string
	mov si, newline
	call print_string
	jmp shell
Lclear:
	pop si
	call clear_screen
	jmp shell
LBasic:
	pop si
	push si
	add si, 6
	mov di, guess1
	mov cx, 6
	call checking
	cmp al, 0
	je .yes
.end:
	jmp shell
.yes:
	pop si
	add si, 6
	call print_string
	jmp .end
guess1 db "Print "
;--------------------------
buffer times 33 db 0
Basic db "Basic", 0 
help db "help", 0
clear db "clear", 0
newline db 0x0D, 0x0A, 0
idk_name_of_it db '> ', 0
