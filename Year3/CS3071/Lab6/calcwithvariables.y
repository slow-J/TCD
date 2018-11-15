
%{
#include <stdio.h>
#include <stdlib.h>
#include <map>
static std::map<std::string, int> vars;
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
 | PRINT VARIABLE { if(!error){ printf("%d\n", $2); } } 
 ;
 
expr: factor
 | INT                  { $$ = $1; }
 | VARIABLE             { $$ = vars[*$1]; delete $1; }
 | VARIABLE ASSIGN expr { $$ = vars[*$1] = $3; delete $1; }
 | expr ADD factor      { $$ = $1 + $3; }
 | expr MINUS factor    { $$ = $1 - $3; }
 ;

factor: term
 | factor MUL term { $$ = $1 * $3; }
 | factor DIV term { $$ = $1 / $3; }
 ;

term:
 | MINUS expr { $$ = -$2; }
 | OPEN expr CLOSE { $$ = $2; }
 ;
 
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
