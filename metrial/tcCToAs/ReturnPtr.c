int * f(int *num)
{
	return num;
}

int main()
{
	int n = 0,*pn;
	pn = f(&n);
	return 0;
}
