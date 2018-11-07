/* */
%{
  #include <stdio.h>
  #include "romcalc.tab.h"
  extern int error;
  void yyerror(char *s);
  int yylex();
%}
  

%%

"+"	 { return ADD; }
"-"	 { return SUB; }
"*"	 { return MUL; }
"/"	 { return DIV; }
"I"	 { return I; }
"IV" { return IV; }
"V"	 { return V; }
"IX" { return IX; }
"X"	 { return X; }
"XL" { return XL; }
"L"	 { return L; }
"XC" { return XC; }
"C"	 { return C; }
"CD" { return CD; }
"D"	 { return D; }
"CM" { return CM; }
"M"	 { return M; }
[ \s\t\r]	|
\n	 { return EOL; }
. { error=1; }
%%

