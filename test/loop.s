section .data
	msg db "A"

section .text
	global _start

_start:
	mov rax, 1
	mov rdi, 1
	mov rsi, msg
	mov rdx, 1

	syscall

	mov rax, 60
	
	syscall
	
