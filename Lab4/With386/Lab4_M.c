#include <stdio.h>


extern int isPowTwo(long x);
extern int getPowTwo(long x);
extern long getDiv(long x, int k);
extern int prothNumber(long x, int *k, int *n);
extern long getPNum();


int  main()
{
    int k, n;
    long num = getPNum();
    if (prothNumber(num, &k, &n))
        printf("%lu = (%d*(2^%u)+1 is Proth Number", num, k, n);
    else
        printf("%lu is not Proth Number", num);
    return 0;
}
