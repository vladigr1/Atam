#include <stdio.h>
#include <time.h>
#include <stdlib.h>

#define SIZE 1000

extern int sum2Opt(void ** arr,
	int size,
    int(*cmpSum)(void *, void *, void *), void *z);

extern int sum3Opt(void ** arr, int size,
    int(*sumCmp2)(void ** arr, int size, int(*cmpSum)(void *, void *, void *), void *z),
    int(*cmpSum)(void *, void *, void *),
    void* (*sub)(void * a, void *b),
    void *z);

int cmpSum2Int(void * a, void *b, void * c)
{
    return (*(int*)c - (*(int*)a + *(int*)b));
}

int cmpSum3Int(void * a, void *b, void * c, void *z)
{
    return (*(int*)z - (*(int*)a + *(int*)b + *(int*)c));
}

int sum3(void ** arr, int size, int(*cmp3Sum)(void *, void *, void *, void *), void *z)
{
    int i, j, k;

    for (i = 0; i < size - 2; i++)
        for (j = i + 1; j < size - 1; j++)
            for (k = j + 1; k < size; k++)
                if (!cmp3Sum(arr[i], arr[j], arr[k], z))
                    return 1;
    return 0;
}

void * subInt(void * a, void *b)
{
    int *temp = (int *)malloc(sizeof(int));		//need to free
    *temp = *(int *)a - *(int *)b;

    if (*temp > 0)
        return temp;
    return 0;
}

void  main()
{
	time_t t1, t2;
	int temp, i, j, arr[SIZE], *arrp[SIZE], z = 30000;
	srand((unsigned)time(0));

	for (i = 0; i < SIZE; i++)
	{
		arr[i] = rand();
		arrp[i] = &arr[i];
	}
	printf("start : \n");
	(void)time(&t1);
	sum3((void **)arrp, SIZE, cmpSum3Int, (void *)&z);
	(void)time(&t2);
	printf("sum2 end Time = %ld seconds\n", (long)(t2 - t1));

	arr[0] = rand();
	arrp[0] = &arr[0];


	for (i = 1; i < SIZE; i++)
	{
		temp = rand();
		if (temp < arr[i - 1])
			temp = arr[i - 1];
		arr[i] = temp;
		arrp[i] = &arr[i];
	}

	(void)time(&t1);

	printf("start opt : \n");

	sum3Opt((void **)arrp, SIZE, sum2Opt, cmpSum2Int, subInt, (void *)&z);
	(void)time(&t2);
	printf("sum2Opt end Time = %ld seconds\n", (long)(t2 - t1));
}
