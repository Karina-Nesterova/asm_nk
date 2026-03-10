; 2. Написать программу для проверки каждого символа введенной строки 
; (кроме завершающего) на принадлежность к определенному диапазону в таблице ASCII. 
; Диапазон символов запрашивать у пользователя на старте программы.
; При первом несовпадении выводить сообщение в формате:
; "Some character in the string is not within the specified range." 
; И завершать программу с кодом -1.
; Или, если все совпало:
; "All characters in a string within the specified range." 
; И завершать программу с кодом 0.

stack segment para stack
db 256 dup(?)
stack ends

data segment para public
    str1 db "first character: $"
    str2 db "last character: $"
    in_string db "string: $"
    net db "Some character in the string is not within the specified range.$"
    da db "All characters in a string within the specified range.$"
	error1 db "the first character in the range cannot be greater than the last.$"
    new_str db 0Dh,0Ah, "$" 
    first db ?
    second db ?
    string db 255 dup(?)     
    real_len db ?  
data ends

code segment para public 

assume cs:code, ds:data, ss:stack

start:
    mov ax, data
    mov ds, ax
    mov ax, stack
    mov ss, ax
    
    ;первый 
    mov dx, offset str1
    mov ah, 09h
    int 21h
    
    mov ah, 01h      
    int 21h
    mov [first], al
    
	
    mov dx, offset new_str
    mov ah, 09h
    int 21h
    
    ; второй 
    mov dx, offset str2
    mov ah, 09h
    int 21h
    
    mov ah, 01h      
    int 21h
    mov [second], al
    
  
    mov dx, offset new_str
    mov ah, 09h
    int 21h
    
    
    mov al, [first]
    mov bl, [second]
    cmp al, bl
    jbe metka      
    
	;если первой символ больше второго - ошибка 
	
	mov dx, offset error1
    mov ah, 09h
    int 21h
    
    mov dx, offset new_str
    mov ah, 09h
    int 21h
    
    mov ax, 4c01h ; -1 
    int 21h
    
metka:
    
    mov dx, offset in_string
    mov ah, 09h
    int 21h

    ; ввод строки
    mov dx, offset string
    mov [string], 254    
    mov ah, 0ah
    int 21h

    ; длина
    mov bl,[string+1]
    mov [real_len], bl

    mov dx, offset new_str
    mov ah, 09h
    int 21h


    mov cl, [real_len]      
    xor ch, ch
    xor si, si              
    
check:
    mov al, [string + 2 + si] 

  
    cmp al, [first]
    jb  err       

    cmp al, [second]
    ja  err        
    
    inc si                  
    loop check

    
    mov dx, offset da
    mov ah, 09h
    int 21h

    mov dx, offset new_str
    mov ah, 09h
    int 21h
    
    mov ax, 4c00h ; 0
    int 21h
    
err:
    mov dx, offset net
    mov ah, 09h
    int 21h
    
    mov dx, offset new_str
    mov ah, 09h
    int 21h
    
    mov ax, 4c01h ; -1 
    int 21h

code ends
end start
