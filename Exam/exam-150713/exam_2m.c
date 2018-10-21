#include <stdio.h>

extern double compute_x(double y,double x1,double y1,double x2,double y2);
extern double find_x(double (*f)(double),double y,double x,double h,double eps);

double sqrx(double x){
	return x*x;
}

int main()
{
	double x,y=10,x0=3,h=0.5,eps=0.000001;
	x= find_x(sqrx, y, x0,h,eps);
	printf("Inverse of qrx ar %lf with approx %lf = %lf\n",y,x0,x);
	return 0;
}