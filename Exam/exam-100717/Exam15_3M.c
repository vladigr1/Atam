#include <stdio.h>

extern double find_discontinue_point(double(*f)(double), double x1, double x2, double h);

double f(double x)
{
	if (x<3.5) return 10*x;
	else return 10*x + 0.25;
}

int main()
{
	double xstar,x1 = 0.0, x2 = 12.0, eps = 0.001;
	xstar = find_discontinue_point(f,x1,x2,eps);
	printf("xstar = %lf\n",xstar);
	return 0;
}