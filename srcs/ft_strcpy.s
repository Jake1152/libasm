;char *strcpy(char *dest, const char *src);
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
section .text
	global ft_strcpy
	
; 위치 copy char로 옮길지 고려
copy_and_inc:
	mov dl, byte [rsi + rax]
	mov byte [rdi + rax], dl
	inc rax
	jmp loop

loop:
	cmp byte [rsi + rax], 0
	jne copy_and_inc
	je done

;dest[rax], src[]
; char *strcpy(char *dest, const char *src);
; src에 있는 문자열을 null이 나올 때까지 읽어서 dest에 복사한다.
ft_strcpy:
	mov rax, 0
	jmp loop

done:
	mov byte [rdi + rax], 0
	mov rax, rdi
	xor rdx, rdx
	ret 

;char	*ft_strcpy(char *dest, char *src)
;{
;	int i;
;
;	i = 0;
;	while (src[i] != '\0')
;	{
;		dest[i] = src[i];
;		i++;
;	}
;	dest[i] = '\0';
;	return (dest);
;}