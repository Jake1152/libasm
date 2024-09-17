#include <stdio.h>
#include <string.h>
#include <assert.h>

size_t	ft_strlen(const char *str);
// size_t	ft_strlen(const char *str) {
// 	return strlen(str);
// }

int main()
{
	/** Mandatory
	 */
	char *test_str = NULL; 

	printf("=============== ft_strlen() ===============\n");
	test_str = "Hello";
	printf("assert(strlen(%s) == ft_strlen(%s))\n", test_str, test_str);
	printf("ft_strlen(test_str) : %ld\n",  ft_strlen(test_str));
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
