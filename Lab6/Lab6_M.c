#include <stdio.h>
#include <stdlib.h>
#include <time.h>


extern void quickSort(double* arr, int count); 
/*int main()
{
    int i;
    double arr[] = {0, 4.0, 2.0, 8.0, 3.0 };
	srand((unsigned)time(0));
	quickSort(arr,5);
	for(i=0; i <5; ++i){
	printf("%lf ",arr[i]);
	}
	putch('\n');
	return 0;
}*/

int main()
{
    int i;
    double arr[] = { -1.6, 25.4, -58964.3434, 8547.12, -119.444, 0.3, 78596.34 };
	srand((unsigned)time(0));
    quickSort(arr , sizeof(arr) / sizeof(arr[0]));
    for (i = 0 ; i < sizeof(arr) / sizeof(arr[0]); i++ )
        printf("%lf ", arr[i]);
    return 0;
}