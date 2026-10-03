cpu 8086
find_file_in_table:
	call load_table
	mov si,di
.loop:
	cmp byte [si], 0x00
	je .end
	inc si
	push si
	mov di, filename
	mov cx, 7
	repe cmpsb
	je .found
	pop si
	jmp  .loop
.found:
	cmp al,al
	pop si
	add si, 11
	mov al, [si]
	inc 
	ret
load_table:
	mov ax, 1
	mov di, 0x600
	xor si,si
	mov bx, 17
	call read_sector 
	ret
filename db "Kernel", 0
