#include <stdio.h>

extern long int *find_value(long int arr[], int n, long int v);

int main()
{
  long int arr1[6] = {1.0, 2.0, 3.0, 4.0, 5.0, 6.0};
  long int value;
  int i;

  printf(" arr1:\n");
  for(i=0; i < 6; i++){
     printf("  arr1[%d] = %5ld", i, arr1[i]);
  }

  value = *find_value(arr1, 6, 3);

  printf("\n\nFind1: value = %ld\n", value);

  value = *find_value(arr1, 6, 47);

  printf("\n\nFind2: value = %ld\n", value);

  *find_value(arr1, 6, 4) = 888;

  printf("\n\nFind3: arr1:\n");
  for(i=0; i < 6; i++)
     printf("   arr1[%d] = %5ld", i, arr1[i]);

  return 1;
} // main
