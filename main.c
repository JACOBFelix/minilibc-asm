#include <stdio.h>
#include <assert.h>
#include <malloc.h>

# define S1 "abcdefghi"
# define S2 "abcdefgh"
# define SE ""

size_t	strlen(const char *s);
int	strcmp(const char *s1, const char *s2);
int	strcasecmp(const char *s1, const char *s2);
int	strncmp(const char *s1, const char *s2, size_t n);
char	*strcpy(char *dest, const char *src);
char	*strncpy(char *dest, const char *src, size_t n);
void	*memset(void *s, int c, size_t n);
void	*memcpy(void *dest, const void *src, size_t n);
void	*memmove(void *dest, const void *src, size_t n);
char	*index(const char *s, int c);
char	*rindex(const char *s, int c);
char	*strchr(const char *s, int c);
char	*strstr(const char *haystack, const char *needle);
char	*strpbrk(const char *s, const char *accept);
size_t	strcspn(const char *s, const char *reject);
char	*strdup(const char *s);

int	test_strlen()
{
  char	*s1 = S1;
  char	*s2 = S2;
  char	*se = SE;
  /* char	*str = NULL; */
  /* int	i = strlen(str); */

  /* printf("%s size : %i\n", str, i); */
  /* assert(i == 0); */
  printf("%s size : 9 = %lu\n", s1, strlen(s1));
  assert(strlen(s1) == 9);
  printf("%s size : 8 = %lu\n", s2, strlen(s2));
  assert(strlen(s2) == 8);
  printf("%s size : 0 = %lu\n", se, strlen(se));
  assert(strlen(se) == 0);
  return (0);
}

int	test_strcmp()
{
  char	*str1 = S1;
  char	*str2 = S2;
  char	*str3 = S1;

  printf("%s\t > \t%s ? %i\n", str1, str2, strcmp(str1, str2));
  assert(strcmp(str1, str2) > 0);
  printf("%s\t < \t%s ? %i\n", str2, str1, strcmp(str2, str1));
  assert(strcmp(str2, str1) < 0);
  printf("%s\t == \t%s ? %i\n", str1, str1, strcmp(str1, str1));
  assert(strcmp(str1, str1) == 0);
  printf("%s\t == \t%s ? %i\n", str2, str2, strcmp(str2, str2));
  assert(strcmp(str2, str2) == 0);
  printf("%s\t == \t%s ? %i\n", str3, str3, strcmp(str3, str3));
  assert(strcmp(str2, str2) == 0);
  printf("%s\t == \t%s ? %i\n", str1, str3, strcmp(str1, str3));
  assert(strcmp(str2, str2) == 0);
  printf("%s\t == \t%s ? %i\n", str1, str3, strcmp(str3, str1));
  assert(strcmp(str2, str2) == 0);
  return (0);
}

int	test_strcasecmp()
{
  char	*s1 = strdup("aaa");
  char	*s2 = strdup("bbb");
  char	*s3 = strdup("AAA");
  char	*s4 = strdup("BBB");
  char	*s5 = strdup("aAb");
  char	*s6 = strdup("aaB");
  s1[0] = 'a';
  s2[0] = 'b';
  s3[0] = 'A';
  s4[0] = 'B';
  s5[0] = 'a';
  s6[0] = 'a';

  printf("%s == %s = %i\n", s1, s1, strcasecmp(s1, s1));
  assert(strcasecmp(s1, s1) == 0);
  printf("%s != %s = %i\n", s1, s2, strcasecmp(s1, s2));
  assert(strcasecmp(s1, s2) != 0);
  printf("%s == %s = %i\n", s1, s3, strcasecmp(s1, s3));
  assert(strcasecmp(s1, s3) == 0);
  printf("%s == %s = %i\n", s2, s4, strcasecmp(s2, s4));
  assert(strcasecmp(s2, s4) == 0);
  printf("%s < %s  = %i\n", s1, s5, strcasecmp(s1, s5));
  assert(strcasecmp(s1, s5) < 0);
  printf("%s > %s  = %i\n", s5, s1, strcasecmp(s5, s1));
  assert(strcasecmp(s5, s1) > 0);
  printf("%s == %s = %i\n", s5, s6, strcasecmp(s5, s6));
  assert(strcasecmp(s5, s6) == 0);
  printf("%s < %s = %i\n", s1, s6, strcasecmp(s1, s6));
  assert(strcasecmp(s1, s6) < 0);
  return (0);
}

