#include <Stdio.h>
float poly1(float x);
extern float steffensen(	float (*fun)(float),	float x0,	float eps);

int main (){
  float x;
  x = steffensen(poly1, 4.4f, 0.0001f);
  printf("\nSolution to poly1(x) = 0, x = %f, f(%f) = %f\n",
        x, x, poly1(x));
  return 0;
} /* main */

float poly1(float x){
  return (x*x*x - 100.0);
} /* poly */
