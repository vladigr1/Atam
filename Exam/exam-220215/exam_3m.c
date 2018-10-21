#include <stdio.h>

extern int compare_h(double(*f)(double),double x,double h);
extern double search_h(double(*f)(double),double x1,double x2,double h);

double myfun(double x)
{
	double temp;
	temp = 5*x*x - x*x*x/3;
	return temp;
}

int main()
{
	printf("search_h(myfun, 0.0, 100.0, 0.0001) = %lf\n",search_h(myfun, 0.0, 100.0, 0.0001));
	return 0;
}