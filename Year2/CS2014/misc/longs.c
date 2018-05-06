
#include <stdio.h>
#include <stdlib.h>

int main()
{
  unsigned long int longU;
  long int longD;
  printf("whats your unsigned long, and long: ");
  scanf("%lu %ld", &longU, &longD);
  printf("%lu %ld\n", longU, longD);
}
