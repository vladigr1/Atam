#include <stdio.h>
#define N 4


extern int is_dep(int n, long int arr1[],
			long int arr2[], long int arr3[], 
			long int a, long int b, int *indx_ptr);

			
int main()
{
  long int arr1[N] = {1,2,3,4}, arr2[N] = {4, 3, 2, 1 }, 
           arr3[N] = {6, 17, 28, 39}, arr4[N] = {6, 17, 20, 39};
  long int a = 10, b = -1;
  int i, flag, index;

  printf("\narr1:\n");
  for(i=0; i < N; i++)
    printf(" %ld ", arr1[i]);   
  printf("\narr2:\n");
  for(i=0; i < N; i++)
    printf(" %ld ", arr2[i]);   
  printf("\narr3:\n");
  for(i=0; i < N; i++)
    printf(" %ld ", arr3[i]);   

  printf("\na = %ld, b = %ld\n", a,b); 

  flag = is_dep(N, arr1, arr2, arr3, a,  b, &index);
  if (flag == 1)
    printf("arr1, arr2, are (%ld, %ld) dependent\n", a, b);
  else
    printf("arr1, arr2, are NOT (%ld, %ld) dependent, first failare on index %d\n", a, b,index);
  
  flag = is_dep(N, arr1, arr2, arr4, a,  b, &index);
  if (flag == 1)
    printf("arr1, arr2, arr3, are (%ld, %ld) dependent\n", a, b);
  else
    printf("arr1, arr2, arr4, are NOT (%ld, %ld) dependent, first failure on index %d\n", a, b, index);
	return 0;	//added reutn 0 main retrn value
} // main

