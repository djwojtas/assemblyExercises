#include <stdio.h>
#include <stdlib.h>

unsigned long check_tab(int* tab, int n, int* max);

int main(void) {
  printf("%ld\n", sizeof(unsigned int));

  int n = 8;
  int* tab = malloc(sizeof(int)*n);
  int* max = malloc(sizeof(int));

  tab[0] = 3;
  tab[1] = 2;
  tab[2] = 1;
  tab[3] = 3;
  tab[4] = 10;
  tab[5] = 3;
  tab[6] = 2;
  tab[7] = 4;

  unsigned long result = check_tab(tab, n, max);
  int i;

  printf("RETURN: ");
  for(i = 63; i >= 0; --i) {
    printf("%d", result & (((long)0x01)<<i) ? 1 : 0);
  }
  printf("\nMAX: %d\n", *max);

  return 0;
}
