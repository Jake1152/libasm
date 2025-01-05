section .text
	global ft_read
	extern __errno_location

;ssize_t ft_read(int fd, void *buf, size_t count);
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

; calling convention register 저장
save_register_of_caller:
	mov rbx, rax

restore_register_of_caller:
	mov rax, rbx

; save_register_of_callee:

; restore_register_of_callee:
	

handle_error:
	; errno값을 다른 곳에 저장
	mov rbx, rax
	@ call save_register_of_caller


	call __errno_location wrt ..plt ; 상대주소로 errno_location 호출하기 위함.
	mov rax, -1

	call restore_register_of_caller:

; read syscall에서 쓰는 파라미터 rdi, rsi, rdx
ft_read:
	mov rax, 0

	
	syscall


	; # Mac, jc로 carry flag변화를 감지
	; jc handle_error
	; # Linux, version
	cmp rax, 0

	jl handle_error

	ret
	
