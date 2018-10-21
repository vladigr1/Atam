#include <stdio.h>

extern void position_sort(long vect[],int n,long int sorted[]);


int main()
{
	long int arr[20] = {9,5,4,3,5,0,4,7,8,9,
						1,1,2,6,8,7,2,0,3,6};
	long int sorted[20];
	int i;
	position_sort(arr,20,sorted);
	printf("Orignal array:\n");
	for(i=0;i<20;++i){
		printf("%8ld",arr[i]);
	}
	printf("\n");
	printf("Sorted array:\n");
	for(i=0;i<20;++i){
		printf("%8ld",sorted[i]);
	}
	printf("\n");
	return 0;
}