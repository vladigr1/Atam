#include <stdio.h>


extern void euler(float (*f)(float, float),float x0, float y0, float h, float yk[], int n);

float f(float x, float y){
	return -2.0*(x*y*y);
} /* f */

int main()
{
	int i;
	float x0, h, yk[10];
	h= 0.1;
	euler(f, 0.0, 1.0, h, yk, 10);
	printf("i       xk         If(xk)         yk\n");
	x0 = 0.0f;
	for(i=0; i < 10; i++) {
		printf("%d, %f,  ,%f   ,%f\n", i, x0, f(x0,yk[i-1]), yk[i]);
		x0 += h;
	}/* for */
	return 0;
} /* main */
