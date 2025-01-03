section .text
	global ft_strlen

ft_strlen:
	xor rax, rax
	jmp loop

loop:
	cmp byte [rdi + rax], 0
	je done
	inc rax
	jmp loop

done:
	ret
