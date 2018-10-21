#include <stdio.h>

extern  double convert(char str[]);

int main()
{
  double result;
 char str[] = "1234567890123";

 result = convert(str);

  printf("convert(\"%s\") = %lf\n", str, result);
} // main
