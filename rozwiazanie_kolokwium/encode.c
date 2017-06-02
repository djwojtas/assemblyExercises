#include <stdio.h>
#include <stdlib.h>
 
char* encode(char* buf, unsigned int mask, int operation, int character);
 
//buf string
//szukamy cyfr na ktore wskazuje maska
//10 najm bitow okresla to co trzeba zrobic ze znakiem (ktory znak)
//b0 - 0, b1 - 1, b2- itp do 9
//pojawienie sie 1 na danym bicie znaczy ze trzeba ten znak uwzgl
//opertion 0-nic z niczym 1-remove, usuwa cyfre 2-zamiana cyferek (9->0) (0->9) (8->1) itp
// 3 - konkretna cyfra zamieniona 4 parametrem
 
 
int main(void) {
  char* str = malloc(sizeof(char)*20);
 
  printf("Mask 00110011, character 'a' (should change 0,1,4 and 5)\n\n");
  sprintf(str, "abCDD$012345sdf65");
  printf("Oryginal string:  %s\n", str);
  sprintf(str, "abCDD$012345sdf65");
  printf("No operation (0): %s\n", encode(str, 0x33, 0, 'a'));
  sprintf(str, "abCDD$012345sdf65");
  printf("Remove (1):       %s\n", encode(str, 0x33, 1, 'a'));
  sprintf(str, "abCDD$012345sdf65");
  printf("Transpose (2):    %s\n", encode(str, 0x33, 2, 'a'));
  sprintf(str, "abCDD$012345sdf65");
  printf("Change (3):       %s\n", encode(str, 0x33, 3, 'a'));
 
  free(str);
  return 0;
}
