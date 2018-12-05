#TODO get final edition from trinity computers  
Implement a calculator using Bison that supports variables. Variables can be any of
the 26 lower case letters. Numbers can be in the range zero to nine.  
':=' will be used for assignment and each statement will be terminated by a semicolon.
Whitespace and newlines should be ingored on input.  
Operations used will be addition, subtraction, multiplication and
(integer) division. The calculator should support a unary minus.   
The calculator should support a 'print' command which
prints a variables value followed by a newline.  

Example input:  
a:=6;  
b:=a+7-4;  
print b;  

If an invalid input is detected the program should output the words 
"syntax error" followed by a newline character to standard output
and then exit.  

Your source code should be in two files, calcwithvariables.l and calcwithvariables.y, and
the defaults filenames lex.yy.c calcwithvariables.tab.c calcwithvariables.tab.h should
be generated. Put the two files calcwithvariables.l and calcwithvariables.y only into
a zip archive and use the codemark submit archive page to upload.
Do not use subdirectories.  
Supported archive file formats include Zip, Tar-GZip, Tar-BZip2, RAR, 
7-zip, LhA, StuffIt and other old and obscure formats.


