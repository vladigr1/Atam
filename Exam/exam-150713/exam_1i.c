int power2n(int n)
{
	int i,num=1;
	for(i=0;i<n;++i){
		num*=2;
	}
	return num;
}

int isbitk(int value, int k)
{
	if(value & power2n(k)) return 1;
	return 0;
}

int split(int arr[],int arr0[],int arr1[],int n,int k)
{
	int i,j=0,l=0;
	for( i =0; i <n; ++i){
		if (isbitk(arr[i],k)){
			arr1[l] = arr[i];
			++l;
		} else {
			arr0[j] = arr[i];
			++j;
		}
	}
	return j;
}