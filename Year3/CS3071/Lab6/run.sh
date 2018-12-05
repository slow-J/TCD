#!/bin/bash
clear
bison -d calcwithvariables.y
flex calcwithvariables.l
gcc calcwithvariables.tab.c lex.yy.c -lfl
./a.out
