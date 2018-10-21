#include <stdio.h>

extern  float  fsection(float x,  float y, float eps);

float f_func(float x)
{
  return (x-2.5)*(x-2.5)+ 9.0;
} /*f_func */


int main()
{
 float x;
 x = fsection( -3.0, 7.0, 0.0001);
 printf("Min solution x = %f, min value = %f\n", x, f_func(x));
 return 0;
} /* main */

