#include <stdio.h>

extern long double ld_trapezoid(long double a, long double b, long double h);

long double ldf(long double x){
 return x*x; 
} 

long double Ildf(long double x){
 return x*x*x/3.0;
}

int main(){
printf("Integral x**2(0,2)\n");
printf("real value: %22.18Lf, Trapezoid: %22.18Lf\n", 
Ildf(2.0)-  Ildf(0.0),  ld_trapezoid(0.0, 2.0, 0.0001));
 return 0;
} /* main */
