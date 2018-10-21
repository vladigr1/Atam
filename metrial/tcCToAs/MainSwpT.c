int global_call = 0;

long int intswap(int *a, int *b,long int c)
{
	int temp = *a;
	static int called=14;
	called++;
	*a = *b;
	*b = temp;
	return c--;
}

int main()
{
	int a =5,b =7;
	long int c =8;
	static int prcalled = 0;
	c = intswap(&a, &b,c);
	prcalled++;
	global_call++;
	return 0;
}
	
	