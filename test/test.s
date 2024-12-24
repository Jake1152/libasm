section .data
    hello db "Hello, World!", 0xA, 0xA   ; string and newline char
    hello_len equ $ - hello         ; string length

section .text
global _start

_start:
    ; write(1, wrtie, hello_len)
    MOV rax, 1      ; write syscall number
    MOV rdi, 1      ; file descriptor : STDOUT
    MOV rsi, hello  ; string adddress
    MOV rdx, hello_len ; string length
    syscall         ; execute syscall 

    ; exit(0)
    MOV rax, 60     ; syscall number: exit
    XOR rdi, rdi    ; exit status code
    syscall         ; execute syscall