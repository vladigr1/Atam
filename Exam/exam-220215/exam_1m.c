#include <stdio.h>

extern unsigned int max_k(unsigned int p);
extern int check_solution(unsigned int p, unsigned int k,unsigned int n, unsigned int rem);
extern int search_solution(unsigned int p, unsigned int n, unsigned int rem);

int main()
{
	unsigned int k,p,n,rem;
	n= 17;
	p= 3;
	rem= 13;
	k= search_solution(p,n,rem);
	printf("p = %u, n= %u, rem= %u, k= %d\n",p,n,rem,k);
	return 0;
}