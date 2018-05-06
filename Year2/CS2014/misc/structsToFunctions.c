
#include <stdio.h>
#include <stdlib.h>

struct pairInt
{
  int min, max;
};

struct pairInt min_max(int a, int b)
{
  struct pairInt pair;
  pair.min = (a>b) ? b:a;
  pair.max = (a>b) ? a:b;
  return pair;
};

int main()
{
  int x,y;
  struct pairInt result;
  puts("Give two integers: ");
  scanf("%d %d", &x, &y);
  result = min_max(x, y);
  printf("%d <= %d\n", result.min, result.max);
  return(0);
}
