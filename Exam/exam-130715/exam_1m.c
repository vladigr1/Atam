#include <stdio.h>

extern unsigned int unsigned_decompose_number32(unsigned long int n);
extern unsigned int signed_decompose_number32(unsigned long int n);

int main()
{
  unsigned int  count;
  unsigned long int uln;
  long int ln;

  printf("\nEnter 32 bit unsigned n:\n");

  scanf("%lu", &uln);

  count = unsigned_decompose_number32(uln);

  rewind(stdin);
  
  printf("count(%lu) = %u\n", uln, count);

  printf("\nEnter 32 bit signed n:\n");

  scanf("%ld", &ln);

  count = signed_decompose_number32(ln);

  printf("count(%ld) = %u\n", ln, count);

	return 0;
} // main
