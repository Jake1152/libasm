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
; calling_convention saved

; calling convention register 저장
; save_register_of_caller:

;
; restore_register_of_caller:
	

handle_error:
	call __errno_location wrt ..plt
	mov rax, -1
;- rsi
;- rdi
;- rdx
ft_read:
	mov rax, 0
	syscall

	; # Mac jc로 carry flag변화를 감지
	; jc handle_error
	; linux version
	cmp rax, 0
	jl handle_error

	ret
	