int	test_strncmp()
{
  char	*str1 = S1;
  char	*str2 = S2;
  size_t	len1 = strlen(str1);
  size_t	len2 = strlen(str2);

  printf("%s == %s, %i\n", str1, S1, strncmp(str1, S1, len1));
  assert(strncmp(str1, S1, len1) == 0);
  printf("%s == %s, %i\n", str2, S2, strncmp(str2, S2, len2));
  assert(strncmp(str2, S2, len2) == 0);

  printf("%s\t != \t%s ? %i\n", str1, str2,
	 strncmp(str1, str2, len1));
  assert(strncmp(str1, str2, len1) != 0);

  printf("%s\t\t == \t%s ? %i\n", str2, str1,
	 strncmp(str2, str1, len2));
  printf("strings : %s %s\n", str2, str1);
  printf("sizes : %lu, %lu\n", len2, len1);
  printf("size : %lu\n", len1);
  printf("size : %lu\n", len2);
  printf("\n");
  assert(strncmp(str2, str1, len2) == 0);
  return (0);
}

int	test_strcpy()
{
  char	*str1 = S1;
  char	*str2 = malloc(strlen(S1) + 1);

  strcpy(str2, str1);
  printf("%s\t == \t%s ? %i\n", str1, str2, strcmp(str1, str2));
  assert(strcmp(str1, str2) == 0);
  str2 = S1;
  printf("%s\t == \t%s ? %i\n", str1, str2, strcmp(str1, str2));
  assert(strcmp(str1, str2) == 0);
  return (0);
}

int	test_strncpy()
{
  char	*str = malloc(strlen(S1) + 1);

  strncpy(str, S2, strlen(S2) + 1);
  printf("%s\t == \t%s ? %i\n", str, S2, strcmp(str, S2));
  assert(strcmp(str, S2) == 0);
  memset(str, 0, strlen(S1) + 1);
  strncpy(str, S1, strlen(S1) - 1);
  printf("%s\t == \t%s ? %i\n", str, S2, strcmp(str, S2));
  assert(strcmp(str, S2) == 0);
  return (0);
}

int	test_memset()
{
  char	*str = malloc(51);

  memset(str, 'a', 9);
  str[9] = 0;
  printf("%s == aaaaaaaaa\n", str);
  assert(strcmp("aaaaaaaaa", str) == 0);
  return (0);
}

int	test_memcpy()
{
  char	*str = malloc(51);

  printf("Copy %lu characters (%s)\n", strlen(S1), S1);
  memcpy(str, S1, strlen(S1));
  printf("%s == %s\n", str, S1);
  assert(strcmp(S1, str) == 0);
  memcpy(str + strlen(S1), S1, strlen(S1));
  printf("%s != %s\n", str, S1);
  assert(strcmp(S1, str) != 0);
  printf("%s == %s\n", str + 9, S1);
  assert(strcmp(S1, str + 8) != 0);
  return (0);
}

#define A "aaabb"
#define B "aabbb"
int	test_memmove()
{
  char	*str = malloc(6);

  memcpy(str, A, 6);
  printf("%s %s %i\n", str + 1, str + 2, 2);
  memmove(str + 1, str + 2, 2);
  printf("%s == %s\n", str, B);
  assert(strcmp(str, B) == 0);
  return (0);
}

