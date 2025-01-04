global .text
	global _start

_start:
	mov rax, 0
	mov rbx, 0
	mov rcx, 0
	mov rdx, 0

	;read
	sub rsp, 64 ; 64 byte
	mov rdi, 0
	mov rsi, rsp
	mov rdx, 63

	syscall
	; TODO: exception
	; jc
	jl 
		mov rax, -1
		ret

	;write
	mov rax, 1
	mov rdi, 1
	mov rsi, rsp
	mov rdx, 63

	syscall

	; exit(255)
	; exit
	mov rax, 60
	syscall
