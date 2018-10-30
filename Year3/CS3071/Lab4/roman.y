
%{
#  include <stdio.h>
int yylex ();
void yyerror(char *s);
int error=0;
int total=0;
int p=0;  //prev 
%}
%output "roman.tab.c"
/* declare tokens */
%token I IV V IX X XL L XC C CD D CM M
%token EOL
%start start1
%%

start1: 
 | start1 expr EOL{ if(!error){printf("%d\n", total);}
    total=0; p=0;
   }
 ; 

expr: exp | exp expr

exp:  
 | I  { total += 1; p=1;}
 | IV { if(p==1){error=1;}
        else{total += 4; p=4; } }
 | V  { if(p==4){error=1;}
        else{total += 5; p=5; } }
 | IX { if(p==5){error=1;}
        else{total += 9; p=9; } }
 | X  { if(p==9){error=1; }
        else{total += 10; p=10; } }
 | XL { if(p==10){error=1; }
        else{total += 40; p=40; } }
 | L  { if(p==40){error=1; }
        else{total += 50; p=50; } }
 | XC { if(p==50){error=1; }
        else{total += 90; p=90; } }
 | C  { if(p==90||p==900){error=1; }
        else{total += 100; p=100; } }
 | CD { if(p==100){error=1; }
        else{total += 400; p=400; } }
 | D  { if(p==400){error=1; }
        else{total += 500; p=500; } }
 | CM { if(p==500){error=1; }
        else{total += 900; p=900; } }
 | M  { if(p==900){error=1; }
        else{total += 1000; p=1000; } }       
 ;
 
%%
int main()
{
  if (!error)
  {
	  yyparse();
	}
	if (error)
	{
	  yyerror("syntax error");
	}
  return 0;
}

void yyerror(char *s)
{
  printf("%s\n", s);
  error=1;
}
