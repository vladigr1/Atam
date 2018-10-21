#include <stdio.h>

extern void compare(long int x, long int y, int *equ, int *sign, int *unsign);


int main()
{
  long int x, y;
  int equ, sig, unsig;

  x=  100;
  y = 100;

  compare(x, y, &equ, &sig, &unsig);
  printf("x = %ld, y = %ld, equ = %d, sig = %d, unsig = %d\n",
                       x, y, equ, sig, unsig);

  x=  999;
  y = 100;

  compare(x, y, &equ, &sig, &unsig);
  printf("x = %ld, y = %ld, equ = %d, sig = %d, unsig = %d\n",
                       x, y, equ, sig, unsig);

  x=  100;
  y = -1;
  compare(x, y, &equ, &sig, &unsig);
  printf("x = %ld, y = %ld, equ = %d, sig = %d, unsig = %d\n",
                       x, y, equ, sig, unsig);
  x=  -1;
  y = 100;

  compare(x, y, &equ, &sig, &unsig);
  printf("x = %ld, y = %ld, equ = %d, sig = %d, unsig = %d\n",
                       x, y, equ, sig, unsig);

  return 0;

} // main
