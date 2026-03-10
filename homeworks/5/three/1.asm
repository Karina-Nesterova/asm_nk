.386

; 1. Ќаписать программу считывани€ строки с клавиатуры и 
; а) вывода этой строки в обратном пор€дке, 
; б) вывода этой строки n раз подр€д в цикле.
; ¬се циклы реализовать с помощью инструкций переходов.

	
stack segment para stack
db 256 dup (?)
stack ends 

data segment para public
	s db 240 ;макс длина
	real_len db ?
	buf db 240 dup(?)
	new_line db 0Dh,0Ah, "$"     ; перевод строки
	n db 4
	count db ? 
data ends

code segment para public use16

assume cs:code,ds:data,ss:stack

start:
	
	mov ax, data
    mov ds, ax
    mov ax, stack
    mov ss, ax
	
	mov ah, 0ah
	mov dx, offset s  
    int 21h
	
	;получаем реальную длину 
	xor cx,cx
	mov cl, [real_len]
	inc cx
	mov bx, offset buf
	
	mov dx, offset new_line
    mov ah, 09h
    int 21h
	
	mov si, cx

;а) вывод этой строки в обратном пор€дке	
rev: 
	dec si
	mov dl, [buf + si] ; 
    mov ah, 02h
    int 21h                 
    
    dec cl                  
    cmp cl, 0
    jne rev     
    
    mov dx, offset new_line
    mov ah, 09h
    int 21h
	
	
; $
	mov cx,0
	mov cl, byte ptr[real_len]
	
    mov bx, cx                 
    mov byte ptr [buf + bx], '$'  
	
    mov al, [n]             
    mov [count], al
    
line1:
    cmp byte ptr [count], 0 
    je exit                 


    mov dx, offset buf
    mov ah, 09h
    int 21h                 
    
    mov dx, offset new_line
    mov ah, 09h
    int 21h
    
    dec byte ptr [count]    
    jmp line1  	
	

exit:
	mov ax, 4c00h
	int 21h
	
code ends

end start