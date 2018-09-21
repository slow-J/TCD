/* */
%{
int allEvens = 0;
int i;
%}

%%
"**"	{ printf("comment\n"); }
[0-9]+	{ i = atoi(yytext); if(i%2==0){allEvens++;} }
\n      {}
.       {}
%%

int main()
{
  yylex();
  printf("%d\n",allEvens);
  return 0;
}
