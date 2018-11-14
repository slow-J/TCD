
%{
#include <stdio.h>
#include <stdlib.h>
int yylex ();
void yyerror(char *s);
void intToRoman(int number);
int digit(char ch, int n, int i, char *c);
int sub_digit(char num1, char num2, int i, char *c); 
int error=0;
int p=0;  //prev 
int errorCount = 0;
%}
%output "romcalc.tab.c"
/* declare tokens */
%token I IV V IX X XL L XC C CD D CM M
%token ADD SUB MUL DIV OPEN CLOSE EOL
%start start1
%%

start1: 
 | start1 expr EOL{ if(!error){ intToRoman($2); p=0; }} 
 ; 

expr: factor
 | expr ADD factor { $$ = $1 + $3; }
 | expr SUB factor { $$ = $1 - $3; }
 ;

factor: term
 | factor MUL term { $$ = $1 * $3; }
 | factor DIV term { $$ = $1 / $3; }
 ;

term: no
 | term no { int a=$1; p=0; int b =$2; $$ = a + b; }
 | OPEN expr CLOSE { $$ = $2; }
 ;

no:  
 | I  { $$ = 1; p=1;}
 | IV { if(p==1){error=1;}
        else{$$ = 4; p=4; } }
 | V  { if(p==4||p==5){error=1;}
        else{$$ = 5; p=5; } }
 | IX { if(p==5){error=1;}
        else{$$ = 9; p=9; } }
 | X  { if(p==9){error=1; }
        else{$$ = 10; p=10; } }
 | XL { if(p==10){error=1; }
        else{$$ = 40; p=40; } }
 | L  { if(p==40){error=1; }
        else{$$ = 50; p=50; } }
 | XC { if(p==50){error=1; }
        else{$$ = 90; p=90; } }
 | C  { if(p==90||p==900){error=1; }
        else{$$ = 100; p=100; } }
 | CD { if(p==100){error=1; }
        else{$$ = 400; p=400; } }
 | D  { if(p==400){error=1; }
        else{$$ = 500; p=500; } }
 | CM { if(p==500){error=1; }
        else{$$ = 900; p=900; } }
 | M  { if(p==900){error=1; }
        else{$$ = 1000; p=1000; } }       
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
void intToRoman(int number)
{
  char c[10001]; 
  int i = 0; 
  int nFlag =0;
  if (number == 0) 
  { 
    printf("Z\n"); 
    return; 
  }
  if (number < 0) 
  { 
    nFlag=1;
    number= abs(number); 
  }  
  while (number != 0) 
  {      
    if (number >= 1000) 
    { 
      i = digit('M', number/1000, i, c); 
      number = number%1000; 
    } 
    else if (number >= 500) 
    { 
      if (number < 900) 
      { 
        i = digit('D', number/500, i, c); 
        number = number%500; 
      }
      else
      { 
        i = sub_digit('C', 'M', i, c); 
        number = number%100 ; 
      } 
    } 
    else if (number >= 100) 
    { 
      if (number < 400) 
      { 
        i = digit('C', number/100, i, c); 
        number = number%100; 
      } 
      else
      { 
        i = sub_digit('C','D',i,c); 
        number = number%100; 
      } 
    } 
    else if (number >= 50 ) 
    { 
      if (number < 90) 
      { 
        i = digit('L', number/50,i,c); 
        number = number%50; 
      } 
      else
      { 
        i = sub_digit('X','C',i,c); 
        number = number%10; 
      } 
    } 
    else if (number >= 10) 
    { 
      if (number < 40) 
      { 
        i = digit('X', number/10,i,c); 
        number = number%10; 
      } 
      else
      { 
        i = sub_digit('X','L',i,c); 
        number = number%10; 
      } 
    } 
    else if (number >= 5) 
    { 
      if (number < 9) 
      { 
        i = digit('V', number/5,i,c); 
        number = number%5; 
      } 
      else
      { 
        i = sub_digit('I','X',i,c); 
        number = 0; 
      } 
    } 
    else if (number >= 1) 
    { 
      if (number < 4) 
      { 
        i = digit('I', number,i,c); 
        number = 0; 
      } 
      else
      { 
        i = sub_digit('I', 'V', i, c); 
        number = 0; 
      } 
    } 
  } 
  if(nFlag==1)
  { 
    printf("-"); 
  }
  int j;
  for (j = 0; j < i; j++) 
    printf("%c", c[j]); 
  printf("\n");
}
int sub_digit(char num1, char num2, int i, char *c) 
{ 
  c[i++] = num1; 
  c[i++] = num2; 
  return i; 
} 
int digit(char ch, int n, int i, char *c) 
{ 
  int j;
  for ( j = 0; j < n; j++) 
    c[i++] = ch; 
  return i; 
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
