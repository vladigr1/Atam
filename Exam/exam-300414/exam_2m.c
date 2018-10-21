#include <stdio.h>
#define N 8

extern void update(int i,int n,long int arr[],long int pmax_arr[]);
extern void set(long int x,int i, int n,long int arr[],long int pmax_arr[]);

void printcast(int n,long int arr[],long int pmax_arr[])
{
	int i;
	printf("arr:\t\t");
	for (i =0 ; i <n; ++i){
		printf("%ld\t",arr[i]);
	}
	printf("\n");
	printf("pmax_arr:\t");
	for (i =0 ; i <n; ++i){
	printf("%ld\t",pmax_arr[i]);
	}
	printf("\n");
	printf("\n");
}

int main()
{
	long int arr[N],sum,pmax_arr[N];
	int i;
	for(i=0; i<N; ++i){
		arr[i] = 0;
		pmax_arr[i]=0;
	}
	set(222,5,N,arr,pmax_arr);
	set(888,6,N,arr,pmax_arr);
	set(333,4,N,arr,pmax_arr);
	set(666,3,N,arr,pmax_arr);
	set(444,1,N,arr,pmax_arr);
	set(555,5,N,arr,pmax_arr);
	printcast(N,arr,pmax_arr);
	set(111,3,N,arr,pmax_arr);
	printcast(N,arr,pmax_arr);
	set(999,3,N,arr,pmax_arr);
	set(777,0,N,arr,pmax_arr);
	printcast(N,arr,pmax_arr);
	return 0;
}
	