#include <stdio.h>

//return biggest from (a*b), (a-b), (a+b)
double getbiggest(double a, double b) {
  if(a*b >= a+b && a*b >= a-b) return a*b;
  if(a+b > a-b) return a+b;
  return a-b;
}

double getbiggest_asm(double a, double b);

int main(void) {
  printf("C: %lf, ASM: %lf\n", getbiggest(2,3), getbiggest_asm(2,3));
  printf("C: %lf, ASM: %lf\n", getbiggest(1,0), getbiggest_asm(1,0));
  printf("C: %lf, ASM: %lf\n", getbiggest(0,-1), getbiggest_asm(0,-1));

  return 0;
}
