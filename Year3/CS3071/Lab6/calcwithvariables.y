
%{
#include <stdio.h>
#include <stdlib.h>
//static std::map<std::string, int> vars;
//char c = '5';
//int x = c - '0';
int alphabet[26] = { 0 };
int yylex ();
void yyerror(char *s);
int error=0;
int errorCount = 0;
%}
%output "calcwithvariables.tab.c"
/* declare tokens */
%token PRINT ASSIGN
%token INT
%token VARIABLE
%token ADD MINUS MUL DIV OPEN CLOSE EOL
%start start1
%%

start1: 
 | start1 printFun EOL{ } 
 ; 

printFun: expr
 | PRINT VARIABLE { if(!error){ int a = $2-'0'-49; printf("%d\n", alphabet[a]); } } 
 ;
 
expr:
 | INT                  { $$ = $1;  }
 | VARIABLE             {  int a = $1-'0'-49; $$= alphabet[a]; }
 | VARIABLE ASSIGN expr { int a = $1-'0'-49; alphabet[a]=$3; }
 //| VARIABLE ASSIGN expr { $$ = vars[*$1] = $3; delete $1; }
 | expr ADD expr      { $$ = $1 + $3; }
 | expr MINUS expr MINUS expr   { $$ = $1 - $3 - $5; }
 | expr MINUS expr    { $$ = $1 - $3; }
 | expr MUL expr { $$ = $1 * $3; }
 | expr DIV expr { $$ = $1 / $3; }
 //| MINUS expr { $$ = -$2; } /// fix a probably this answer should be -4 is 2 a:=1-2-3
 | OPEN expr CLOSE { $$ = $2; }
 ;
/*
factor: term
 | factor MUL term { $$ = $1 * $3; }
 | factor DIV term { $$ = $1 / $3; }
 ;

term:
 | MINUS expr { $$ = -$2; }
 | OPEN expr CLOSE { $$ = $2; }
 ;
 */
%%
int main()
{
  if (!error)
    yyparse();
	
	if (error)
	  yyerror("syntax error");
	
  return 0;
}

void yyerror(char *s)
{
  if(errorCount == 0)
  {
    printf("%s\n", s);
    error=1;
    errorCount++;
  }
}
