#include <stdio.h>

extern void fmul_pow2(float *f, int n);

int main()
{
	float x, y;
	y = x = 7.3125;
	fmul_pow2(&y, 3);
	printf(" x = %f, y = %f\n", x, y);
	return 0;
} /* main */


