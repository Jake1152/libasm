#include <stdio.h>
#include <string.h>
#include <assert.h>
#include <unistd.h>
#include <errno.h>

size_t	ft_strlen(const char *str);
ssize_t ft_read(int fd, void *buf, size_t count);
// TO KNOW: __errno_location
// size_t	ft_strlen(const char *str);

void test_strlen()
{
	char *uninitialized_pointer;
    const char *valid_string = "Hello, World!";
    const char *empty_string = "";
    const char *null_pointer = NULL;
    
    // Uninitialized pointer (undefined behavior warning)

    // Valid string
    printf("Testing with a valid string:\n");
	printf("address: %p\n", valid_string);
    printf("Length of std: %zu\n", strlen(valid_string));
	printf("Length of ft : %zu\n", ft_strlen(valid_string));
	printf("assert(strlen(%s) == ft_strlen(%s))\n", valid_string, valid_string);

    // Empty string
    printf("\nTesting with an empty string:\n");
	printf("address: %p\n", empty_string);
    printf("Length of std: %zu\n", strlen(empty_string));
	printf("Length of ft : %zu\n", ft_strlen(empty_string));
	printf("assert(strlen(%s) == ft_strlen(%s))\n", empty_string, empty_string);

    // Uninitialized pointer (unsafe, demo purposes only)
    // Uncommenting the following line is risky and may cause the program to crash.
    printf("\nTesting with a uninitialized_pointer pointer:\n");
    printf("address: %p\n", uninitialized_pointer);
    printf("Length of std: %zu\n", strlen(uninitialized_pointer));
	printf("Length of ft : %zu\n", ft_strlen(uninitialized_pointer));
	printf("assert(strlen(%s)\n", uninitialized_pointer);
	printf("assert(ft_strlen(%s)\n", uninitialized_pointer);
	// printf("assert(strlen(%s) == ft_strlen(%s))\n", uninitialized_pointer, uninitialized_pointer);

    // NULL pointer (causes undefined behavior, so wrapped with a condition)
    printf("\nTesting with a NULL pointer:\n");
	printf("address: %p\n", null_pointer);
	printf("Length of ft : %zu\n", ft_strlen(null_pointer));
    // printf("Length of std: %zu\n", strlen(null_pointer));
	// printf("assert(strlen(%s) == ft_strlen(%s))\n", null_pointer, null_pointer);
}

// ssize_t read(int fd, void *buf, size_t count);
void test_read()
{
	int 	fd;
	// char	buf[] = "sdfjdsklfjlfdgjdsflkdjgf";
	void	*buf;
	//  char	buf[100];
	size_t	count;
    // Uninitialized pointer (undefined behavior warning)
	ssize_t read_result;

	fd = 1;
	count = 100;
	read_result = read(fd, buf, count);
	printf("read_result : %ld,\t%s\n", read_result, (char *)buf);

	read_result = ft_read(fd, buf, count);
	printf("read_result : %ld,\t%s\n", read_result, (char *)buf);
    // Valid string
    // printf("Testing with a valid string:\n");
	// printf("address: %p\n", valid_string);
    // printf("Length of std: %zu\n", strlen(valid_string));
	// printf("Length of ft : %zu\n", ft_strlen(valid_string));
	// printf("assert(strlen(%s) == ft_strlen(%s))\n", valid_string, valid_string);
}

int main()
{
	/** Mandatory
	 */

	// _start("Test my assmbly");
	// start();

	printf("=============== ft_read() ===============\n");
	test_read();

	// printf("=============== ft_strlen() ===============\n");
	// test_strlen();
	/**
	assert(strlen(test_str) == ft_strlen(test_str));
	test_str = "";
	printf("assert(strlen(%s) == ft_strlen(%s))\n", test_str, test_str);
	assert(strlen(test_str) == ft_strlen(test_str));
	// test_str = NULL;
	// printf("assert(strlen(%s) == ft_strlen(%s))\n", test_str, test_str);
	// assert(strlen(test_str) == ft_strlen(test_str));
	test_str = "Hello, World\n\n";
	printf("assert(strlen(%s) == ft_strlen(%s))\n", test_str, test_str);
	assert(strlen(test_str) == ft_strlen(test_str));

	test_str = "Hello, Wo\0rld\0";
	printf("assert(strlen(%s) == ft_strlen(%s))\n", test_str, test_str);
	assert(strlen(test_str) == ft_strlen(test_str));
	printf("\n\n");
	*/

	// printf();
	// printf("=============== 1. ft_strlen() ===============\n");
	// // ft_strlen("42\0");

	// printf("\n\n");
	
	// printf("=============== 2. ft_strlen() ===============\n");


	// printf("\n\n");
	
	// printf("=============== 3. ft_strlen() ===============\n");

	
	// printf("\n\n");
	
	// printf("=============== 4. ft_strlen() ===============\n");


	// printf("\n\n");
	
	// printf("=============== 5. ft_strlen() ===============\n");
	// printf("\n\n");
	
	// printf("=============== 6. ft_strlen() ===============\n");

	/** Bonus
	*/
	return 0;
}
