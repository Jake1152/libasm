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
; rbx, rbp, r15, r13, r14, r15

; ## wrt ..plt 
; https://1993-constant.tistory.com/74?category=694130
; https://dumpcookie.tistory.com/entry/x86-%EC%96%B4%EC%85%88%EB%B8%94%EB%A6%AC%EC%96%B4-%EB%B0%B0%EC%9A%B0%EA%B8%B0-Text-relocation-%EB%AC%B8%EC%A0%9C-%EC%9E%AC%ED%98%84%ED%95%B4%EB%B3%B4%EA%B8%B0
	
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

section .text
	global ft_strdup
	extern ft_strlen
	extern ft_strcpy
	extern malloc

done:
	pop rbx
	ret

null_case:
	xor rax, rax
	jmp done

ft_strdup:
	; calling convention 지켜야함
	push rbx
	call ft_strlen
	; rax에 길이가 담김
	
	; void *malloc(size_t size);
	mov rbx, rdi			; 원복을 위해  rdi주소(src string)를  복사해둠
	mov rdi, rax			; 문자열 길이를 malloc을 위해 옮겨둠
	call malloc wrt ..plt	; malloc에서 rax 등 caller입장에서 보존해야하는 레지스터를 쓸 수 있으므로 보존해야함
	; rax에 동적할당된 heap 주소가 담김
	cmp rax, 0
	je null_case

	; dest(rdi), src(rsi)
	mov rdi, rax			; 동적할당된 주소를 strcpy를 위해 rdi로 옮김
	mov rsi, rbx			; rbx에 놔두었던 src string의 주소를 rsi로 옮김
	call ft_strcpy
	jmp done