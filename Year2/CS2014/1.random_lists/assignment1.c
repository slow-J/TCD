
/* 
 * Copyright (c) 2017 stephen.farrell@cs.tcd.ie
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
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
	fprintf(stderr,"\t%s <number> where number is the number of times to print min: 0, max: %d]\n",progname,LIMIT);
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
	int currentNo=0;
	int finalNo=0;
	FILE *fp = NULL;
	if (argc==3) 
	{	
		char *ProgFile;
		ProgFile = argv[2];
		fp = fopen(ProgFile, "w");
		if (fp==NULL)
		{
			fprintf(stderr,"error with file");
		}
		int newnumber = atoi(argv[1]);
		if (newnumber<=0)
		{
			fprintf(stderr,"%d too small\n",newnumber);
			usage(argv[0]);
		}
		if (newnumber>LIMIT)
		{
			fprintf(stderr,"%d too big\n",newnumber);
			usage(argv[0]);
		}
		finalNo=newnumber;
	}
	while(currentNo<finalNo)
	{
		unsigned char randomNo=rndbyte();
				
		fprintf(fp, "%d,%02x",currentNo, randomNo);
		int i;
		for (i=0; i<(int)randomNo; i++)
		{	
			if(i%8==0)
			{
				fprintf(fp, "\n");
			}
			if(i==randomNo-1)
			{
				unsigned char byte=rndbyte();
				fprintf(fp, "%02x\n\n", byte);
			}
			else
			{	  
				unsigned char byte=rndbyte();
				fprintf(fp, "%02x,", byte);
			}
		}
		currentNo++;
	}
	fclose(fp);
	return(0);
}
