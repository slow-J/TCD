/* */
%{
  #include <stdio.h>
  #include "calcwithvariables.tab.h"
  extern int error;
  void yyerror(char *s);
  int yylex();
%}
  

%%

"+"	 { return ADD; }
"-"	 { return MINUS; }
"*"	 { return MUL; }
"/"	 { return DIV; }
"{"	 { return OPEN; }
"}"	 { return CLOSE; }
":=" { return ASSIGN; }
[0-9] { atoi(yytext); return INT; }
[a-z] { yylval = yytext[0]; 
        return VARIABLE; }
"print" { return PRINT; }
[ \s\t\r]	|
\n	 { return EOL; }
. { error=1; }
%%

