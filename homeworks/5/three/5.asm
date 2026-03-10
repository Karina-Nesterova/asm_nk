.386
stack segment para stack use16
db 256 dup(?)
stack ends

data segment para public use16
  chislo dw 0DDD1h
data ends

code segment para use16

assume cs:code,ss:stack,ds:data

start:
  mov ax, data
  mov ds, ax
  mov ax, stack
  mov ss, ax
  
  mov bx, [chislo]
  mov cx, 04h
  
print:
  rol bx, 4
  mov al, bl
  and al, 1111b
  
  cmp al, 0Ah
  jl  number
  add al, 55    ;'A' - 0Ah
  jmp char
number:
  add al, 48 	;'0'
char:
  mov dl, al
  mov ah, 02h
  int 21h
  loop print
  
  mov ax, 4c00h
  int 21h
  
code ends
end start
