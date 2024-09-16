section .data
    hello db 'Hello', ' 42 ', ', World!',0XA   ;  db => define byte asm에서 
                                    ; 바이트 단위로 저장하는 명령어 
                                    ; 0XA => \n
    hello_len equ $ - hello         ; 메시지 길이 계산
    

section .text
    global _start

_start:
    ; stdout으로 메시지 write하기
    mov rax, 1          ; syscall: write
    mov rdi, 1          ; file descriptor: stdout
    mov rsi, hello      ; pointer to message
    mov rdx, hello_len  ; message length
    syscall             ; make the syscall


    ; Exit the program
    mov rax, 60         ; syscall: exit
    xor rdi, rdi        ; status: 0
    syscall             ; make the syscall
