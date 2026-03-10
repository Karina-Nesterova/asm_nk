.386

stack segment para stack use16
    db 256 dup(?)
stack ends

data segment para use16

hex db "0123456789ABCDEF"
space db ' $'
dv db ': $'
new_line db 0Dh,0Ah,'$'

data ends

code segment para use16
assume cs:code, ds:data, ss:stack

start:

    mov ax,data
    mov ds,ax
	
	mov ax,stack
    mov ss,ax

    mov cx,256        
    xor si,si         
    xor di,di        

next:

    mov ax, si   
    mov al, al   
	
	cmp al,07h
	jb pechat

	cmp al,0Eh
	jb tochka
	

pechat:
    mov dl,al
    mov ah,02h
    int 21h
    jmp hex_zn

tochka:
	
    mov dl,'.'
    mov ah,02h
    int 21h

hex_zn:

	
    ; :
    mov dx,offset dv
    mov ah,09h
    int 21h


    mov ax,si
    mov bl,al

    ; старший 
    mov bh,bl
    shr bh,4
    mov bl,bh
    xor bh,bh
    mov dl,hex[bx]
    mov ah,02h
    int 21h

    ; младший 
    mov ax,si
	mov bl,al
	mov bh, bl
	shl bh, 4
	shr bh, 4
	mov bl,bh
    xor bh,bh
    mov dl,hex[bx]
    mov ah,02h
    int 21h
  
   
    mov dx,offset space
    mov ah,09h
    int 21h

    inc si
    inc di

    cmp di,8
    jne newline

    mov di,0
    mov dx,offset new_line
    mov ah,09h
    int 21h

newline:

    loop next

    mov ax,4C00h
    int 21h

code ends
end start
