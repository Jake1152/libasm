; add.asm
section .text
global add

add:
    add rdi, rsi  ; 두 입력값 더하기
    mov rax, rdi  ; 결과를 rax에 저장
    ret           ; 반환

