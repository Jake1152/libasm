; main.asm
section .text
global _start
extern add

_start:
    mov rdi, 10   ; 첫 번째 값
    mov rsi, 20   ; 두 번째 값
    call add      ; add 함수 호출

    ; 결과 출력 (여기서는 간단히 종료)
    mov rax, 60   ; exit syscall
    xor rdi, rdi  ; 성공적으로 종료
    syscall
