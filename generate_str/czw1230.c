#include <stdio.h>
#include <stdlib.h>

char* generate_str(char* s, int c, int n, int inc) {
  int i;
  if(inc) inc = 1;
  for(i = 0; i < n; ++i) {
    s[i] = c;
    c += inc;
  }
  s[n] = '\0';
  return s;
}

char* generate_str_asm(char* s, int c, int n, int inc);

int main(void) {
  char* testStr = malloc(sizeof(char)*10);
  printf("C func:\n%s\n", generate_str(testStr, 'a', 7, 0));
  printf("%s\n", generate_str(testStr, 'b', 3, 1));

  printf("Asm func:\n%s\n", generate_str_asm(testStr, 'a', 7, 0));
  printf("%s\n", generate_str_asm(testStr, 'b', 3, 1));
  return 0;
}
