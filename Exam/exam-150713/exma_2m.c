#include <stdio.h>

extern long int *cut_series(long int input_arr[],int n,int *size);
extern int sort_series_array(long int *p_arr[], int cnt_arr[], long int input_arr[],int n);

int main()
{
	long int arr[20] = {23,11,-71,-63,22,55,51,73,17,-19,-65,44,95,66,82,-15,49,30,54,-34};
	int count[20],i,j,n=20,num;
	long int *parr[20];
	num = sort_series_array(parr,count,arr,n);
	printf("Oringinal array:\n");
	for(i=0;i<n;++i){
		printf("%ld ",arr[i]);
	}
	printf("\ntable:\n");
	for(i=0;i<num;++i){
		printf("\n%d:",i);
		for(j=0;j<count[i];++j){
			printf(" %ld",parr[i][j]);
		}
	}
	return 0;
}