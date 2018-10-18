
Write a Bison program that takes a series of uppercase Roman 
numerals as input, parses them, and takes semantic actions to 
compute and print the corresponding Hindu-Arabic numeral.

Test cases will be newline seperated lists of Roman numerals and 
the program should output the corresponding Hindu-Arabic numeral 
followed by a new line for each one. 

If an invalid number is detected the program should output the words 
"syntax error" followed by a newline character to standard output
and then exit.

Your source code should be in two files, roman.l and roman.y, and
the defaults filenames lex.yy.c roman.tab.c roman.tab.h should
be generated. Put the two files roman.l and roman.y only into
a zip archive and use the codemark submit archive page to upload.
Do not use subdirectories.
Supported archive file formats include Zip, Tar-GZip, Tar-BZip2, RAR, 
7-zip, LhA, StuffIt and other old and obscure formats.

The Roman numeral system for representing numbers was developed 
around 500 b.c.

As the Romans conquered much of the world that was known to them, 
their numeral system spread throughout Europe, where Roman numerals 
remained the primary manner for representing numbers for centuries. 
Around a.d. 1300, Roman numerals were replaced throughout most of 
Europe with the more effective Hindu-Arabic system still used today.


Roman numerals, as used today, are based on seven symbols
Symbol 	I 	V 	X 	L 	C 	D 	M
Value 	1 	5 	10 	50 	100 	500 	1,000 

The original pattern for Roman numerals used the symbols I, V, and X 
(1, 5, and 10) as simple tally marks. Each marker for 1 (I) added a 
unit value up to 5 (V), and was then added to (V) to make the 
numbers from 6 to 9:

            I, II, III, IIII, V, VI, VII, VIII, VIIII, X.

The numerals for 4 (IIII) and 9 (VIIII) proved problematic (among 
other things, they are easily confused with III and VIII), and are 
generally replaced with IV (one less than 5) and IX (one less than 10). 
This feature of Roman numerals is called subtractive notation.

The numbers from 1 to 10 (including subtractive notation for 4 and 9) 
are expressed in Roman numerals as follows:

            I, II, III, IV, V, VI, VII, VIII, IX, X.

The system being basically decimal, tens and hundreds follow the same pattern:

Thus 10 to 100 (counting in tens, with X taking the place of I, L taking the 
place of V and C taking the place of X):

            X, XX, XXX, XL, L, LX, LXX, LXXX, XC, C.

Note that 40 (XL) and 90 (XC) follow the same subtractive pattern as 4 and 9.

Similarly, 100 to 1000 (counting in hundreds):

            C, CC, CCC, CD, D, DC, DCC, DCCC, CM, M.

Again - 400 (CD) and 900 (CM) follow the standard subtractive pattern. 

