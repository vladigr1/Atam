#include <stdio.h>

extern float vector_length(float arr[], int n);

int main()
{
	float arr[] = {1.0, 2.0, 3.0, 4.0};
	printf( "vector_length %f\n",vector_length(arr,4));
	return 0;
}