.386
stack_seg segment para stack use16
    db 256 dup(?)
stack_seg ends

data_seg segment para public use16
    ten db 0      ; десятки
    one db 0     ; единицы
data_seg ends

code_seg segment para use16
    assume cs:code_seg, ds:data_seg, ss:stack_seg

start:
    mov ax, data_seg
    mov ds, ax

	mov dl, 0Dh
	mov ah, 02h
	int 21h
  
	mov dl, 0Ah
	mov ah, 02h
	int 21h

;левое	
    mov [ten], 0

left1:
    cmp [ten], 9
    jg done1    
    mov [one], 0

left2:

    cmp [ten], 0
    jne print1
    ;печатаем цифру
    mov dl, [one]
    add dl, '0'
    mov ah, 02h
    int 21h
    mov dl, ' '
	mov ah, 02h
    int 21h
    jmp space1
print1:
    ;печатаем число
    mov dl, [ten]
    add dl, '0'
    int 21h
    mov dl, [one]
    add dl, '0'
    int 21h
space1:
    cmp [one], 9
    je skip_space1
    mov dl, ' '
	mov ah, 02h
    int 21h
skip_space1:
    inc [one]
    cmp [one], 10
    jnge left2

    ; Конец строки
    mov dl, 0Dh
	mov ah, 02h
	int 21h
  
	mov dl, 0Ah
	mov ah, 02h
	int 21h

    inc [ten]
    jmp left1

done1:
  
  mov dl, 0Dh
  mov ah, 02h
  int 21h
  
  mov dl, 0Ah
  mov ah, 02h
  int 21h
  
  
  
  

  
;правое
    mov [ten], 0
  

right1:
    cmp [ten], 9
    jg done2

    mov [one], 0

right2:

    cmp [ten], 0
    jne print2
    ;печатаем цифру
    mov dl, ' '
	mov ah, 02h
    int 21h
    mov dl, [one]
    add dl, '0'
	mov ah, 02h
    int 21h
    jmp space2
print2:
    ; печатаем число
    mov dl, [ten]
    add dl, '0'
	mov ah, 02h
    int 21h
    mov dl, [one]
    add dl, '0'
	mov ah, 02h
    int 21h
space2:
    cmp [one], 9
    je skip_space2
    mov dl, ' '
	mov ah, 02h
    int 21h
skip_space2:
    inc [one]
    cmp [one], 10
    jnge right2

	mov dl, 0Dh
	mov ah, 02h
	int 21h
  
	mov dl, 0Ah
	mov ah, 02h
	int 21h

    inc [ten]
    jmp right1

done2:
    mov ax, 4C00h
    int 21h

code_seg ends
end start
