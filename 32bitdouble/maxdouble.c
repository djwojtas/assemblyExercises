#include <stdio.h>

//return biggest from (a*b), (a-b), (a+b)
double getbiggest(double a, double b) {
  if(a*b >= a+b && a*b >= a-b) return a*b;
  if(a+b > a-b) return a+b;
  return a-b;
}

double getbiggest_asm_32(double a, double b);

int main(void) {
  printf("C: %lf, ASM: %lf\n", getbiggest(2,3), getbiggest_asm_32(2,3));
  printf("C: %lf, ASM: %lf\n", getbiggest(1,0), getbiggest_asm_32(1,0));
  printf("C: %lf, ASM: %lf\n", getbiggest(0,-1), getbiggest_asm_32(0,-1));

  return 0;
}
