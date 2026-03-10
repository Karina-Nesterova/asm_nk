.386

	; 1. Программа должна в бесконечном цикле запрашивать у пользователя проверяемый символ.
	; 2. Выводить каждые 5 запросов исходную строку.
	; 3. Завершать программу, если два раза ввели пустой символ (просто нажали ENTER)
	; 4. Вывод проверок должен быть интерфейсно приятный (напимер: "T - Not found.", где T был введеный символ)

stack segment para stack
db 256 dup (?)
stack ends 

data segment para public
	src_string db "Try find symbol!"
	new_line db 0dh, 0ah, "$"
	src_len dw ?
	success_str db "   Symbol was found!", 0dh, 0ah, "$"
	error_str db "   Symbol wasn't found (((", 0dh, 0ah, "$"
	symbol_again db "Enter a new character", 0Dh, 0Ah, "$"
	schet db 0 ; счетчик запросов
	empty db 0 ; счетчик пустых символов
	reserved db 256 dup (?) 
data ends

code segment para public use16

assume cs:code,ds:data,ss:stack

start:
	; инициализация сегментных регистров
	mov ax, data
    mov ds, ax
    mov ax, stack
    mov ss, ax
	nop
	
again:
	mov dx, offset symbol_again
	mov ah, 09h
	int 21h 
	
	mov ah, 01h
	int 21h
	mov byte ptr [reserved], al
	
	;если ентер то на метку 
	
	mov dx, offset new_line
	mov ah, 09h
	int 21h
	
	mov al, byte ptr [reserved]
	mov cx, offset new_line
	mov bx, offset src_string
	sub cx, bx	; cx = длина строки
	mov word ptr [src_len], cx
	
	dec bx
search:
	inc bx
	cmp al, byte ptr [bx]
	loopne search			
		; cx--; завершение цикла, если cx == 0 или al == byte ptr [bx] (ZF==1)
	
	je found
	xor dx, dx
	mov dl, al
	mov ah, 02h
	int 21h

	
	mov dx, offset error_str
	jmp print
found:
	xor dx, dx
	mov dl, al
	mov ah, 02h
	int 21h

	mov dx, offset success_str
print:
	mov ah, 09h
	int 21h
	
	cmp [reserved], 0Dh
	je plus1
	mov byte ptr[empty],0
	
plus2:	
	inc byte ptr[schet]
	cmp byte ptr[schet],5 
	je zero
	jmp again
zero:
	mov dx, offset src_string
	mov ah, 09h
	int 21h
plus1:
	inc [empty]
	cmp [empty], 2
	je exit
	jmp plus2
jmp again
exit:
	mov ax, 4c00h
	int 21h
	
code ends

end start