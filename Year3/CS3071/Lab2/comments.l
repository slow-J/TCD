/* */
%{
int openBracketCount = 0;
%}

%%
"{"	    { openBracketCount++; }
"}"	    { if (openBracketCount>0) { openBracketCount--; } }
"**".*  {/*comment */} 
[a-zA-Z]+	{ if(openBracketCount==0) { printf("%s", yytext); } }
\n      { if(openBracketCount==0) { printf("\n", yytext); } }
.       {if(openBracketCount==0) { printf("%s", yytext); } }
%%

int main()
{
  yylex();
  return 0;
}
