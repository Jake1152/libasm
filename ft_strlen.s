section .text
    extern ft_strlen

; 문자열을 받는다 -> rdi에서 가리킴
; index를 0으로 초기화 한다.
; 현재 문자열이 \0인지 확인한다.
; 문자열을 읽는다. 
;
ft_strlen:
    test rdi, rdi       ; NULL check ; TODO: test 용법 추가 조사
    jz handle_null      ; error 처리 
    xor rcx, rcx        ; index로 사용할 rcx 0으로 초기화

loop:
    cmp byte [rdi + rcx], 0     ; 0과 비교하여 true이면 je로 이동, false이면 jne로 이동
    je end             ; done
    inc rcx
    jmp loop
    
end:
    mov rax, rcx        ; string size to return
    ret

handle_null:
    mov rax, 0
    ret

; TODO: 예외처리  
; exit code는 rdi에 담긴다.
; 시스템 호출과 일반 함수 호출이 다르게 동작하기에 그러함