int	test_index()
{
  char	*str = "bonjouro";
  char	c = 'o';
  char	n = 'X';
  char	m = 'a';

  printf("%s [%c] = %s\n", str, c, index(str, c));
  assert(index(str, c) == str + 1);
  printf("%s [%c] = %s\n", str, n, index(str, n));
  assert(index(str, n) == 0);
  printf("%s [%c] = %s\n", str, m, index(str, m));
  assert(index(str, m) == 0);
  return (0);
}

int	test_rindex()
{
  char	*str = "bonjouro";
  char	c = 'o';
  char	n = 'X';

  printf("%s [%c] = %s\n", str, c, rindex(str, c));
  assert(rindex(str, c) == str + 7);
  printf("%s [%c] = %s\n", str, n, rindex(str, n));
  assert(index(str, n) == 0);
  return (0);
}

int	test_strchr()
{
  char	*str = S1;
  char	c4 = str[4];

  printf("%p\n", str);
  assert(strchr(str, c4) == str + 4);
  return (0);
}

int	test_strstr()
{
  char	*str1 = S1;
  char	*str2 = str1 + 2;

  printf("str1 : %p\n", str1);
  printf("str2 : %p\n", str2);
  printf("%p == %p\n", strstr(str1, str2), str2);
  printf("%p == %p\n", strstr(str1, str2), str1 + 2); // Awsome
  assert(strstr(str1, str2) == str1 + 2);
  str2 += 2;
  assert(strstr(str1, str2) == str1 + 4);
  printf("%p == %p\n", strstr(str1, "zzz"), NULL); // Awsome
  assert(strstr(str1, "zz") == NULL);
  return (0);
}

int	test_strpbrk()
{
  char	*s1 = "bonjour";
  char	*s2 = "jo";
  char	*s3 = "gg";

  printf("%s[%s] = %s ? %s\n", s1, s2, "onjour", strpbrk(s1, s2));
  assert(strpbrk(s1, s2) == s1 + 1);
  printf("fail\n");
  printf("%s[%s] = %s ? %s\n", s1, s3, "NULL", strpbrk(s1, s3));
  assert(strpbrk(s1, s3) == NULL);
  return (0);
}

int	test_strcspn()
{
  char	*s = "abcdefgh";

  printf("%s[!=e] = 4 == %lu\n", s, strcspn(s, "e"));
  assert(strcspn(s, "e") == 4);
  printf("%s[!=efg] = 4 == %lu\n", s, strcspn(s, "feg"));
  assert(strcspn(s, "feg") == 4);
  printf("%s[!=abc] = 0 == %lu\n", s, strcspn(s, "abc"));
  assert(strcspn(s, "abc") == 0);
  printf("%s[!=x] = 8 == %lu\n", s, strcspn(s, "x"));
  assert(strcspn(s, "x") == 8);
  return 0;
}

int	main()
{
  printf("\ntest STRLEN\n");
  test_strlen();

  printf("\ntest STRCMP\n");
  test_strcmp();

  printf("\ntest STRCASECMP\n");
  test_strcasecmp();

  printf("\ntest STRNCMP\n");
  test_strncmp();

  printf("\ntest MEMSET\n");
  test_memset();

  printf("\ntest MEMCPY\n");
  test_memcpy();

  printf("\ntest MEMMOVE\n");
  test_memmove();

  printf("\ntest STRCPY\n");
  test_strcpy();

  printf("\ntest STRNCPY\n");
  test_strncpy();

  printf("\ntest INDEX\n");
  test_index();

  printf("\ntest RINDEX\n");
  test_rindex();

  printf("\ntest STRCHR\n");
  test_strchr();

  printf("\ntest STRSTR\n");
  test_strstr();

  printf("\ntest STRPBRK\n");
  test_strpbrk();

  printf("\ntest STRCSPN\n");
  test_strcspn();

  printf("All tests passed with succes\n");
  return (0);
}
