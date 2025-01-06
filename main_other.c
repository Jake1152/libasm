#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <errno.h>

#define ANSI_WHITE "\033[37m"
#define ANSI_GREEN "\033[32m"
#define ANSI_RED "\033[31m"

size_t  ft_strlen(const char *str);
char	*ft_strcpy(char *dst, const char *src);
int		ft_strcmp(const char *s1, const char *s2);
ssize_t ft_write(int fildes, const void *buf, size_t nbyte);
ssize_t ft_read(int fildes, void *buf, size_t nbyte);
// char	*ft_strdup(const char *s1);

void check_ft_strlen(const char *str, const char *description) {
	printf(ANSI_RED "<<< test : %s >>>" ANSI_WHITE "\n", description);
	size_t res1 = ft_strlen(str);
	size_t res2 = strlen(str);

	assert(res1 == res2);
	printf("ft_strlen	=> return: %ld\n", res1);
	printf("strlen		=> return: %ld\n", res2);

	return;
}


void check_ft_strcpy(const char *src, const char *description) {
	printf(ANSI_RED "<<< test : %s >>>" ANSI_WHITE "\n", description);

	char *dst = malloc(sizeof(char) * (ft_strlen(src) + 1));
	char *res1 = ft_strcpy(dst, src);
	char *res2 = strcpy(dst, src);

	assert(res1 == res2);
	printf("ft_strcpy	=> address: %p, return: %s\n", res1, res1);
	printf("strcpy		=> address: %p, return: %s\n", res2, res2);

	free(dst);

	return ;
}

void check_ft_strcmp(const char *s1, const char *s2, const char *description) {
	printf(ANSI_RED "<<< test : %s >>>" ANSI_WHITE "\n", description);
	
	int res1 = ft_strcmp(s1, s2);
	int res2 = strcmp(s1, s2);

	assert(res1 == res2);
	printf("s1: %s, s2: %s\n", s1, s2);
	printf("ft_strcmp	=> return: %d\n", res1);
	printf("strcmp		=> return: %d\n", res2);

	return ;
}

/**
void check_ft_strdup(const char *s1, const char *description) {
	printf(ANSI_RED "<<< test : %s >>>" ANSI_WHITE "\n", description);
	errno = 0;

	char *res1 = ft_strdup(s1);
	char *res2 = strdup(s1);

	assert(ft_strcmp(res1, res2) == 0);
	assert(res1 != s1);
	printf("ft_strdup	=> return: %s\n", res1);
	printf("strdup		=> return: %s\n", res2);

	free(res1);
	free(res2);

	return ;
}
*/

void check_ft_write(int fildes, const void *buf, size_t nbyte, const char *description) {
	printf(ANSI_RED "<<< test : %s >>>" ANSI_WHITE "\n", description);
	errno = 0;

	// bss나 data에 errno를 설정하는 것이 아니라, 외부에 있는 errno를 가져와야 함
	// errno의 주소를 알 수 있는 방법이 없기 때문에 errno_location 등의 매크로 함수로 주소를 반환
	ssize_t res2 = write(fildes, buf, nbyte);
	int errno2 = errno;

	ssize_t res1 = ft_write(fildes, buf, nbyte);
	int errno1 = errno;
	errno = 0;

	printf("ft_write	=> return: %ld, errno: %d\n", res1, errno);
	printf("write		=> return: %ld, errno: %d\n", res2, errno);
	assert(res1 == res2);
	assert(errno1 == errno2);
	
	return ;
}

void check_ft_read(int fildes1, int fildes2, void *buf1, void *buf2, size_t nbyte, const char *description) {
	printf(ANSI_RED "<<< test : %s >>>" ANSI_WHITE "\n", description);
	
	errno = 0;
	ssize_t res2 = read(fildes2, buf2, nbyte - 1);
	int errno2 = errno;

	errno = 0;
	ssize_t res1 = ft_read(fildes1, buf1, nbyte - 1);
	int errno1 = errno;

	if (res1 > 0) {
		printf("%s\n", (char *)buf1);
		printf("%s\n", (char *)buf2);
	}
	printf("ft_read		=> return: %ld, errno: %d\n", res1, errno1);
	printf("read		=> return: %ld, errno: %d\n", res2, errno2);

	free(buf1);
	free(buf2);
	
	assert(res1 == res2);
	assert(errno1 == errno2);

	return ;
}


