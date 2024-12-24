section .data
    num1 db 5  ; 첫 번째 숫자
    num2 db 3  ; 두 번째 숫자
    result db 0 ; 결과를 저장할 변수
    message db 'Result: ', 0
    newline db 10, 0  ; 줄바꿈 문자

section .bss
    ; 여기에는 선언할 변수가 없습니다.

section .text
    global _start  ; 엔트리 포인트를 정의합니다.

_start:
    ; 두 숫자를 더합니다.
    mov al, [num1]  ; 첫 번째 숫자를 AL 레지스터로 로드
    add al, [num2]  ; 두 번째 숫자를 AL 레지스터에 더함
    mov [result], al  ; 결과를 result 변수에 저장

    ; 결과 출력
    mov eax, 4  ; sys_write 시스템 호출
    mov ebx, 1  ; 표준 출력 (stdout)
    mov ecx, message  ; 출력할 메시지의 주소
    mov edx, 8  ; 메시지 길이
    int 0x80    ; 시스템 호출 인터럽트

    ; 결과 값 출력
    mov eax, 4  ; sys_write 시스템 호출
    mov ebx, 1  ; 표준 출력 (stdout)
    mov ecx, result  ; 출력할 결과의 주소
    mov edx, 1  ; 결과 길이
    int 0x80    ; 시스템 호출 인터럽트

    ; 줄바꿈 출력
    mov eax, 4  ; sys_write 시스템 호출
    mov ebx, 1  ; 표준 출력 (stdout)
    mov ecx, newline  ; 출력할 줄바꿈 문자
    mov edx, 1  ; 문자 길이
    int 0x80    ; 시스템 호출 인터럽트

    ; 프로그램 종료
    mov eax, 1  ; sys_exit 시스템 호출
    xor ebx, ebx  ; 종료 코드 0
    int 0x80    ; 시스템 호출 인터럽트

