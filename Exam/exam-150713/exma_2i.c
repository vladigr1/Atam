#include <stdlib.h>

extern long int *cut_series(long int input_arr[],int n,int *size)
{
	long int *temp;
	int i =0,j;
	while( (i+1) <n && input_arr[i] < input_arr[i+1]){
		++i;
	}
	temp = (long int*)malloc(sizeof(long int) * (i+1));
	if (temp == NULL){
		printf("fail malloc\n");
		exit(2);
	}
	for(j=0; j<i+1;++j){
		temp[j] = input_arr[j];
	}
	*size = i+1;
	return temp;
}
extern int sort_series_array(long int *p_arr[], int cnt_arr[], long int input_arr[],int n)
{
	int i = 0,j=0,tempsize;
	while (j < n){
		p_arr[i] = cut_series(input_arr+j,n-j,&tempsize);
		cnt_arr[i]= tempsize;
		j += tempsize;
		++i;
	}
	return i;
}

