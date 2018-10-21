#include <stdio.h>

extern double find_delta1(double (*f)(double),double x0, double eps);
extern double find_delta2(double (*f)(double),double x1, double x2,double h, double eps);


double mysqr(double x)
{
  return x*x;
} // mysqr


int main()
{
  double x1 = -0.5, x2 = -0.1, x, eps=0.001, h=0.01;

  x = (x1+x2)/2.0;
  printf("\nfind_delta1(mysqr,%lf, %lf) = %lf\n", x, eps,find_delta1(mysqr,x,eps));
  printf("\nfind_delta2(mysqr, %lf, %lf,%lf, %lf) = %lf\n",x1, x2, h, eps, find_delta2(mysqr,x1, x2, h, eps));
	return 0;
} // main
