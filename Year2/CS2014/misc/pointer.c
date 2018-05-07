
#include <stdio.h>
#include <stdlib.h>
#define VALUE 9

void doubleMyInt(int *a)
{
  *a = (*a) * 2;
}

int main()
{
  int myIntVal = VALUE;
  int *myInt = &myIntVal;
  doubleMyInt(myInt);
  printf("My int value: %d\n", *myInt);
  printf("My int pointer location: %p\n", &myInt);

  return(0);
}
