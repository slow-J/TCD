//pointers as function parameters

#include <stdio.h>
#include <stdlib.h>

void min_max(int a, int b, int *min, int *max)
{
  if (a>b)
  {
    *max=a;
    *min=b;
  }
  else
  {
    *max=b;
    *min=a;
  }
}

int main()
{
  int x,y;
  int small, big;
  printf("Two integers: ");
  scanf("%d %d", &x, &y);
  min_max(x, y, &small, &big);
  printf("%d <= %d", small, big);
  return(0);
}
