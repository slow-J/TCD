/* */
%{
  int currentYear=2018;
  int workingNo=0;
  int lengthOfYear=0;
  int digit3=1;     //true
  int yearOpen=1;
  int invalid=0;
%}

YEAR    [0-9]
COUNTY  C|CE|CN|CW|D|DL|G|KE|KK|KY|L|LD|LH|LM|LS|MH|MN|MO|OY|RN|SO|T|W|WH|WX|WW
OLDC    LK|TN|TS|W|WD
NUMBER  [0-9] 
INVALID T
NUM     [a-Z]
%%
{YEAR}  { if(yearOpen)
    	    {
    	      lengthOfYear++;  
    	      workingNo= workingNo*10 + atoi(yytext);
    	      if((lengthOfYear==1) && (workingNo!=1)){digit3=0;}
    	      if((lengthOfYear==2) && (digit3==1))
    	      { 
    	        if(atoi(yytext)>=3){digit3=1;}
    	        else{digit3=0;}        
    	      }
    	      
    	      if((lengthOfYear==2)&&(digit3==0)){yearOpen=0;}      
    	      if(lengthOfYear==3){yearOpen=0;}
    	      }
    	    }
{YEAR}-{INVALID}-{NUMBER}  { if(digit3==0){invalid=1;}}

-{COUNTY}-{NUMBER} {  }
            
\n      {
        if(yearOpen==0)
        { 
          if(invalid)
          {
              printf("INVALID\n");
          }
          else
          {
                     int year=0;
                     if(lengthOfYear==3)
                     {
                       year=2000 + workingNo/10;
                       year= currentYear-year;                      
                     }
                     else if(lengthOfYear==2)
                     {
                       if(workingNo>86)
                       {
                         year = 1900 + workingNo;
                         year = currentYear - year;
                       }
                       else
                       {
                         year = 2000 + workingNo;
                         year = currentYear - year;
                       }
                     }
                     printf("%d\n", year);
         }
         }                  
workingNo=0; lengthOfYear=0; yearOpen=1; digit3=1; invalid=0;//reset all flags

}
.       {}
%%

int main()
{  
  yylex();
 
  return 0;
}
