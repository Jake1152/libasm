section .text
	global ft_strcmp
	extern __errno_location

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

; int strcmp(const char *s1, const char *s2);
; src에 있는 문자열을 null이 나올 때까지 읽어서 dest에 복사한다.
ft_strcmp:
	mov rax, 0
	syscall

	; # Mac, jc로 carry flag변화를 감지
	; jc handle_error
	; # Linux, version
	cmp rax, 0
	jl handle_error

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