/*
 * assignment1.c
 *
 *  Created on: 4 Oct 2017
 *      Author: slowinsj
 */


// usual includes
#include <stdio.h>
#include <stdlib.h>

// needed for getting access to /dev/random
#include <unistd.h>
#include <sys/syscall.h>
#include <linux/random.h>

// the most we wanna print
#define LIMIT 65536

void usage(char *progname)
{
	fprintf(stderr,"Print some random numbers from /dev/random.\n");
	fprintf(stderr,"Options:\n");
	fprintf(stderr,"\t%s <number> where number is the number of bytes to print [Default: 10, min: 0, max: %d]\n",progname,LIMIT);
	exit(-1);
}

unsigned char rndbyte()
{
	unsigned long int s;
	syscall(SYS_getrandom, &s, sizeof(unsigned long int), 0);
	unsigned char byte=(s>>16)%256;
	return(byte);
}

int main(int argc,char *argv[])
{
	int number=10;

	if (argc==2) {
		int newnumber=atoi(argv[1]);
		if (newnumber<=0) {
			fprintf(stderr,"%d too small\n",newnumber);
			usage(argv[0]);
		}
		if (newnumber>LIMIT) {
			fprintf(stderr,"%d too big\n",newnumber);
			usage(argv[0]);
		}
		number=newnumber;
	}


	for (int i=0;i!=number;i++) {
		unsigned char byte=rndbyte();
		printf("rnd%d: %02x\n",i,byte);
	}

	return(0);
}
