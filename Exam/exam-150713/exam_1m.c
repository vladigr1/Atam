#include <stdio.h>
#define N 10

extern int power2n(int n);
extern int isbitk(int value, int k);
extern int split(int arr[],int arr0[],int arr1[],int n,int k);

int main()
{
	int arr[N]= {10,11,12,13,14,15,16,17,18,19};
	int arr0[N],arr1[N];
	int i,j;
	j = split(arr,arr0,arr1,N,3);
	printf("\narr:\n");
	for (i=0; i < N; ++i){
		printf("%d ",arr[i]);
	}
	printf("\narr0:\n");
	for (i=0; i < j; ++i){
		printf("%d ",arr0[i]);
	}
	printf("\narr1:\n");
	for (i=0; i <N-j; ++i){
		printf("%d ",arr1[i]);
	}
	return 0;
}
	