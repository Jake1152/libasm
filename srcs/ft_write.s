section .text
	global ft_write
	extern __errno_location

;ssize_t ft_write(int fd, void *buf, size_t count);
; Mac, Linux
;	rsi, rdi, rdx, rcx, r8, r9

; # 고려사항 
; 0. 정상 리턴 케이스
; 1. errno_location1
; 2. calling convention saved by
; ref: https://die4taoam.tistory.com/37
; ## calling_convention saved register
; ### caller
; rax, rcx, rdx, rsi, rdi, r8, r9, r10, r11

; ### callee
; rbx, rbp, r12, r13, r14, r15

; handle error가 호출되었을 때는, 이미 errno 값이 rax에 저장된 상태
; rax에 있는 값을 errno_location이던져주는 위치에 설정해야함
handle_error:
	; errno값을 다른 곳에 저장
	neg rax							; linux에서 rax값이 음수이므로 errno로 쓸 수 있게 양수로 만듦
	push rax
	call __errno_location wrt ..plt ; "wrt ..plt"는 상대주소로 errno_location 호출하기 위함.
	pop rcx							; rcx 레지스터에 errno값을 저장해둔다
	mov [rax], rcx					; errno_location에서 errno 값을 저장할 수 있는 주소를 rax에 담아둔다.
	mov rax, -1

; read syscall에서 쓰는 파라미터 rdi, rsi, rdx
ft_write:
	mov rax, 1						; write sys call
	syscall

	; # Mac, jc로 carry flag변화를 감지
	; jc handle_error
	; # Linux, version
	cmp rax, 0
	jl handle_error

	ret