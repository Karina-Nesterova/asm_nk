stack segment para stack 
db 256 dup(?)
stack ends

data segment para public
str db "Hello, asm!",0Dh,0Ah,"$"
data ends

code segment para 

assume cs:code,ds:data,ss:stack

start:
	mov ax,data
	mov ds,ax
	mov ax,stack
	mov ss,ax

	mov si, offset str
	lea bx, [si+2]
	mov byte ptr[bx], "k"
	
	;mov dx, offset str
	mov ah, 09h
	mov dx, offset str
	int 21h
	
	
	mov dl, byte ptr [bx+1]
	mov ah, 02h
	int 21h
	
	
	mov ax,4c00h
	int 21h
	
code ends

end start