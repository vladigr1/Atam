double myabs(double x)
{
	if(x < 0) return -1*x;
	return x;
}
double compute_x(double y,double x1,double y1,double x2,double y2)
{
	return ((x2-x1)*(y-y1)) / (y2-y1) + x1;
}

extern double find_x(double (*f)(double),double y,double x,double h,double eps)
{
		double x0 = x;
		double h0 = h;
	while(myabs(y- f(x0)) > eps){
		double y1,y2,x1,x2;
		x1 = x0+h0;
		x2 = x0-h0;
		y1 = f(x1);
		y2 = f(x2);
		x0 = compute_x(y,x1,y1,x2,y2);
		h0 /= 2;
	}
	return x0;
}