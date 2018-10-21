/*
;
;	The value in arr is sign
;
*/

int is_dep(int n, long int arr1[],
			long int arr2[], long int arr3[], 
			long int a, long int b, int *indx_ptr)
{
	int i;
	for (i = 0; i <n; ++i){
		if(a*arr1[i] + b*arr2[i] != arr3[i]) {
			*indx_ptr = i;
			return 0;
		}
	}
	return 1;
}