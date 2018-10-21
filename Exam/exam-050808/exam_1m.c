#include <stdio.h>

extern  void get_regs(unsigned int *ip, unsigned int *sp,unsigned int *cs, unsigned  int *bp);


int main()
{
	unsigned int ip,sp,cs,bp;
	get_regs(&ip,&sp,&cs,&bp);
	printf(" ip %u, sp %u, cs %u, bp %u,\n",ip,sp,cs,bp);
	return 0;
}