int main() {

	// ft_strlen
	{
		printf(ANSI_GREEN "---------------------------------------------------" ANSI_WHITE "\n");
		printf(ANSI_GREEN "-------------------- ft_strlen --------------------" ANSI_WHITE "\n");
		printf(ANSI_GREEN "---------------------------------------------------" ANSI_WHITE "\n");

		const char *str1 = "123";
		const char *str2 = "";
		const char *str3 = "\t\b\n";
		const char *str4 = "a";
		const char *str5 = "Hello, World!";
		const char *str6 = "Hello\nWorld";
		const char *str7 = "spaces              ";
		const char *str8 = "          Leading and trailing spaces           ";
		const char *str9 = "\0";

		check_ft_strlen(str1, "기본");
		check_ft_strlen(str2, "빈 문자열");
		check_ft_strlen(str3, "읽을 수 없는 문자열");
		check_ft_strlen(str4, "단일 문자");
		check_ft_strlen(str5, "특수 문자");
		check_ft_strlen(str6, "중간의 개행");
		check_ft_strlen(str7, "끝에 공백");
		check_ft_strlen(str8, "양쪽에 공백");
		check_ft_strlen(str9, "널 문자");
		//check_ft_strlen(NULL, "널 포인터");
	}

	// ft_strcpy
	{
		printf("\n");
		printf(ANSI_GREEN "---------------------------------------------------" ANSI_WHITE "\n");
		printf(ANSI_GREEN "-------------------- ft_strcpy --------------------" ANSI_WHITE "\n");
		printf(ANSI_GREEN "---------------------------------------------------" ANSI_WHITE "\n");

		const char *str1 = "Hello, World!";
		const char *str2 = "";
		const char *str3 = "C programming";
		const char *str4 = "123456789!@#$%^&*()";
		const char *str5 = "Very long string that exceeds the usual length limit for testing purposes.";

		check_ft_strcpy(str1, "기본");
		check_ft_strcpy(str2, "빈 문자열");
		check_ft_strcpy(str3, "기본");
		check_ft_strcpy(str4, "특수문자");
		check_ft_strcpy(str5, "긴 문자열");
		// check_ft_strcpy(NULL, "널 포인터");
	}

	// ft_strcmp
	{
		printf("\n");
		printf(ANSI_GREEN "---------------------------------------------------" ANSI_WHITE "\n");
		printf(ANSI_GREEN "-------------------- ft_strcmp --------------------" ANSI_WHITE "\n");
		printf(ANSI_GREEN "---------------------------------------------------" ANSI_WHITE "\n");

		check_ft_strcmp("apple", "apple", "기본");
		check_ft_strcmp("banana", "apple", "첫 글자가 s1이 더 큰 경우");
		check_ft_strcmp("apple", "banana", "첫 글자가 s2가 더 큰 경우");
		check_ft_strcmp("apple", "apricot", "중간 글자가 s2가 더 큰 경우");
		check_ft_strcmp("apple", "applepie", "중간 글자가 s2가 더 큰 경우");
		check_ft_strcmp("applepie", "apple", "중간 글자가 s1이 더 큰 경우");
		check_ft_strcmp("", "", "빈 문자열");
		check_ft_strcmp("", "banana", "s1이 빈 문자열");
		check_ft_strcmp("banana", "", "s2가 빈 문자열");
		check_ft_strcmp("Apple", "apple", "대문자 비교");
		check_ft_strcmp("apple", "Apple", "대문자 비교");
		check_ft_strcmp("apple", "Apple", "대문자 비교");
		//check_ft_strcmp(NULL, "Apple", "널 포인터");
	}
	/**

	 */

	// ft_read
	{
		printf("\n");
		printf(ANSI_GREEN "-------------------------------------------------" ANSI_WHITE "\n");
		printf(ANSI_GREEN "-------------------- ft_read --------------------" ANSI_WHITE "\n");
		printf(ANSI_GREEN "-------------------------------------------------" ANSI_WHITE "\n");

		int fd1 = open("test_ft_read.txt", O_RDONLY);
		int fd2 = open("test_ft_read.txt", O_RDONLY);
		int pipe1[2];
		int pipe2[2];

		pipe(pipe1);
		pipe(pipe2);
		fcntl(pipe1[0], F_SETFL, O_NONBLOCK);
		fcntl(pipe2[0], F_SETFL, O_NONBLOCK);

		check_ft_read(
			fd1, fd2,
			malloc(sizeof(char) * 100), malloc(sizeof(char) * 100),
			100, "파일 크기 < 버퍼 크기"
		);
		check_ft_read(
			fd1, fd2,
			malloc(sizeof(char) * 100), malloc(sizeof(char) * 100),
			100, "파일 끝에서 읽기"
		);
		check_ft_read(
			open("test_ft_read.txt", O_RDONLY), open("test_ft_read.txt", O_RDONLY),
			malloc(sizeof(char) * 10), malloc(sizeof(char) * 10),
			10, "파일 크기 > 버퍼 크기"
		);
		check_ft_read(
			open("test_ft_read2.txt", O_RDONLY), open("test_ft_read2.txt", O_RDONLY),
			malloc(sizeof(char) * 10), malloc(sizeof(char) * 10),
			10, "빈 파일 읽기"
		);
		check_ft_read(
			open("test_ft_read2.txt", O_WRONLY), open("test_ft_read2.txt", O_WRONLY),
			malloc(sizeof(char) * 10), malloc(sizeof(char) * 10),
			10, "쓰기 전용 파일에서 읽기"
		);
		check_ft_read(
			-1, -1,
			malloc(sizeof(char) * 10), malloc(sizeof(char) * 10),
			10, "잘못된 fd에서 읽기"
		);
		check_ft_read(
			pipe1[0], pipe2[0],
			malloc(sizeof(char) * 10), malloc(sizeof(char) * 10),
			10, "논블로킹 fd에서 읽기"
		);
		check_ft_read(
			open("test_ft_read.txt", O_RDONLY), open("test_ft_read.txt", O_RDONLY),
			NULL, NULL,
			10, "널 포인터"
		);
		// check_ft_read(
		// 	0, 0,
		// 	malloc(sizeof(char) * 10), malloc(sizeof(char) * 10),
		// 	10, "표준 입력에서 읽기"
		// );
	}

	// ft_write
	{
		printf("\n");
		printf(ANSI_GREEN "--------------------------------------------------" ANSI_WHITE "\n");
		printf(ANSI_GREEN "-------------------- ft_write --------------------" ANSI_WHITE "\n");
		printf(ANSI_GREEN "--------------------------------------------------" ANSI_WHITE "\n");

		const char *str1 = "Hello, World!\n";
		const char *str2 = "";
		const char *str3 = "\0";
		const char *str4 = "\t\b\n";
		const char *str5 = "Writing to a file\n";
		const char *str6 = NULL;

		int fd = open("test_ft_write.txt", O_WRONLY | O_CREAT | O_TRUNC, 0644);
		int fd2 = open("test_ft_write2.txt", O_RDONLY);
		
		check_ft_write(1, str1, ft_strlen(str1), "기본");
		check_ft_write(1, str2, ft_strlen(str2), "빈 문자열");
		check_ft_write(1, str3, ft_strlen(str3), "널 문자");
		check_ft_write(1, str4, ft_strlen(str4), "읽을 수 없는 문자");
		check_ft_write(fd, str5, ft_strlen(str5), "파일에 쓰기");
		check_ft_write(1, str1, 0, "0개만큼 쓰기");
		check_ft_write(1, str6, 10, "널 포인터");
		check_ft_write(-1, str5, ft_strlen(str5), "잘못된 fd에 쓰기");
		check_ft_write(fd2, str5, ft_strlen(str5), "읽기 전용 파일에 쓰기");
		check_ft_write(2, str1, ft_strlen(str1), "표준 에러에 쓰기");
	}


	// ft_strdup
	// {
	// 	printf("\n");
	// 	printf(ANSI_GREEN "---------------------------------------------------" ANSI_WHITE "\n");
	// 	printf(ANSI_GREEN "-------------------- ft_strdup --------------------" ANSI_WHITE "\n");
	// 	printf(ANSI_GREEN "---------------------------------------------------" ANSI_WHITE "\n");

	// 	check_ft_strdup("Hello, World!", "기본");
	// 	check_ft_strdup("", "빈 문자열");
	// 	check_ft_strdup("A", "단일 문자");
	// 	check_ft_strdup("This is a very long string to test how the strdup function handles long inputs.", "긴 문자열");
	// 	// check_ft_strdup(NULL, "널 포인터");
	// }

	// system("leaks test");

	return 0;
}
