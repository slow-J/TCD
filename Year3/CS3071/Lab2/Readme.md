Assignment 2. 

Write a flex program comments.l which removes comments from a slightly odd 
programming language and sends the remaining code to its output.

** means regard the two asterisks and all following characters on that line as comment.

anything between { and } is comment, potentially across multiple lines.

a { inside a comment is just part of the comment.

a { not followed by } or a } not preceded by a matching {
is regarded as a syntax error and your program
should output the phrase "syntax error\n" in place of the
the remaining input and exit when it detects this.

between double-quote characters {} and ** are regarded as part of a
string and dont indicate comments.

there's no facility to put a double-quote inside a string.

Note put return 0; at end of the main function
as codemark regards non zero exit status as an error. 
