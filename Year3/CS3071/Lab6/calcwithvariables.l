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
[0-9]   { yylval = atoi(yytext); return INT; }
[a-z]   { yylval = yytext[0]; return VARIABLE; }
"print" { return PRINT; }
";"     { return EOL; }
[ \s\t\r\n] { }
.       { error=1; }
%%

