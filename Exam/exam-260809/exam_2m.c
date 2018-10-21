#include <stdio.h>
#include <stdlib.h>


extern long int **init2dim(int n, int m);
extern void set2dim(long int *arr[], long int v, int i, int j);
extern long int get2dim(long int *arr[], int i, int j);

int main(void){
	int i, j, k;
	long int **array1;
	int n = 4, m = 3;
	array1 = init2dim(n,m);
	puts("\n----------------------------------------------");
	puts("Simulated matrix:");
	for(i = 0; i < m; i++){
		for(j = 0; j < n; j++){
			set2dim(array1,10*i+j, i, j);
			printf("%d           ",i);
		}
		putchar('\n');
		} /* for */
		for(i = 0; i < m; i++){
		for(j = 0; j < n; j++) printf("%10ld",get2dim(array1, i, j));
			putchar('\n');
		} /* for */
	return 0;
} /* main */
