#include <stdio.h>

extern void compress(long int arr[], int n, long int *base, signed char diff_array[]);



int main()
{
	long int arr[] = {100203, 100209, 100197, 100202, 100220 };
	signed char diff_arr[5];
	long int base;
	int i, n = 5;
	
	printf("Original array:\n");
	for(i=0; i < n; i++){
		printf("%ld\n", arr[i]);
	}
	
	compress(arr, n, &base, diff_arr);
	printf("The compressed array:\n");
	printf("Base = %ld\n", base);
	for(i=0; i < n; i++){
		printf("%d\n", (int) diff_arr[i]);
	}
	return 0;
} /* main */
