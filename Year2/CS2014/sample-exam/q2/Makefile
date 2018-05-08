# -*- Makefile -*-
# easiest way to explain in exam

all: mainfsize

mainfsize: mainfsize.o fsize.o
	gcc mainfsize.o fsize.o -o mainfsize

mainfsize.o: mainfsize.c fsize.h
	gcc -c mainfsize.c

fsize.o: fsize.c fsize.h
	gcc -c fsize.c

clean:
	 rm -f *.o mainfsize
