#include <stdio.h>

extern int is_pitag(unsigned int n, unsigned int *Px, unsigned int *Py);

int main()
{
	int n=73,x,y;
	if(is_pitag(n,&x,&y) ){
		printf("n = %d , x = %d , y = %d\n",n,x,y);
	} else {
	printf("their is none\n");
	}
	return 0;
}