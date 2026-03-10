data_seg segment para public
  array_str db 723 dup(?)
  
  one db 240 ;макс длина 
  db ? ;длина
  db 240 dup(?) ;буфер
  
  two db 240
  db ?
  db 240 dup(?)
  
  three db 240
  db ?
  db 240 dup(?)
  
  ;new_line db 0Dh, 0Ah
  
data_seg ends

stack_seg segment para stack
db 256 dup(?)
stack_seg ends

code_seg segment para

assume cs:code_seg,ss:stack_seg,ds:data_seg

start:
  mov ax, data_seg
  mov ds, ax
  mov ax, stack_seg
  mov ss, ax
  
  mov dx, offset one
  mov ah, 0ah
  int 21h
  
  mov ah, 02h
  mov dx, 0Dh
  int 21h
  
  mov ah, 02h
  mov dx, 0Ah
  int 21h
  
  
  mov cl, byte ptr[one+1]
  lea si, byte ptr[one+2]
  xor ch,ch
  add si, cx
  mov byte ptr[si], '$'
  
  
  
  mov dx, offset two
  mov ah, 0ah
  int 21h
  
  mov ah, 02h
  mov dx, 0Dh
  int 21h
  
  mov ah, 02h
  mov dx, 0Ah
  int 21h
  
  
  mov cl, byte ptr[two+1]
  lea si, byte ptr[two+2]
  xor ch,ch
  add si, cx
  mov byte ptr[si], '$'
  
  
  
  
  mov dx, offset three
  mov ah, 0ah
  int 21h
  
  mov ah, 02h
  mov dx, 0Dh
  int 21h
  
  mov ah, 02h
  mov dx, 0Ah
  int 21h
  
  
  mov cl, byte ptr[three+1]
  lea si, byte ptr[three+2]
  xor ch,ch
  add si, cx
  mov byte ptr[si], '$'
  
  
  mov ah, 09h
  mov dx, offset[one+2]
  int 21h
  
  mov ah, 02h
  mov dx, 0Dh
  int 21h
  mov ah, 02h
  mov dx, 0Ah
  int 21h
  
  
  mov ah, 09h
  mov dx, offset[two+2]
  int 21h
  
  mov ah, 02h
  mov dx, 0Dh
  int 21h
  mov ah, 02h
  mov dx, 0Ah
  int 21h
  
  mov ah, 09h
  mov dx, offset[three+2]
  int 21h
  
  mov ah, 02h
  mov dx, 0Dh
  int 21h
  mov ah, 02h
  mov dx, 0Ah
  int 21h
  
  mov ax, 4c00h
  int 21h

code_seg ends
end start
