;char *strdup(const char *s);
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
	global ft_strdup
	extern ft_strlen
	extern ft_strcpy
	extern malloc

; char *strdup(const char *s);
; src에 있는 문자열을 null이 나올 때까지 읽어서 dest에 복사한다.
; 적정 크기를 주어서 동적할당을 한다.
; ft_strlen을 통해서 길이를 잰다.
ft_strdup:
	; calling convention 지켜야함
	call ft_strlen
	; rax에 길이가 담김
	; void *malloc(size_t size);
	mov rdx, rdi	; 원복을 위해 rdi주소를  복사해둠
	mov rdi, rax
	call malloc wrt ..plt
	; rax에 동적할당된 heap 주소가 담김
	; dest(rdi), src(rsi)
	mov rdi, rax
	mov rsi, rdx
	call ft_strcpy
	ret
	
;char	*ft_strdup(const char *s1)
;{
;	char	*dest;
;	size_t	idx;
;	size_t	s1_size;
;
;	s1_size = ft_strlen(s1);
;	dest = (char *)malloc(sizeof(char) * (s1_size + 1));
;	if (dest == 0)
;		return (0);
;	//ft_strcpy(dest, src)으로 대체
;	idx = 0;
;	while (s1[idx])
;	{
;		dest[idx] = s1[idx];
;		idx++;
;	}
;	dest[idx] = 0;
;	return (dest);
;}