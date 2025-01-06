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
	extern __errno_location
	
; handle error가 호출되었을 때는, 이미 errno 값이 rax에 저장된 상태
; rax에 있는 값을 errno_location이던져주는 위치에 설정해야함
handle_error:
	; errno값을 다른 곳에 저장
	neg rax							; linux에서 rax값이 음수이므로 errno로 쓸 수 있게 양수로 만듦
	push rax
	call __errno_location wrt ..plt ; "wrt ..plt"는 상대주소로 errno_location 호출하기 위함.
	pop rdx							; rdx 레지스터에 errno값을 저장해둔다
	mov [rax], rdx					; errno_location에서 errno 값을 저장할 수 있는 주소를 rax에 담아둔다.
	mov rax, -1
	ret

; char *strdup(const char *s);
; src에 있는 문자열을 null이 나올 때까지 읽어서 dest에 복사한다.
; 적정 크기를 주어서 동적할당을 한다.
; 
ft_strdup:
	mov rax, 0
	syscall

	; # Mac, jc로 carry flag변화를 감지
	; jc handle_error
	; # Linux, version
	cmp rax, 0
	jl handle_error

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