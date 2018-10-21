typedef char INT64[8];
extern void INT64tostr( char str[], INT64 *ptr );
extern void addINT64( INT64 *ptr3,  INT64 *ptr1,	INT64 *ptr2 );

int main(){
 INT64 f1= {1, 0}, f2 = {1, 0}, f3;
 char str[20];
 int i;
 for(i=3; i < 75; i++) {
addINT64(&f3, &f1, &f2);
INT64tostr(str, f3);
printf("Fibo(%d) = %s\n", i, str);
memcpy(f1,f2,8);//copy 8 bytes from f2 to f1
memcpy(f2,f3,8);
 }// for
 return 0;
} // main
