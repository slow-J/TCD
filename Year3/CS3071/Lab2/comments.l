/* */
%{
int openBracketCount = 0;
int syntaxError = 0;
%}

%%
"{"	    { openBracketCount = 1; }
"}"	    { if (openBracketCount>0) { openBracketCount = 0; }
          else { syntaxError=1; } }
L?\"(\\.|[^\\"])*\"	{ if(openBracketCount==0 && syntaxError==0) { printf("%s", yytext); } }
"**".*  {/*comment */} 
[a-zA-Z]+	{ if(openBracketCount==0 && syntaxError==0) { printf("%s", yytext); } }
\n      { if(openBracketCount==0 && syntaxError==0) { printf("\n"); } }
.       { if(openBracketCount==0 && syntaxError==0) { printf("%s", yytext); } }
%%

int main()
{
  
  yylex();
  if (syntaxError==1||openBracketCount!=0)
  {
    printf("syntax error\n");
  }
  return 0;
}
