; PROGRMA QUE EVALUA LA INTEGRAL 4x +(3/2)x² -x³
; CON LOS LIMITES: LS = 2, LI = 0 
SYS_SALIDA equ 1
SYS_LEE equ 3
SYS_PRINT equ 4
STDIN equ 0
STDOUT equ 1

segment .data 
	mensaje db  0xA,0xD,"El resultado es: "
	lengthMensaje equ $- mensaje
	salto db  0xA,0xD
	lengthSalto equ $- salto
    lim_inf equ 0
    lim_sup equ 2

segment .bss
	res resb 1
    aux1 resb 1    
    aux2 resb 1

section  .text
	global _start
_start:
    mov eax, SYS_PRINT 
	mov ebx, STDOUT
	mov ecx, mensaje
	mov edx, lengthMensaje
	int 0x80
; INICIO LIMITE SUPERIOR
	;4(0)
    mov eax, 4
    mov ebx, lim_sup
    mul ebx
    mov [aux1], eax; aux1 = 8
    ; (3/2)(2)²
    mov eax, lim_sup
    mov ecx, lim_sup
    mul ecx
    mov ecx, 3
    mul ecx; eax = 12
    mov ecx, 2
    div ecx
    mov ecx, eax; ecx = 6
    ; -(2)³
    mov eax, lim_sup
    mov ebx, lim_sup
    mul ebx
    mul ebx
    mov ebx, eax ; ebx = 8
    ; 8 + 6 - 8
    mov eax, [aux1] 
    add eax, ecx
    sub eax, ebx
    mov [aux1], eax;
; FIN LIMITE SUPERIOR
; INICIO LIMITE INFERIOR
	;4(0)
    mov eax, 4
    mov ebx, lim_inf
    mul ebx
    mov [aux2], eax; aux2 = 0
    ; (3/2)(0)²
    mov eax, lim_inf
    mov ecx, lim_inf
    mul ecx
    mov ecx, 3
    mul ecx; eax = 12
    mov ecx, 2
    div ecx
    mov ecx, eax; ecx = 0
    ; -(0)³
    mov eax, lim_inf
    mov ebx, lim_inf
    mul ebx
    mul ebx
    mov ebx, eax ; ebx = 0
    ; 0 + 0 - 0
    mov eax, [aux2] 
    add eax, ecx
    sub eax, ebx
; FIN LIMITE INFERIOR
    mov ebx, [aux1]
    sub ebx, eax
; IMPRESION EN PANTALLA
    add ebx, 48
	mov [res], ebx
	mov eax, SYS_PRINT 
	mov ebx, STDOUT
	mov ecx, res 
	mov edx, 1
	int 0x80
; IMPRESION EN PANTALLA
	mov eax, SYS_PRINT 
	mov ebx, STDOUT
	mov ecx, salto 
	mov edx, lengthSalto
	int 0x80
salir:
	mov eax, SYS_SALIDA  
	xor ebx, ebx 
	int 0x80