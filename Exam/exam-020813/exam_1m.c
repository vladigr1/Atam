#include <stdio.h>

extern int solvei(	unsigned int *xptr, unsigned int *yptr, unsigned int a1, unsigned int b1,
					unsigned int c1, unsigned int a2, unsigned int b2, unsigned int c2);
					
					
int main()
{
	unsigned int a1=5,b1=4,c1=140,a2=3,b2=7,c2=130;
	unsigned int x,y;
	int flag;
	flag = solvei(&x,&y,a1,b1,c1,a2,b2,c2);
	printf("System :\n%uX + %uY = %u\n%uX + %uY = %u\n",a1,b1,c1,a2,b2,c2);
	if (flag == 1) {
		printf("Solution: X=%u, Y=%u\n",x,y);
	} else {
		printf("No Solution");
	}
	return 0;
}