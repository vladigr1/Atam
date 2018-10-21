#include <stdio.h>

extern void string_add(char result_str[],char str1[], char str2[], int n);

int main()
{
  char str1[31], str2[31], result_str[31] = {0};
  int n = 30;

  strcpy(str1,"123456789012345678903456789012");
  strcpy(str2,"009865421087654321108765432101");
  string_add(result_str, str1, str2, n);
  printf("\n\n  %s \n + \n  %s \n  ---------------------------------------------"
  "\n  %s \n\n", str1, str2, result_str);
	return 0;
} // main

