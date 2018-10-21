#include <stdio.h>

extern long double vector_length(long double arr[], int n);

int main()
{
	long double arr[] = {1.0, 2.0, 3.0, 4.0};
	printf( "vector_length %Lf\n",vector_length(arr,4));
	return 0;
}