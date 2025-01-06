section .text
	global ft_strcmp
	extern __errno_location

;int strcmp(const char *s1, const char *s2);
; Mac, Linux
;	rdi, rsi, rdx, rcx, r8, r9

; # 고려사항 
; 0. 정상 리턴 케이스
; 1. errno_location
; 2. calling convention saved by
; ref: https://die4taoam.tistory.com/37
; ## calling_convention saved register
; ### caller
; rax, rcx, rdx, rdi, rsi, r8, r9, r10, r11

; ### callee
; rbx, rbp, r12, r13, r14, r15

done:
	dec rax
	xor rdx, rdx
	mov rdx, qword [rdi + rax]
	sub rdx, qword [rsi + rax]
	mov rax, rdx
	ret

is_end:
	inc rax
	cmp dl, 0
	je done
	jne loop

loop:
	mov dl, byte [rsi + rax]
	cmp byte [rdi + rax], dl
	je is_end
	jne done


; int	strcmp(char *s1, char *s2);
; src에 있는 문자열을 null이 나올 때까지 읽어서 dest에 복사한다.
ft_strcmp:
	xor rdx, rdx
	mov rax, 0
	jmp loop

	ret
;int		ft_strcmp(char *s1, char *s2)
;{
;	unsigned char c1;
;	unsigned char c2;
;
;	while (1)
;	{
;		c1 = (unsigned char)*s1++;
;		c2 = (unsigned char)*s2++;
;		if (c1 != c2)
;		{
;			if (c1 < c2)
;				return (-1);
;			else
;				return (1);
;		}
;		if (!c1)
;			break ;
;	}
;	return (0);
;}