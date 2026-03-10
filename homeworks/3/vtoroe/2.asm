stack_seg segment para stack
db 256 dup(?)
stack_seg ends

data_seg segment para public
	str db 240 ;макс длина 
		db ? ;длина
		db 240 dup(?) ;buf 
	a db "test.txt", 0	
	opisatel dw ? ;описатель
	real_len db ? ;длина введеной строки
	read_buf db 240 dup(?);
	real_len2 dw ? ;длина прочитанной из файла строки

data_seg ends

code_seg segment para

assume cs:code_seg,ds:data_seg,ss:stack_seg


start:
  mov ax, data_seg
  mov ds, ax
  mov ax, stack_seg
  mov ss, ax 
  
  
  mov ah, 0ah
  mov dx, offset str
  int 21h
  
  
  ;создать описаьель
  mov ah, 3ch
  mov dx, offset a
  mov cx, 0
  int 21h
  
  ;сохранить описатель 
  mov word ptr[opisatel], ax
 
  
  ;адрес буффера
  lea dx,[str+2]
  
  ;реальная длина строки
  xor bx, bx
  mov bl, byte ptr [str+1]    
  mov [real_len], bl
  mov cx, bx 

  
  ;писать в файл 
  mov ah, 40h
  mov bx, word ptr[opisatel]
  int 21h
  
  ;закрыть файл 
  mov ah, 3eh
  mov bx, [opisatel]
  int 21h
  
  
  ;открыть файл
  mov ah, 3dh
  mov dx, offset a
  mov al, 0
  int 21h
  
  ;сохранить описатель 
  mov word ptr[opisatel], ax
  
  ;читать из файла
  mov ah, 3fh
  mov bx, word ptr[opisatel]
  mov dx, offset read_buf
  int 21h
  
  mov word ptr[real_len2], ax
  
  ;закрыть файл
  mov ah, 3eh
  mov bx, word ptr[opisatel]
  int 21h
  
  ;$
  lea si, byte ptr[read_buf]
  mov bx, word ptr[real_len2]      
  mov byte ptr [si+bx], '$'
  
  mov ah, 02h
  mov dl, 0Ah		
  int 21h
    
  mov ah, 02h
  mov dl, 0Dh		
  int 21h
  
  ;вывод
  mov ah, 09h
  mov dx, offset read_buf
  int 21h
  
  
  mov ax, 4c00h
  int 21h
code_seg ends
end start
